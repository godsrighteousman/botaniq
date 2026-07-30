const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

const jsonHeaders = {
  ...corsHeaders,
  "Content-Type": "application/json",
};

const OPENAI_API_URL = "https://api.openai.com/v1/chat/completions";
const OPENAI_MODEL = "gpt-4o-mini";

type AnalysisMode = "identify" | "diagnose" | "chat" | "details" | "localize";

interface AnalyzePlantRequest {
  mode?: AnalysisMode;
  image_base64?: string;
  image_mime_type?: string;
  prompt?: string;
  messages?: ChatInputMessage[];
  language_code?: string;
  content?: Record<string, unknown>;
}

interface ChatInputMessage {
  role?: "user" | "assistant";
  content?: string;
  image_url?: string;
}

interface OpenAIResponse {
  choices?: Array<{
    message?: {
      content?: string;
    };
  }>;
  error?: {
    message?: string;
  };
}

type OpenAIMessage = {
  role: "system" | "user" | "assistant";
  content: string | Array<Record<string, unknown>>;
};

Deno.serve(async (request: Request): Promise<Response> => {
  if (request.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  if (request.method !== "POST") {
    return jsonResponse({ error: "Method not allowed" }, 405);
  }

  try {
    const apiKey = Deno.env.get("OPENAI_API_KEY");
    if (!apiKey) {
      return jsonResponse(
        { error: "OPENAI_API_KEY not configured on server" },
        500,
      );
    }

    const body = await readRequestBody(request);
    if (!body.mode) {
      return jsonResponse(
        {
          error:
            "Invalid mode. Use: identify, diagnose, chat, details, or localize",
        },
        400,
      );
    }

    if (body.mode === "chat") {
      return await handleChat(apiKey, body.messages, body.language_code);
    }

    if (body.mode === "details") {
      return await handleDetails(apiKey, body.prompt, body.language_code);
    }

    if (body.mode === "localize") {
      return await handleLocalization(
        apiKey,
        body.content,
        body.language_code,
      );
    }

    if (!body.image_base64?.trim()) {
      return jsonResponse(
        { error: "image_base64 is required for identify and diagnose modes" },
        400,
      );
    }

    return await handleImageAnalysis(apiKey, body);
  } catch (error: unknown) {
    console.error("analyze-plant failed", error);
    return jsonResponse({ error: errorMessage(error) }, 500);
  }
});

async function handleChat(
  apiKey: string,
  inputMessages: ChatInputMessage[] | undefined,
  languageCode: string | undefined,
): Promise<Response> {
  const language = responseLanguage(languageCode);
  const messages: OpenAIMessage[] = [
    {
      role: "system",
      content:
        `Sen uzman bir bitki doktoru ve botanikçisin. Kullanıcının bitki sağlığı ve bakımı hakkındaki sorularını kısa, anlaşılır, güvenli ve pratik biçimde ${language} yanıtla.`,
    },
  ];

  for (const message of inputMessages ?? []) {
    const role = message.role === "assistant" ? "assistant" : "user";
    const text = message.content?.trim() || "Bu bitkiyi incele.";

    if (message.image_url?.trim()) {
      const imageUrl = message.image_url.startsWith("data:")
        ? message.image_url
        : `data:image/jpeg;base64,${message.image_url}`;
      messages.push({
        role,
        content: [
          { type: "text", text },
          {
            type: "image_url",
            image_url: { url: imageUrl, detail: "low" },
          },
        ],
      });
    } else {
      messages.push({ role, content: text });
    }
  }

  const result = await callOpenAI(apiKey, messages, {
    maxTokens: 1000,
    temperature: 0.7,
  });

  if (!result.ok) return result.response;
  return jsonResponse({ reply: result.content });
}

async function handleDetails(
  apiKey: string,
  prompt: string | undefined,
  languageCode: string | undefined,
): Promise<Response> {
  const language = responseLanguage(languageCode);
  const messages: OpenAIMessage[] = [
    {
      role: "system",
      content:
        `Sen uzman bir botanikçisin. Yalnızca geçerli bir JSON objesi ve ${language}, bitkiye özgü bilgiler döndür. Emin olmadığın bilgiyi uydurma.`,
    },
    {
      role: "user",
      content: prompt?.trim() || "Bitki hakkında detay ver.",
    },
  ];

  const result = await callOpenAI(apiKey, messages, {
    maxTokens: 900,
    temperature: 0.2,
    jsonMode: true,
  });

  if (!result.ok) return result.response;
  return jsonResponse({ result: parseJsonObject(result.content) });
}

async function handleLocalization(
  apiKey: string,
  content: Record<string, unknown> | undefined,
  languageCode: string | undefined,
): Promise<Response> {
  if (!content || Object.keys(content).length === 0) {
    return jsonResponse({ error: "content is required for localize mode" }, 400);
  }
  const language = responseLanguage(languageCode);
  const messages: OpenAIMessage[] = [
    {
      role: "system",
      content:
        `Verilen bitki verilerini ${language} diline çevir. Yeni bilgi, bakım önerisi veya kesinlik ekleme; bilimsel tür adlarını değiştirme. JSON anahtarlarını aynen koru ve yalnızca geçerli JSON döndür.`,
    },
    { role: "user", content: JSON.stringify(content) },
  ];

  const result = await callOpenAI(apiKey, messages, {
    maxTokens: 1200,
    temperature: 0,
    jsonMode: true,
  });
  if (!result.ok) return result.response;
  return jsonResponse({ result: parseJsonObject(result.content) });
}

async function handleImageAnalysis(
  apiKey: string,
  body: AnalyzePlantRequest,
): Promise<Response> {
  const isDiagnosis = body.mode === "diagnose";
  const mimeType = body.image_mime_type === "png" ? "png" : "jpeg";
  const language = responseLanguage(body.language_code);

  const systemPrompt = isDiagnosis
    ? `Sen uzman bir botanikçi ve bitki doktorusun. Fotoğraftaki bitkiyi görsel kanıta dayanarak tanımla, ardından hastalığını teşhis et. Emin değilsen uydurma isim verme; tanımlanamadığını açıkça yaz. Yalnızca geçerli JSON ve ${language} yanıt ver.`
    : `Sen uzman bir botanikçisin. Fotoğraftaki bitkiyi görsel kanıta dayanarak tanımla. Emin olmadığın türü uydurma. Yalnızca geçerli JSON ve ${language} yanıt ver.`;

  const fallbackPrompt = isDiagnosis
    ? 'Şu JSON şemasında cevap ver: {"plant_name":"Ortak ad veya Tanımlanamayan Bitki","species":"Bilimsel tür veya Belirsiz","diagnosis":"Teşhis","prescription":"Tedavi adımları","urgency":"Düşük/Orta/Kritik","care_tips":["İpucu"],"recovery_time":"Tahmini süre"}'
    : 'Şu JSON şemasında cevap ver: {"name":"Bitki adı","species":"Bilimsel tür","description":"Kısa bilgi","water_needs":"Sulama","watering_interval_days":7,"light_needs":"Işık"}. watering_interval_days türe uygun pozitif tam sayı olmalı.';

  const messages: OpenAIMessage[] = [
    { role: "system", content: systemPrompt },
    {
      role: "user",
      content: [
        { type: "text", text: body.prompt?.trim() || fallbackPrompt },
        {
          type: "image_url",
          image_url: {
            url: `data:image/${mimeType};base64,${body.image_base64}`,
            detail: "low",
          },
        },
      ],
    },
  ];

  const result = await callOpenAI(apiKey, messages, {
    maxTokens: 900,
    temperature: 0.2,
    jsonMode: true,
  });

  if (!result.ok) return result.response;
  return jsonResponse({ result: parseJsonObject(result.content) });
}

type OpenAIResult =
  | { ok: true; content: string }
  | { ok: false; response: Response };

async function callOpenAI(
  apiKey: string,
  messages: OpenAIMessage[],
  options: {
    maxTokens: number;
    temperature: number;
    jsonMode?: boolean;
  },
): Promise<OpenAIResult> {
  const response = await fetch(OPENAI_API_URL, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${apiKey}`,
    },
    body: JSON.stringify({
      model: OPENAI_MODEL,
      messages,
      max_tokens: options.maxTokens,
      temperature: options.temperature,
      ...(options.jsonMode ? { response_format: { type: "json_object" } } : {}),
    }),
  });

  const data = await readOpenAIResponse(response);
  if (!response.ok) {
    return {
      ok: false,
      response: jsonResponse(
        { error: data.error?.message || "OpenAI API error" },
        response.status,
      ),
    };
  }

  const content = data.choices?.[0]?.message?.content?.trim();
  if (!content) {
    return {
      ok: false,
      response: jsonResponse(
        { error: "OpenAI returned an empty response" },
        502,
      ),
    };
  }

  return { ok: true, content };
}

async function readRequestBody(
  request: Request,
): Promise<AnalyzePlantRequest> {
  const value: unknown = await request.json();
  if (!isRecord(value)) {
    throw new Error("Request body must be a JSON object");
  }

  const mode = typeof value.mode === "string" &&
      ["identify", "diagnose", "chat", "details", "localize"].includes(
        value.mode,
      )
    ? value.mode as AnalysisMode
    : undefined;

  return {
    mode,
    image_base64: stringValue(value.image_base64),
    image_mime_type: stringValue(value.image_mime_type),
    prompt: stringValue(value.prompt),
    language_code: stringValue(value.language_code),
    content: isRecord(value.content) ? value.content : undefined,
    messages: Array.isArray(value.messages)
      ? value.messages.filter(isRecord).map((message) => ({
        role: message.role === "assistant" ? "assistant" : "user",
        content: stringValue(message.content),
        image_url: stringValue(message.image_url),
      }))
      : undefined,
  };
}

function responseLanguage(languageCode: string | undefined): string {
  return languageCode === "en" ? "English" : "Türkçe";
}

async function readOpenAIResponse(
  response: Response,
): Promise<OpenAIResponse> {
  const value: unknown = await response.json();
  return isRecord(value) ? value as OpenAIResponse : {};
}

function parseJsonObject(content: string): Record<string, unknown> {
  const cleaned = content
    .replace(/^```json\s*/i, "")
    .replace(/^```\s*/i, "")
    .replace(/\s*```$/i, "")
    .trim();
  const value: unknown = JSON.parse(cleaned);
  if (!isRecord(value)) {
    throw new Error("OpenAI response is not a JSON object");
  }
  return value;
}

function jsonResponse(
  body: Record<string, unknown>,
  status = 200,
): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: jsonHeaders,
  });
}

function errorMessage(error: unknown): string {
  return error instanceof Error ? error.message : "Unexpected server error";
}

function stringValue(value: unknown): string | undefined {
  return typeof value === "string" ? value : undefined;
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}
