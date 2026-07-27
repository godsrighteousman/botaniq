-- Migration: Sick Plants & Diagnosis Messages tables for Care Center feature
-- Date: 2026-07-27

-- 1. Hasta bitkiler tablosu
CREATE TABLE IF NOT EXISTS public.sick_plants (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    plant_id UUID REFERENCES public.plants(id) ON DELETE SET NULL,
    name TEXT NOT NULL,
    image_url TEXT,
    diagnosis TEXT,
    prescription TEXT,
    urgency TEXT DEFAULT 'Orta' CHECK (urgency IN ('Düşük', 'Orta', 'Kritik')),
    recovery_progress NUMERIC DEFAULT 0.0 CHECK (recovery_progress >= 0 AND recovery_progress <= 1),
    status TEXT DEFAULT 'active' CHECK (status IN ('active', 'recovered', 'archived')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 2. Teşhis mesajları tablosu (chat geçmişi)
CREATE TABLE IF NOT EXISTS public.diagnosis_messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sick_plant_id UUID REFERENCES public.sick_plants(id) ON DELETE CASCADE NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('user', 'assistant')),
    content TEXT NOT NULL,
    image_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 3. RLS
ALTER TABLE public.sick_plants ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.diagnosis_messages ENABLE ROW LEVEL SECURITY;

-- 4. Policies
CREATE POLICY "Users can manage their own sick plants"
  ON public.sick_plants FOR ALL
  USING (auth.uid() = user_id);

CREATE POLICY "Users can manage diagnosis messages for their sick plants"
  ON public.diagnosis_messages FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM public.sick_plants sp
      WHERE sp.id = sick_plant_id AND sp.user_id = auth.uid()
    )
  );

-- 5. Index for fast lookups
CREATE INDEX IF NOT EXISTS idx_sick_plants_user_id ON public.sick_plants(user_id);
CREATE INDEX IF NOT EXISTS idx_diagnosis_messages_sick_plant_id ON public.diagnosis_messages(sick_plant_id);
