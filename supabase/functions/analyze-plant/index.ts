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
    return jsonResponse({ error_code: "method_not_allowed" }, 405);
  }

  try {
    const apiKey = Deno.env.get("OPENAI_API_KEY");
    if (!apiKey) {
      return jsonResponse(
        { error_code: "internal_configuration_error" },
        500,
      );
    }

    const body = await readRequestBody(request);
    if (!body.mode) {
      return jsonResponse(
        { error_code: "invalid_mode" },
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
        { error_code: "image_required" },
        400,
      );
    }

    return await handleImageAnalysis(apiKey, body);
  } catch (error: unknown) {
    console.error("analyze-plant failed", error);
    return jsonResponse({ error_code: "internal_error" }, 500);
  }
});

async function handleChat(
  apiKey: string,
  inputMessages: ChatInputMessage[] | undefined,
  languageCode: string | undefined,
): Promise<Response> {
  const locale = responseLocale(languageCode);
  const messages: OpenAIMessage[] = [
    {
      role: "system",
      content:
        `You are a plant-care assistant. Answer in ${locale.language} with concise, practical and cautious guidance. Do not present a photo-based health assessment as a certain diagnosis, and recommend professional help when safety or uncertainty warrants it.`,
    },
  ];

  for (const message of inputMessages ?? []) {
    const role = message.role === "assistant" ? "assistant" : "user";
    const text = message.content?.trim() || "Please assess this plant.";

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
  return jsonResponse({
    reply: result.content,
    response_locale: locale.tag,
    fallback_used: locale.fallbackUsed,
  });
}

async function handleDetails(
  apiKey: string,
  prompt: string | undefined,
  languageCode: string | undefined,
): Promise<Response> {
  const locale = responseLocale(languageCode);
  const messages: OpenAIMessage[] = [
    {
      role: "system",
      content:
        `Return only a valid JSON object with evidence-based plant information in ${locale.language}. Keep scientific names unchanged and never invent uncertain details.`,
    },
    {
      role: "user",
      content: prompt?.trim() || "Provide plant-care details.",
    },
  ];

  const result = await callOpenAI(apiKey, messages, {
    maxTokens: 900,
    temperature: 0.2,
    jsonMode: true,
  });

  if (!result.ok) return result.response;
  return jsonResponse({
    result: parseJsonObject(result.content),
    response_locale: locale.tag,
    fallback_used: locale.fallbackUsed,
  });
}

async function handleLocalization(
  apiKey: string,
  content: Record<string, unknown> | undefined,
  languageCode: string | undefined,
): Promise<Response> {
  if (!content || Object.keys(content).length === 0) {
    return jsonResponse({ error_code: "content_required" }, 400);
  }
  const locale = responseLocale(languageCode);
  const messages: OpenAIMessage[] = [
    {
      role: "system",
      content:
        `Translate the provided plant-care values into ${locale.language}. Preserve JSON keys and scientific names. Do not add facts, advice, certainty, or translate user-entered labels. Return only valid JSON.`,
    },
    { role: "user", content: JSON.stringify(content) },
  ];

  const result = await callOpenAI(apiKey, messages, {
    maxTokens: 1200,
    temperature: 0,
    jsonMode: true,
  });
  if (!result.ok) return result.response;
  return jsonResponse({
    result: parseJsonObject(result.content),
    response_locale: locale.tag,
    fallback_used: locale.fallbackUsed,
  });
}

async function handleImageAnalysis(
  apiKey: string,
  body: AnalyzePlantRequest,
): Promise<Response> {
  const isDiagnosis = body.mode === "diagnose";
  const mimeType = body.image_mime_type === "png" ? "png" : "jpeg";
  const locale = responseLocale(body.language_code);

  const systemPrompt = isDiagnosis
    ? `Assess the plant only from visible evidence. Use cautious language rather than a certain diagnosis. Use null for an uncertain identity. Return only valid JSON with localized prose in ${locale.language}, while machine fields remain in English.`
    : `Identify the plant only from visible evidence. Use null instead of inventing an uncertain identity. Return only valid JSON with localized prose in ${locale.language}.`;

  const fallbackPrompt = isDiagnosis
    ? 'Use this schema: {"plant_name":null,"species":null,"diagnosis":"cautious assessment","prescription":"safe care steps","urgency_code":"low|medium|critical","care_tips":["tip"],"recovery_time":"estimate"}.'
    : 'Use this schema: {"name":null,"species":null,"description":"summary","water_needs":"watering guidance","watering_interval_days":7,"light_needs":"light guidance"}. watering_interval_days must be a positive integer.';

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
  return jsonResponse({
    result: parseJsonObject(result.content),
    response_locale: locale.tag,
    fallback_used: locale.fallbackUsed,
  });
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
        { error_code: "ai_service_unavailable" },
        response.status,
      ),
    };
  }

  const content = data.choices?.[0]?.message?.content?.trim();
  if (!content) {
    return {
      ok: false,
      response: jsonResponse(
        { error_code: "ai_empty_response" },
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

interface ResolvedResponseLocale {
  tag: string;
  language: string;
  fallbackUsed: boolean;
}

const responseLanguages: Record<string, string> = {
  en: "English",
  tr: "Turkish",
  de: "German",
  fr: "French",
  es: "Spanish",
  it: "Italian",
  pt: "European Portuguese",
  "pt-BR": "Brazilian Portuguese",
  pl: "Polish",
  ru: "Russian",
  "zh-Hans": "Simplified Chinese",
  "zh-Hant": "Traditional Chinese",
  id: "Indonesian",
  th: "Thai",
  ar: "Arabic",
  "nl-NL": "Dutch as used in the Netherlands",
  "nl-BE": "Belgian Dutch (Flemish)",
};

function responseLocale(value: string | undefined): ResolvedResponseLocale {
  const raw = value?.trim().replaceAll("_", "-") || "";
  const exact = Object.keys(responseLanguages).find((tag) =>
    tag.toLowerCase() === raw.toLowerCase()
  );
  if (exact) {
    return {
      tag: exact,
      language: responseLanguages[exact],
      fallbackUsed: false,
    };
  }
  return { tag: "en", language: responseLanguages.en, fallbackUsed: true };
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

function stringValue(value: unknown): string | undefined {
  return typeof value === "string" ? value : undefined;
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}
