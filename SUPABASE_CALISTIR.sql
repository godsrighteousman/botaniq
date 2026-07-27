-- =============================================================
-- BOTANIQ — SUPABASE KURULUM (TEK DOSYA)
-- Supabase Dashboard > SQL Editor > "New Query" > Yapıştır > Run
-- =============================================================

-- ▶ ADIM 1: profiles tablosu (yoksa oluştur, varsa kolonları ekle)
CREATE TABLE IF NOT EXISTS public.profiles (
  id          UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email       TEXT,
  full_name   TEXT,
  avatar_url  TEXT,
  location    TEXT,
  watering_reminders   BOOLEAN DEFAULT true,
  fertilizer_reminders BOOLEAN DEFAULT true,
  language_code        TEXT,
  created_at  TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc', now()),
  updated_at  TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc', now())
);

-- Eksik kolonları varsa ekle (zaten varsa hata vermez)
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS location              TEXT,
  ADD COLUMN IF NOT EXISTS watering_reminders    BOOLEAN DEFAULT true,
  ADD COLUMN IF NOT EXISTS fertilizer_reminders  BOOLEAN DEFAULT true,
  ADD COLUMN IF NOT EXISTS language_code         TEXT;

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies WHERE tablename = 'profiles' AND policyname = 'profiles_all_own'
  ) THEN
    CREATE POLICY "profiles_all_own" ON public.profiles FOR ALL USING (auth.uid() = id);
  END IF;
END $$;

-- ▶ ADIM 2: plants tablosu (yoksa oluştur, varsa kolonları ekle)
CREATE TABLE IF NOT EXISTS public.plants (
  id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id                 UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
  custom_name             TEXT NOT NULL DEFAULT 'My Plant',
  species                 TEXT,
  image_url               TEXT,
  health_status           TEXT DEFAULT 'Healthy',
  room                    TEXT,
  light_condition         TEXT,
  distance_to_window      TEXT,
  sunlight_hours          TEXT,
  last_repotted           TEXT,
  pot_type                TEXT,
  last_watered_at         DATE,
  watering_interval_days  INTEGER DEFAULT 7,
  notes                   TEXT,
  created_at              TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc', now()),
  updated_at              TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc', now())
);

-- Varsa eksik kolonları ekle
ALTER TABLE public.plants
  ADD COLUMN IF NOT EXISTS custom_name             TEXT,
  ADD COLUMN IF NOT EXISTS health_status           TEXT DEFAULT 'Healthy',
  ADD COLUMN IF NOT EXISTS room                    TEXT,
  ADD COLUMN IF NOT EXISTS light_condition         TEXT,
  ADD COLUMN IF NOT EXISTS distance_to_window      TEXT,
  ADD COLUMN IF NOT EXISTS sunlight_hours          TEXT,
  ADD COLUMN IF NOT EXISTS last_repotted           TEXT,
  ADD COLUMN IF NOT EXISTS pot_type                TEXT,
  ADD COLUMN IF NOT EXISTS last_watered_at         DATE,
  ADD COLUMN IF NOT EXISTS watering_interval_days  INTEGER DEFAULT 7,
  ADD COLUMN IF NOT EXISTS notes                   TEXT;

ALTER TABLE public.plants ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies WHERE tablename = 'plants' AND policyname = 'plants_all_own'
  ) THEN
    CREATE POLICY "plants_all_own" ON public.plants FOR ALL USING (auth.uid() = user_id);
  END IF;
END $$;

-- ▶ ADIM 3: care_tasks tablosu (yoksa oluştur, varsa kolonları ekle)
CREATE TABLE IF NOT EXISTS public.care_tasks (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plant_id     UUID REFERENCES public.plants(id) ON DELETE CASCADE NOT NULL,
  user_id      UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
  task_type    TEXT NOT NULL,
  due_date     TIMESTAMP WITH TIME ZONE NOT NULL,
  amount       TEXT,
  instruction  TEXT,
  is_completed BOOLEAN DEFAULT false,
  completed_at TIMESTAMP WITH TIME ZONE,
  created_at   TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc', now())
);

ALTER TABLE public.care_tasks
  ADD COLUMN IF NOT EXISTS amount      TEXT,
  ADD COLUMN IF NOT EXISTS instruction TEXT;

ALTER TABLE public.care_tasks ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies WHERE tablename = 'care_tasks' AND policyname = 'care_tasks_all_own'
  ) THEN
    CREATE POLICY "care_tasks_all_own" ON public.care_tasks FOR ALL USING (auth.uid() = user_id);
  END IF;
END $$;

-- ▶ ADIM 4: plant_catalog tablosu
CREATE TABLE IF NOT EXISTS public.plant_catalog (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name             TEXT NOT NULL,
  species          TEXT NOT NULL,
  description      TEXT,
  difficulty       TEXT,
  toxicity         TEXT,
  is_toxic_to_pets     BOOLEAN DEFAULT false,
  is_toxic_to_humans   BOOLEAN DEFAULT false,
  environment      TEXT,
  sunlight         TEXT,
  ideal_climate    TEXT,
  humidity         TEXT,
  temperature_range    TEXT,
  watering_protocol    TEXT,
  feeding_protocol     TEXT,
  image            TEXT,
  created_at       TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc', now())
);

ALTER TABLE public.plant_catalog ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies WHERE tablename = 'plant_catalog' AND policyname = 'catalog_public_read'
  ) THEN
    CREATE POLICY "catalog_public_read" ON public.plant_catalog FOR SELECT TO anon, authenticated USING (true);
  END IF;
END $$;

-- ▶ ADIM 5: Yeni kayıt olduğunda otomatik profil oluşturan trigger
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, avatar_url)
  VALUES (
    new.id,
    new.email,
    new.raw_user_meta_data->>'full_name',
    new.raw_user_meta_data->>'avatar_url'
  )
  ON CONFLICT (id) DO NOTHING;
  RETURN new;
END;
$$;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- =============================================================
-- SON ADIM (SQL ile yapılamaz, Manuel gerekir):
-- Supabase Dashboard > Storage > "New Bucket"
--   Bucket adı: plant-images
--   Public: AÇIK (toggle'ı aç)
-- =============================================================
