// "Delete account" flow: permanently deletes the calling user's Supabase
// Auth account and every row they own.
//
// Deleting the auth.users row cascades (ON DELETE CASCADE, see
// supabase/migrations/20260730120000_persistence_hardening.sql and
// 20260727_sick_plants.sql) through public.profiles, public.users,
// public.plants, public.care_tasks, public.sick_plants and
// public.diagnosis_messages automatically — nothing to do by hand there.
// What does NOT cascade is Storage: objects in the "plant-images" bucket
// are named "{user_id}_..." (see the storage.objects RLS policies in
// 20260730120000_persistence_hardening.sql) with no FK relationship to
// auth.users, so they are listed and removed explicitly before the
// account itself is deleted.
//
// Security: the caller's identity comes only from the Supabase-verified
// JWT (the platform rejects unauthenticated calls before this code runs).
// A user can only ever delete themselves; the service-role key is used
// solely for the privileged delete and never trusts a client-supplied id.

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

const jsonHeaders = { ...corsHeaders, "Content-Type": "application/json" };

const PLANT_IMAGES_BUCKET = "plant-images";

Deno.serve(async (request: Request): Promise<Response> => {
  if (request.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  if (request.method !== "POST") {
    return jsonResponse({ error_code: "method_not_allowed" }, 405);
  }

  const authHeader = request.headers.get("Authorization") ?? "";
  const jwt = authHeader.replace(/^Bearer\s+/i, "").trim();
  if (!jwt) {
    return jsonResponse({ error_code: "missing_authorization" }, 401);
  }

  const supabaseUrl = Deno.env.get("SUPABASE_URL");
  const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
  if (!supabaseUrl || !serviceRoleKey) {
    return jsonResponse({ error_code: "server_misconfigured" }, 500);
  }

  const admin = createClient(supabaseUrl, serviceRoleKey, {
    auth: { autoRefreshToken: false, persistSession: false },
  });

  // Resolve the caller strictly from their own JWT — never from a
  // client-supplied user id — so this endpoint can only ever delete
  // "yourself".
  const { data: userData, error: userError } = await admin.auth.getUser(jwt);
  if (userError || !userData?.user) {
    return jsonResponse({ error_code: "invalid_session" }, 401);
  }

  const userId = userData.user.id;

  // Best-effort cleanup of the user's uploaded images. This bucket isn't
  // linked to auth.users by any foreign key, so it must be cleaned up
  // separately — but a failure here must never block the actual account
  // deletion the user asked for.
  try {
    const { data: files } = await admin.storage
      .from(PLANT_IMAGES_BUCKET)
      .list("", { limit: 1000, search: `${userId}_` });
    const ownedPaths = (files ?? [])
      .map((file) => file.name)
      .filter((name) => name.startsWith(`${userId}_`));
    if (ownedPaths.length > 0) {
      await admin.storage.from(PLANT_IMAGES_BUCKET).remove(ownedPaths);
    }
  } catch (storageError) {
    console.error("plant-images cleanup failed", storageError);
  }

  const { error: deleteError } = await admin.auth.admin.deleteUser(userId);
  if (deleteError) {
    return jsonResponse(
      { error_code: "delete_failed", message: deleteError.message },
      500,
    );
  }

  return jsonResponse({ status: "deleted" }, 200);
});

function jsonResponse(body: Record<string, unknown>, status = 200): Response {
  return new Response(JSON.stringify(body), { status, headers: jsonHeaders });
}
