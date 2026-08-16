// "Delete account" flow: anonymizes the calling user instead of removing
// the Supabase Auth account. The auth identity (id/email/provider link)
// is kept intact so the same person can sign back in later and land on
// the same account — but every personally identifying field on that
// account is scrubbed first, so the profile is no longer attributable to
// them once this runs.
//
// Security: the caller's identity comes only from the Supabase-verified
// JWT (the platform rejects unauthenticated calls before this code runs).
// A user can only ever anonymize themselves; the service-role key is used
// solely for the privileged update and never trusts a client-supplied id.

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

const jsonHeaders = { ...corsHeaders, "Content-Type": "application/json" };

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
  // client-supplied user id — so this endpoint can only anonymize "yourself".
  const { data: userData, error: userError } = await admin.auth.getUser(jwt);
  if (userError || !userData?.user) {
    return jsonResponse({ error_code: "invalid_session" }, 401);
  }

  const userId = userData.user.id;
  const anonName = `Anonim Kullanıcı ${userId.slice(0, 8)}`;

  // Scrub every PII-bearing profile table. Both `users` and `profiles`
  // exist in this schema (see 20260730120000_persistence_hardening.sql);
  // update whichever rows are present and ignore "table/row not found"
  // so this stays resilient if one of them is later dropped.
  const scrub = {
    full_name: anonName,
    avatar_url: null,
    location: null,
    email: null,
    fcm_token: null,
    updated_at: new Date().toISOString(),
  };

  const [usersResult, profilesResult] = await Promise.all([
    admin.from("users").update(scrub).eq("id", userId),
    admin.from("profiles").update(scrub).eq("id", userId),
  ]);

  if (usersResult.error && profilesResult.error) {
    return jsonResponse(
      {
        error_code: "anonymize_failed",
        message: usersResult.error.message,
      },
      500,
    );
  }

  // Strip the OAuth-provided name/picture from the auth record's own
  // metadata too, so re-login doesn't repopulate the scrubbed fields.
  await admin.auth.admin.updateUserById(userId, {
    user_metadata: { full_name: null, name: null, avatar_url: null, picture: null },
  });

  return jsonResponse({ status: "anonymized" }, 200);
});

function jsonResponse(body: Record<string, unknown>, status = 200): Response {
  return new Response(JSON.stringify(body), { status, headers: jsonHeaders });
}
