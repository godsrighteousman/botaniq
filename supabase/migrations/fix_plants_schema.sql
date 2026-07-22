-- =============================================================
-- Botaniq - Plants Şema Düzeltmesi ve care_tasks tablosu
-- Bu SQL'i Supabase Dashboard > SQL Editor'de çalıştırın
-- =============================================================

-- 1. plants tablosuna eksik kolonları ekle
ALTER TABLE public.plants
  ADD COLUMN IF NOT EXISTS room TEXT,
  ADD COLUMN IF NOT EXISTS light_condition TEXT,
  ADD COLUMN IF NOT EXISTS distance_to_window TEXT,
  ADD COLUMN IF NOT EXISTS sunlight_hours TEXT,
  ADD COLUMN IF NOT EXISTS last_repotted TEXT,
  ADD COLUMN IF NOT EXISTS pot_type TEXT,
  ADD COLUMN IF NOT EXISTS last_watered_at DATE,
  ADD COLUMN IF NOT EXISTS watering_interval_days INTEGER DEFAULT 7;

-- 2. care_tasks tablosu (schedules tablosundan farklı, AddPlantWizard bunu kullanıyor)
CREATE TABLE IF NOT EXISTS public.care_tasks (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  plant_id UUID REFERENCES public.plants(id) ON DELETE CASCADE NOT NULL,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  task_type TEXT NOT NULL,  -- 'water', 'fertilize', 'repot' vb.
  due_date TIMESTAMP WITH TIME ZONE NOT NULL,
  is_completed BOOLEAN DEFAULT false,
  completed_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 3. care_tasks için RLS politikaları
ALTER TABLE public.care_tasks ENABLE ROW LEVEL SECURITY;

CREATE POLICY IF NOT EXISTS "Users can manage own care_tasks"
  ON public.care_tasks
  FOR ALL
  USING (auth.uid() = user_id);

-- 4. profiles tablosu (users tablosundan ayrı, AddPlantWizard bunu kullanıyor)
-- AddPlantWizard 'profiles' tablosuna upsert yapıyor; eğer yoksa oluştur
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  email TEXT,
  full_name TEXT,
  avatar_url TEXT,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY IF NOT EXISTS "Users can manage own profile"
  ON public.profiles
  FOR ALL
  USING (auth.uid() = id);

-- 5. plant-images storage bucket (henüz yoksa elle oluşturun:
--    Supabase Dashboard > Storage > New bucket: "plant-images" (public: true)
-- Bu SQL'den otomatik oluşturmak mümkün değil.

-- 6. plants tablosu için storage politikası değişkeni olarak user_id bağı:
--    plants için mevcut politika zaten var, kontrol et:
-- CREATE POLICY "Users can manage own plants" ON public.plants FOR ALL USING (auth.uid() = user_id);
