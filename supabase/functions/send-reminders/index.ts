import { createClient } from "npm:@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

interface CareTaskRow {
  task_type?: string;
  plants?: {
    custom_name?: string;
    name?: string;
  } | null;
  profiles?: {
    full_name?: string;
  } | null;
}

Deno.serve(async (request: Request): Promise<Response> => {
  if (request.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  if (request.method !== "POST") {
    return jsonResponse({ error: "Method not allowed" }, 405);
  }

  try {
    const supabaseUrl = Deno.env.get("SUPABASE_URL");
    const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
    if (!supabaseUrl || !serviceRoleKey) {
      return jsonResponse(
        { error: "Supabase server environment is not configured" },
        500,
      );
    }

    const supabase = createClient(supabaseUrl, serviceRoleKey, {
      auth: {
        autoRefreshToken: false,
        persistSession: false,
      },
    });

    const { data, error } = await supabase
      .from("care_tasks")
      .select(
        "task_type, plants(custom_name, name), profiles(full_name)",
      )
      .eq("is_completed", false)
      .lte("due_date", new Date().toISOString());

    if (error) throw error;

    const tasks = (data ?? []) as unknown as CareTaskRow[];
    for (const task of tasks) {
      const plantName = task.plants?.custom_name ?? task.plants?.name ??
        "Bilinmeyen Bitki";
      const userName = task.profiles?.full_name ?? "Kullanıcı";
      console.log(
        `[Reminder simulation] ${userName}: ${plantName} / ${
          task.task_type ?? "care"
        }`,
      );
    }

    return jsonResponse({
      message: `Successfully processed ${tasks.length} reminders.`,
      processed_count: tasks.length,
    });
  } catch (error: unknown) {
    console.error("send-reminders failed", error);
    return jsonResponse({ error: errorMessage(error) }, 500);
  }
});

function jsonResponse(
  body: Record<string, unknown>,
  status = 200,
): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: {
      ...corsHeaders,
      "Content-Type": "application/json",
    },
  });
}

function errorMessage(error: unknown): string {
  return error instanceof Error ? error.message : "Unexpected server error";
}
