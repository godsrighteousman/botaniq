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
    locale?: string;
    language_code?: string;
    timezone?: string;
  } | null;
}

const supportedLocaleTags = [
  "en",
  "tr",
  "de",
  "fr",
  "es",
  "it",
  "pt",
  "pt-BR",
  "pl",
  "ru",
  "zh-Hans",
  "zh-Hant",
  "id",
  "th",
  "ar",
  "nl-NL",
  "nl-BE",
] as const;

type SupportedLocaleTag = typeof supportedLocaleTags[number];
type ReminderTask = "care" | "water" | "fertilize" | "prune" | "repot";

interface ReminderCopy {
  title: string;
  unknownPlant: string;
  body: string;
  tasks: Record<ReminderTask, string>;
}

const defaultLocale: SupportedLocaleTag = "en";
const canonicalLocaleByLowerTag = new Map<string, SupportedLocaleTag>(
  supportedLocaleTags.map((tag) => [tag.toLowerCase(), tag] as const),
);
const legacyLanguageDefaults = new Map<string, SupportedLocaleTag>([
  ["zh", "zh-Hans"],
  ["nl", "nl-NL"],
]);

const reminderCopy = {
  en: {
    title: "Plant care reminder",
    unknownPlant: "Unknown plant",
    body: "{plant}: {task} is due.",
    tasks: {
      care: "Care",
      water: "Watering",
      fertilize: "Fertilizing",
      prune: "Pruning",
      repot: "Repotting",
    },
  },
  tr: {
    title: "Bitki bakım hatırlatıcısı",
    unknownPlant: "Bilinmeyen bitki",
    body: "{plant}: {task} zamanı geldi.",
    tasks: {
      care: "Bakım",
      water: "Sulama",
      fertilize: "Gübreleme",
      prune: "Budama",
      repot: "Saksı değişimi",
    },
  },
  de: {
    title: "Erinnerung an die Pflanzenpflege",
    unknownPlant: "Unbekannte Pflanze",
    body: "{plant}: {task} ist fällig.",
    tasks: {
      care: "Pflege",
      water: "Gießen",
      fertilize: "Düngen",
      prune: "Beschneiden",
      repot: "Umtopfen",
    },
  },
  fr: {
    title: "Rappel d’entretien des plantes",
    unknownPlant: "Plante inconnue",
    body: "{plant} : {task} à effectuer.",
    tasks: {
      care: "entretien",
      water: "arrosage",
      fertilize: "fertilisation",
      prune: "taille",
      repot: "rempotage",
    },
  },
  es: {
    title: "Recordatorio de cuidado de plantas",
    unknownPlant: "Planta desconocida",
    body: "{plant}: es hora de {task}.",
    tasks: {
      care: "cuidar la planta",
      water: "regar",
      fertilize: "abonar",
      prune: "podar",
      repot: "trasplantar",
    },
  },
  it: {
    title: "Promemoria per la cura delle piante",
    unknownPlant: "Pianta sconosciuta",
    body: "{plant}: è il momento di {task}.",
    tasks: {
      care: "prendersene cura",
      water: "annaffiare",
      fertilize: "concimare",
      prune: "potare",
      repot: "rinvasare",
    },
  },
  pt: {
    title: "Lembrete de cuidados da planta",
    unknownPlant: "Planta desconhecida",
    body: "{plant}: está na hora de {task}.",
    tasks: {
      care: "cuidar da planta",
      water: "regar",
      fertilize: "fertilizar",
      prune: "podar",
      repot: "mudar de vaso",
    },
  },
  "pt-BR": {
    title: "Lembrete de cuidado com a planta",
    unknownPlant: "Planta desconhecida",
    body: "{plant}: está na hora de {task}.",
    tasks: {
      care: "cuidar da planta",
      water: "regar",
      fertilize: "adubar",
      prune: "podar",
      repot: "trocar de vaso",
    },
  },
  pl: {
    title: "Przypomnienie o pielęgnacji roślin",
    unknownPlant: "Nieznana roślina",
    body: "{plant}: czas na zadanie „{task}”.",
    tasks: {
      care: "pielęgnacja",
      water: "podlewanie",
      fertilize: "nawożenie",
      prune: "przycinanie",
      repot: "przesadzanie",
    },
  },
  ru: {
    title: "Напоминание об уходе за растением",
    unknownPlant: "Неизвестное растение",
    body: "{plant}: пора выполнить задачу «{task}».",
    tasks: {
      care: "уход",
      water: "полив",
      fertilize: "подкормка",
      prune: "обрезка",
      repot: "пересадка",
    },
  },
  "zh-Hans": {
    title: "植物养护提醒",
    unknownPlant: "未知植物",
    body: "{plant}：该{task}了。",
    tasks: {
      care: "养护",
      water: "浇水",
      fertilize: "施肥",
      prune: "修剪",
      repot: "换盆",
    },
  },
  "zh-Hant": {
    title: "植物養護提醒",
    unknownPlant: "未知植物",
    body: "{plant}：該{task}了。",
    tasks: {
      care: "養護",
      water: "澆水",
      fertilize: "施肥",
      prune: "修剪",
      repot: "換盆",
    },
  },
  id: {
    title: "Pengingat perawatan tanaman",
    unknownPlant: "Tanaman tidak dikenal",
    body: "{plant}: waktunya {task}.",
    tasks: {
      care: "merawat tanaman",
      water: "menyiram",
      fertilize: "memupuk",
      prune: "memangkas",
      repot: "mengganti pot",
    },
  },
  th: {
    title: "การแจ้งเตือนดูแลต้นไม้",
    unknownPlant: "ไม่ทราบชื่อต้นไม้",
    body: "{plant}: ถึงเวลา{task}แล้ว",
    tasks: {
      care: "ดูแลต้นไม้",
      water: "รดน้ำ",
      fertilize: "ใส่ปุ๋ย",
      prune: "ตัดแต่ง",
      repot: "เปลี่ยนกระถาง",
    },
  },
  ar: {
    title: "تذكير بالعناية بالنبات",
    unknownPlant: "نبات غير معروف",
    body: "{plant}: حان وقت {task}.",
    tasks: {
      care: "العناية",
      water: "الري",
      fertilize: "التسميد",
      prune: "التقليم",
      repot: "تغيير الأصيص",
    },
  },
  "nl-NL": {
    title: "Herinnering voor plantenverzorging",
    unknownPlant: "Onbekende plant",
    body: "{plant}: tijd om te {task}.",
    tasks: {
      care: "verzorgen",
      water: "water geven",
      fertilize: "bemesten",
      prune: "snoeien",
      repot: "verpotten",
    },
  },
  "nl-BE": {
    title: "Herinnering voor plantenverzorging",
    unknownPlant: "Onbekende plant",
    body: "{plant}: tijd om te {task}.",
    tasks: {
      care: "verzorgen",
      water: "water geven",
      fertilize: "bemesten",
      prune: "snoeien",
      repot: "verpotten",
    },
  },
} satisfies Record<SupportedLocaleTag, ReminderCopy>;

Deno.serve(async (request: Request): Promise<Response> => {
  if (request.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  if (request.method !== "POST") {
    return jsonResponse({ error_code: "method_not_allowed" }, 405);
  }

  try {
    const supabaseUrl = Deno.env.get("SUPABASE_URL");
    const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
    if (!supabaseUrl || !serviceRoleKey) {
      return jsonResponse(
        { error_code: "internal_configuration_error" },
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
        "task_type, plants(custom_name, name), " +
          "profiles(full_name, locale, language_code, timezone)",
      )
      .eq("is_completed", false)
      .lte("due_date", new Date().toISOString());

    if (error) throw error;

    const tasks = (data ?? []) as unknown as CareTaskRow[];
    for (const task of tasks) {
      const resolvedLocale = resolveLocale(
        task.profiles?.locale,
        task.profiles?.language_code,
      );
      const copy = reminderCopy[resolvedLocale.tag];
      const plantName = task.plants?.custom_name ?? task.plants?.name ??
        copy.unknownPlant;
      const userName = task.profiles?.full_name ?? "User";
      const taskType = task.task_type ?? "care";
      const reminderTask = normalizeReminderTask(taskType);
      const body = renderReminderBody(
        copy.body,
        plantName,
        copy.tasks[reminderTask],
      );

      // These logs intentionally simulate delivery. Machine-facing fields and
      // task_type remain stable; only notification display copy is localized.
      console.log(JSON.stringify({
        event: "reminder_simulation",
        recipient_name: userName,
        plant_name: plantName,
        task_type: taskType,
        locale: resolvedLocale.tag,
        timezone: validTimezone(task.profiles?.timezone),
        fallback_used: resolvedLocale.fallbackUsed,
        notification: {
          title: copy.title,
          body,
        },
      }));
    }

    return jsonResponse({
      status: "ok",
      processed_count: tasks.length,
    });
  } catch (error: unknown) {
    console.error("send-reminders failed", error);
    return jsonResponse({ error_code: "internal_error" }, 500);
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

function resolveLocale(
  locale: string | undefined,
  languageCode: string | undefined,
): { tag: SupportedLocaleTag; fallbackUsed: boolean } {
  const requestedLocale = nonEmpty(locale);
  if (requestedLocale != null) {
    return canonicalLocale(requestedLocale);
  }

  const requestedLanguage = nonEmpty(languageCode);
  if (requestedLanguage == null) {
    return { tag: defaultLocale, fallbackUsed: true };
  }
  const legacyDefault = legacyLanguageDefaults.get(
    requestedLanguage.toLowerCase(),
  );
  return legacyDefault == null
    ? canonicalLocale(requestedLanguage)
    : { tag: legacyDefault, fallbackUsed: false };
}

function canonicalLocale(
  requested: string,
): { tag: SupportedLocaleTag; fallbackUsed: boolean } {
  const normalized = requested.replaceAll("_", "-").toLowerCase();
  const tag = canonicalLocaleByLowerTag.get(normalized);
  return tag == null
    ? { tag: defaultLocale, fallbackUsed: true }
    : { tag, fallbackUsed: false };
}

function nonEmpty(value: string | undefined): string | undefined {
  const trimmed = value?.trim();
  return trimmed == null || trimmed.length === 0 ? undefined : trimmed;
}

function normalizeReminderTask(taskType: string): ReminderTask {
  switch (taskType.trim().toLowerCase()) {
    case "water":
    case "watering":
      return "water";
    case "fertilize":
    case "fertilizer":
    case "fertilizing":
    case "feed":
      return "fertilize";
    case "prune":
    case "pruning":
      return "prune";
    case "repot":
    case "repotting":
      return "repot";
    default:
      return "care";
  }
}

function renderReminderBody(
  template: string,
  plant: string,
  task: string,
): string {
  const values = { plant, task };
  return template.replaceAll(
    /\{(plant|task)\}/g,
    (_, key: keyof typeof values) => values[key],
  );
}

function validTimezone(value: string | undefined): string {
  const timezone = nonEmpty(value) ?? "UTC";
  try {
    new Intl.DateTimeFormat("en", { timeZone: timezone }).format();
    return timezone;
  } catch (_) {
    return "UTC";
  }
}
