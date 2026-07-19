-- 1. YAPI TAŞI: EXTENSION (Supabase'de genellikle açıktır ama garantiye alalım)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. KULLANICILAR (USERS) TABLOSU
CREATE TABLE public.users (
    id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
    full_name TEXT,
    email TEXT,
    avatar_url TEXT,
    location TEXT,
    watering_reminders BOOLEAN DEFAULT true,
    fertilizer_reminders BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 3. BİTKİ KOLEKSİYONU (PLANTS) TABLOSU
CREATE TABLE public.plants (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
    custom_name TEXT NOT NULL,
    species TEXT,
    image_url TEXT,
    health_status TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 4. BİTKİ ANSİKLOPEDİSİ (PLANT CATALOG) TABLOSU
CREATE TABLE public.plant_catalog (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    species TEXT NOT NULL,
    description TEXT,
    difficulty TEXT,
    toxicity TEXT,
    environment TEXT,
    sunlight TEXT,
    ideal_climate TEXT,
    watering_protocol TEXT,
    feeding_protocol TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 5. GÖREVLER VE TAKVİM (SCHEDULES) TABLOSU
CREATE TABLE public.schedules (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
    plant_id UUID REFERENCES public.plants(id) ON DELETE CASCADE NOT NULL,
    task_type TEXT NOT NULL,
    amount TEXT,
    instruction TEXT,
    scheduled_date DATE NOT NULL,
    is_completed BOOLEAN DEFAULT false,
    completed_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);


-- --------------------------------------------------------------------------
-- GÜVENLİK KURALLARI (ROW LEVEL SECURITY - RLS)
-- Bir kullanıcının başkasının bitkisini silmesini veya görmesini engellemek için güvenlik kuralları.
-- Buralar çok önemlidir, eğer RLS açılmazsa uygulama mağazaları (App Store) güvenliği reddebilir.
-- --------------------------------------------------------------------------

ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.plants ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.schedules ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.plant_catalog ENABLE ROW LEVEL SECURITY;

-- Sadece kendi profilini görebilir ve profil oluşturabilir/güncelleyebilir
CREATE POLICY "Users can view own profile" ON public.users FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can insert own profile" ON public.users FOR INSERT WITH CHECK (auth.uid() = id);
CREATE POLICY "Users can update own profile" ON public.users FOR UPDATE USING (auth.uid() = id);

-- Bitkilerini okuyabilir ve ekleyebilir: Herkes sadece kendi eklediği bitkileri görebilir ve silebilir
CREATE POLICY "Users can manage own plants" ON public.plants FOR ALL USING (auth.uid() = user_id);

-- Sadece kendi görevlerini görebilir ve ekleyebilir
CREATE POLICY "Users can manage own schedules" ON public.schedules FOR ALL USING (auth.uid() = user_id);

-- Ansiklopedi Tablosu: Herkes okuyabilir (Select), ama kimse uygulama içinden düzenleyemez
CREATE POLICY "Everyone can read plant catalog" ON public.plant_catalog FOR SELECT USING (true);
