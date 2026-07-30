import { serve } from "https://deno.land/std@0.168.0/http/server.ts"

const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

const OPENAI_API_URL = 'https://api.openai.com/v1/chat/completions';

serve(async (req: Request) => {
    if (req.method === 'OPTIONS') {
        return new Response('ok', { headers: corsHeaders })
    }

    try {
        const OPENAI_API_KEY = Deno.env.get('OPENAI_API_KEY');
        if (!OPENAI_API_KEY) {
            return new Response(
                JSON.stringify({ error: 'OPENAI_API_KEY not configured on server' }),
                { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 500 }
            )
        }

        const { image_base64, image_mime_type, prompt, mode, messages } = await req.json();
        const imageMimeType = image_mime_type === 'png' ? 'png' : 'jpeg';

        let systemPrompt = '';
        let userContent: any[] = [];

        if (mode === 'identify') {
            // Bitki tanımlama
            systemPrompt = "Sen uzman bir botanikçisin. Fotoğraftaki bitkiyi tanımla ve JSON formatında cevap ver.";
            userContent = [
                {
                    type: "text",
                    text: prompt || "Bu fotoğraftaki bitkinin tam adını, türünü ve temel bakım ihtiyaçlarını JSON formatında dön:\n{\"name\": \"...\", \"species\": \"...\", \"description\": \"...\", \"water_needs\": \"...\", \"light_needs\": \"...\"}"
                },
                {
                    type: "image_url",
                    image_url: {
                        url: `data:image/${imageMimeType};base64,${image_base64}`,
                        detail: "low"
                    }
                }
            ];
        } else if (mode === 'diagnose') {
            // Hasta bitki teşhisi
            systemPrompt = "Sen uzman bir bitki doktorusun. Fotoğraftaki hasta bitkiyi analiz et, hastalığını teşhis et ve tedavi önerisi sun. Yanıtını sadece JSON formatında ver.";
            userContent = [
                {
                    type: "text",
                    text: prompt || "Bu hasta bitkiyi analiz et. Aşağıdaki JSON formatında cevap ver:\n{\"diagnosis\": \"Teşhis açıklaması\", \"prescription\": \"Tedavi önerisi\", \"urgency\": \"Düşük/Orta/Kritik\", \"care_tips\": [\"İpucu 1\", \"İpucu 2\"], \"recovery_time\": \"Tahmini iyileşme süresi\"}"
                },
                {
                    type: "image_url",
                    image_url: {
                        url: `data:image/${imageMimeType};base64,${image_base64}`,
                        detail: "low"
                    }
                }
            ];
        } else if (mode === 'chat') {
            // Serbest sohbet — mesaj geçmişi ile
            systemPrompt = "Sen uzman bir bitki doktoru ve botanikçisin. Kullanıcının bitki sağlığı ve bakımı hakkında sorularını yanıtla. Yanıtların kısa, anlaşılır ve pratik olsun. Türkçe cevap ver.";

            const openaiMessages = [
                { role: "system", content: systemPrompt },
                ...(messages || []).map((m: any) => {
                    if (m.image_url) {
                        return {
                            role: m.role,
                            content: [
                                { type: "text", text: m.content || "Bu fotoğraftaki bitkiyi incele." },
                                {
                                    type: "image_url",
                                    image_url: {
                                        url: m.image_url.startsWith('data:')
                                            ? m.image_url
                                            : `data:image/jpeg;base64,${m.image_url}`,
                                        detail: "low"
                                    }
                                }
                            ]
                        };
                    }
                    return { role: m.role, content: m.content };
                })
            ];

            const chatResponse = await fetch(OPENAI_API_URL, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${OPENAI_API_KEY}`,
                },
                body: JSON.stringify({
                    model: 'gpt-4o-mini',
                    messages: openaiMessages,
                    max_tokens: 1000,
                    temperature: 0.7,
                }),
            });

            const chatData = await chatResponse.json();

            if (!chatResponse.ok) {
                return new Response(
                    JSON.stringify({ error: chatData.error?.message || 'OpenAI API error' }),
                    { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: chatResponse.status }
                )
            }

            const reply = chatData.choices?.[0]?.message?.content || '';
            return new Response(
                JSON.stringify({ reply }),
                { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 200 }
            )
        } else if (mode === 'details') {
            // Bitki detayları (isim ile)
            systemPrompt = "Sen uzman bir botanikçisin ve bitki detayları sağlayan bir API'sin. Sadece JSON formatında cevap vermelisin.";

            const detailMessages = [
                { role: "system", content: systemPrompt },
                {
                    role: "user",
                    content: prompt || "Bitki hakkında detay ver."
                }
            ];

            const detailResponse = await fetch(OPENAI_API_URL, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${OPENAI_API_KEY}`,
                },
                body: JSON.stringify({
                    model: 'gpt-4o-mini',
                    messages: detailMessages,
                    max_tokens: 800,
                    temperature: 0.3,
                }),
            });

            const detailData = await detailResponse.json();
            if (!detailResponse.ok) {
                return new Response(
                    JSON.stringify({ error: detailData.error?.message || 'OpenAI API error' }),
                    { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: detailResponse.status }
                )
            }

            const detailContent = detailData.choices?.[0]?.message?.content || '{}';
            const cleanDetail = detailContent.replace(/```json/g, '').replace(/```/g, '').trim();
            return new Response(
                JSON.stringify({ result: JSON.parse(cleanDetail) }),
                { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 200 }
            )
        } else {
            return new Response(
                JSON.stringify({ error: 'Invalid mode. Use: identify, diagnose, chat, or details' }),
                { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 400 }
            )
        }

        // For identify and diagnose modes
        const openaiResponse = await fetch(OPENAI_API_URL, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${OPENAI_API_KEY}`,
            },
            body: JSON.stringify({
                model: 'gpt-4o-mini',
                messages: [
                    { role: "system", content: systemPrompt },
                    { role: "user", content: userContent }
                ],
                max_tokens: 800,
                temperature: 0.3,
            }),
        });

        const data = await openaiResponse.json();

        if (!openaiResponse.ok) {
            return new Response(
                JSON.stringify({ error: data.error?.message || 'OpenAI API error' }),
                { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: openaiResponse.status }
            )
        }

        const content = data.choices?.[0]?.message?.content || '{}';
        const cleanContent = content.replace(/```json/g, '').replace(/```/g, '').trim();

        let result;
        try {
            result = JSON.parse(cleanContent);
        } catch {
            result = { raw: cleanContent };
        }

        return new Response(
            JSON.stringify({ result }),
            { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 200 }
        )
    } catch (error) {
        return new Response(
            JSON.stringify({ error: (error as any).message }),
            { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 500 }
        )
    }
})
