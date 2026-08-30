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
