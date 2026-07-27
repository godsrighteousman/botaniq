import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req: Request) => {
    // Handle CORS preflight requests
    if (req.method === 'OPTIONS') {
        return new Response('ok', { headers: corsHeaders })
    }

    try {
        // This function can be called via pg_cron locally or via triggered HTTP request

        // Create a Supabase client with the service role key to bypass RLS for background jobs
        const supabaseClient = createClient(
            Deno.env.get('SUPABASE_URL') ?? '',
            Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
        )

        const today = new Date().toISOString();

        // Fetch uncompleted care tasks that are due
        const { data: tasks, error } = await supabaseClient
            .from('care_tasks')
            .select('*, plants(name), profiles(full_name)')
            .eq('is_completed', false)
            .lte('due_date', today);

        if (error) {
            throw error;
        }

        let sentCount = 0;

        for (const task of tasks) {
            // Mock logic: here you would integrate with Firebase Cloud Messaging (FCM) or OneSignal
            // Ex: await pushNotificationService.send({ to: user_fcm_token, title: "Reminder", body: `Time to ${task.task_type} ${task.plants.name}` })
            console.log(`[Push Notification Simulation] Sending reminder for ${task.plants?.name} (Task: ${task.task_type}) to user ${task.profiles?.full_name}`);
            sentCount++;
        }

        return new Response(
            JSON.stringify({ message: `Successfully processed ${sentCount} reminders.` }),
            { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 200 }
        )
    } catch (error) {
        return new Response(
            JSON.stringify({ error: (error as any).message }),
            { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 500 }
        )
    }
})
