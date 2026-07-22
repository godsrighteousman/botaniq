-- =============================================================
-- Botaniq v3 Seed Catalog Data
-- Tarih: 2026-07-19
-- İçerik: Popüler bitkiler için plant_catalog tablosuna veri ekleme
-- =============================================================

INSERT INTO public.plant_catalog (
  name, species, description, difficulty, toxicity, is_toxic_to_pets, is_toxic_to_humans, 
  environment, sunlight, ideal_climate, humidity, temperature_range, watering_protocol, feeding_protocol, image
) VALUES 
(
  'Monstera', 
  'Monstera deliciosa', 
  'Known for its dramatic leaf fenestrations, the Monstera Deliciosa is a staple of modern indoor plant design.', 
  'Medium', 
  'Toxic to cats and dogs due to calcium oxalate crystals.', 
  true, 
  true, 
  'Indoor', 
  'Bright Indirect', 
  'Warm & Humid', 
  'High (60-80%)', 
  '18-27°C', 
  'Water every 7-10 days, allow top 2 inches of soil to dry out between waterings.', 
  'Feed monthly during spring and summer with liquid plant food.',
  'https://images.unsplash.com/photo-1614594975525-e45190c55d0b?auto=format&fit=crop&q=80&w=600'
),
(
  'Rubber Plant', 
  'Ficus elastica', 
  'The Ficus Elastica features glossy, leathery leaves that can range from deep green to almost black.', 
  'Medium', 
  'Sap is toxic to pets and can cause skin irritation.', 
  true, 
  true, 
  'Indoor', 
  'Bright Indirect', 
  'Warm & Semi-humid', 
  'Medium (40-60%)', 
  '16-24°C', 
  'Water every 1-2 weeks. Let the topsoil dry out completely before watering again.', 
  'Fertilize once or twice in spring and summer.',
  'https://images.unsplash.com/photo-1597055905001-c888d3f6d7ab?auto=format&fit=crop&q=80&w=600'
),
(
  'Snake Plant', 
  'Sansevieria trifasciata', 
  'An incredibly hearty option, the Snake Plant has sword-like upright leaves and excels at air purification.', 
  'Easy', 
  'Toxic to pets if chewed or ingested.', 
  true, 
  false, 
  'Indoor', 
  'Low Light', 
  'Dry & Warm', 
  'Low (30-40%)', 
  '15-29°C', 
  'Water every 2-3 weeks, let soil dry completely between watering. Highly drought-tolerant.', 
  'Feed once a year in spring.',
  'https://images.unsplash.com/photo-1593482892290-f54927ae1b7e?auto=format&fit=crop&q=80&w=600'
),
(
  'Aloe Vera', 
  'Aloe barbadensis', 
  'A stemless succulent famous for the soothing, medicinal gel found inside its thick, fleshy leaves.', 
  'Easy', 
  'Toxic to dogs and cats.', 
  true, 
  false, 
  'Both', 
  'Full Sun', 
  'Dry & Hot', 
  'Low (30-40%)', 
  '13-27°C', 
  'Water deeply but infrequently (every 3 weeks). Allow root ball to dry out completely.', 
  'Do not fertilize more than once a year.',
  'https://images.unsplash.com/photo-1596547609652-9fc5d8d428ce?auto=format&fit=crop&q=80&w=600'
),
(
  'Devils Ivy', 
  'Epipremnum aureum', 
  'Also known as Pothos, this trailing evergreen vine is famous for being nearly impossible to kill.', 
  'Easy', 
  'Toxic to cats and dogs.', 
  true, 
  false, 
  'Indoor', 
  'Bright Indirect', 
  'Warm & Humid', 
  'Medium (40-60%)', 
  '15-29°C', 
  'Water every 1-2 weeks. Let soil dry out between waterings. Yellow leaves mean too much water.', 
  'Feed every 2-3 months.',
  'https://images.unsplash.com/photo-1604762512526-b7ce049b5768?auto=format&fit=crop&q=80&w=600'
),
(
  'ZZ Plant', 
  'Zamioculcas zamiifolia', 
  'Features wide, dark green, highly glossy leaves. Excellent choice for windowless offices or low-light rooms.', 
  'Easy', 
  'Mildly toxic to pets and humans.', 
  true, 
  true, 
  'Indoor', 
  'Low Light', 
  'Dry to Average', 
  'Low to Medium', 
  '18-24°C', 
  'Water every 3-4 weeks. Extremely drought-resistant, can go months without watering.', 
  'Fertilize once or twice during green season.',
  'https://images.unsplash.com/photo-1632207691143-643e2a9a9361?auto=format&fit=crop&q=80&w=600'
);
