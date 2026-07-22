-- =============================================================
-- Botaniq v2 Migration
-- Tarih: 2026-07-19
-- İçerik:
--   1. profiles tablosuna eksik sütunlar
--   2. plants tablosuna eksik sütunlar
--   3. plant_catalog tablosu (sıfırdan)
--   4. Supabase Storage bucket tanımı (manuel adım)
-- =============================================================

-- ---------------------------
-- 1. profiles tablosuna eksik sütunlar ekle
-- (Mevcut: id, email, full_name, avatar_url, created_at, updated_at)
-- ---------------------------
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS location            TEXT,
  ADD COLUMN IF NOT EXISTS watering_reminders  BOOLEAN DEFAULT true,
  ADD COLUMN IF NOT EXISTS fertilizer_reminders BOOLEAN DEFAULT true,
  ADD COLUMN IF NOT EXISTS fcm_token           TEXT;   -- Push notification için

-- ---------------------------
-- 2. plants tablosuna eksik sütunlar ekle
-- (Mevcut: id, user_id, name, species, image_url, location, light_requirement,
--          water_requirement, created_at, updated_at)
-- ---------------------------
ALTER TABLE public.plants
  ADD COLUMN IF NOT EXISTS custom_name            TEXT,
  ADD COLUMN IF NOT EXISTS room                   TEXT,          -- 'Living Room', 'Bedroom' vb.
  ADD COLUMN IF NOT EXISTS light_condition        TEXT,          -- 'Bright Indirect', 'Low Light' vb.
  ADD COLUMN IF NOT EXISTS distance_to_window     TEXT,          -- '0-1 m', '1-2 m' vb.
  ADD COLUMN IF NOT EXISTS sunlight_hours         TEXT,          -- '3 hours' vb.
  ADD COLUMN IF NOT EXISTS last_repotted          TEXT,          -- 'Recently', '1 year ago' vb.
  ADD COLUMN IF NOT EXISTS pot_type               TEXT,          -- 'Terracotta', 'Plastic' vb.
  ADD COLUMN IF NOT EXISTS last_watered_at        DATE,
  ADD COLUMN IF NOT EXISTS watering_interval_days INT DEFAULT 7,
  ADD COLUMN IF NOT EXISTS health_status          TEXT DEFAULT 'Healthy',
  ADD COLUMN IF NOT EXISTS catalog_id             UUID REFERENCES public.plant_catalog(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS notes                  TEXT;

-- ---------------------------
-- 3. plant_catalog tablosu (sıfırdan oluştur)
-- ---------------------------
CREATE TABLE IF NOT EXISTS public.plant_catalog (
  id                   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name                 TEXT NOT NULL,           -- 'Monstera'
  species              TEXT NOT NULL,           -- 'Monstera deliciosa'
  description          TEXT,
  difficulty           TEXT,                    -- 'Easy', 'Medium', 'Hard'
  toxicity             TEXT,                    -- 'Toxic to pets and humans if ingested'
  is_toxic_to_pets     BOOLEAN DEFAULT false,
  is_toxic_to_humans   BOOLEAN DEFAULT false,
  environment          TEXT,                    -- 'Indoor', 'Outdoor', 'Both'
  sunlight             TEXT,                    -- 'Bright Indirect', 'Low Light', 'Full Sun'
  ideal_climate        TEXT,                    -- 'Warm & Humid (18°C - 27°C)'
  humidity             TEXT,                    -- 'Medium to High (50-80%)'
  temperature_range    TEXT,                    -- '18-27°C'
  watering_protocol    TEXT,                    -- 'Every 7-10 days, allow top inch to dry'
  feeding_protocol     TEXT,                    -- 'Monthly in spring/summer with balanced fertilizer'
  image                TEXT,                    -- Unsplash URL
  created_at           TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- plant_catalog herkese açık okuma (seed data)
ALTER TABLE public.plant_catalog ENABLE ROW LEVEL SECURITY;

CREATE POLICY "catalog_public_read" ON public.plant_catalog
  FOR SELECT TO anon, authenticated USING (true);

-- ---------------------------
-- 4. catalog_id FK için plants'e yapılan referans düzeltme
--    (plant_catalog tablosu plantstan sonra oluşuyorsa ALTER ile FK ekle)
-- ---------------------------
-- Eğer yukarıdaki ADD COLUMN FK hata verirse, önce tabloyu oluşturup sonra FK ekle:
-- ALTER TABLE public.plants
--   ADD CONSTRAINT plants_catalog_id_fkey
--   FOREIGN KEY (catalog_id) REFERENCES public.plant_catalog(id) ON DELETE SET NULL;

-- ---------------------------
-- 5. care_tasks tablosuna eksik alanlar
-- (Mevcut: id, plant_id, user_id, task_type, due_date, is_completed, completed_at, created_at)
-- ---------------------------
ALTER TABLE public.care_tasks
  ADD COLUMN IF NOT EXISTS amount      TEXT,        -- '250ml', 'Liquid Fertilizer'
  ADD COLUMN IF NOT EXISTS instruction TEXT;        -- 'Water until it drains from bottom...'

-- ---------------------------
-- NOT: Supabase Storage Bucket
-- Dashboard > Storage > New Bucket: "plant-images" (public: true)
-- Bu SQL ile oluşturulamaz, manuel yapılmalı.
-- ---------------------------
