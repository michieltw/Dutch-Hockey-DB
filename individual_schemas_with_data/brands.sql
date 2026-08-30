-- 9. brands (for Marketplace and Equipment)
CREATE TABLE brands (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'BRND',
    name VARCHAR(100) NOT NULL,
    description TEXT,
    logo_url TEXT,
    website_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE brands ENABLE ROW LEVEL SECURITY;

-- Data for brands
INSERT INTO brands (id, name, description, website_url) VALUES
(gen_random_uuid(), 'Bauer', 'Leading manufacturer of ice hockey equipment.', 'https://www.bauer.com'),
(gen_random_uuid(), 'CCM', 'Major brand in ice hockey gear and apparel.', 'https://ccmhockey.com'),
(gen_random_uuid(), 'Warrior', 'Ice hockey equipment brand known for sticks and protective gear.', 'https://www.warrior.com'),
(gen_random_uuid(), 'True', 'Performance-driven ice hockey equipment brand.', 'https://www.truetemperhockey.com'),
(gen_random_uuid(), 'Sher-Wood', 'Classic ice hockey equipment brand.', 'https://sherwoodhockey.com');

INSERT INTO brands (id, name) VALUES
(gen_random_uuid(), 'Blackout Hockey'),
(gen_random_uuid(), 'Soyuz'),
(gen_random_uuid(), 'Winwell'),
(gen_random_uuid(), 'Fischer'),
(gen_random_uuid(), 'STX'),
(gen_random_uuid(), 'Reebok'),
(gen_random_uuid(), 'Nike'),
(gen_random_uuid(), 'Easton'),
(gen_random_uuid(), 'Koho'),
(gen_random_uuid(), 'Frontier'),
(gen_random_uuid(), 'Accent'),
(gen_random_uuid(), 'Hockeystickman'),
(gen_random_uuid(), 'Pro Reserve'),
(gen_random_uuid(), 'Twig'),
(gen_random_uuid(), 'Christian'),
(gen_random_uuid(), 'Canadian'),
(gen_random_uuid(), 'Colt'),
(gen_random_uuid(), 'Epix'),
(gen_random_uuid(), 'KYC'),
(gen_random_uuid(), 'Odin'),
(gen_random_uuid(), 'Hoapa'),
(gen_random_uuid(), 'Graf'),
(gen_random_uuid(), 'Vaughn'),
(gen_random_uuid(), 'Jofa'),
(gen_random_uuid(), 'Tackla'),
(gen_random_uuid(), 'Heaton'),
(gen_random_uuid(), 'Brian''s'),
(gen_random_uuid(), 'Itech'),
(gen_random_uuid(), 'Eagle'),
(gen_random_uuid(), 'Mission'),
(gen_random_uuid(), 'TPS');
