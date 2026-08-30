-- 2. arenas
CREATE TABLE arenas (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'AREN',
    name VARCHAR(255) NOT NULL,
    abbreviation VARCHAR(50),
    capacity INTEGER,
    year_built INTEGER,
    address_line1 VARCHAR(255),
    city VARCHAR(100),
    state_province VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100),
    latitude NUMERIC(10, 8),
    longitude NUMERIC(11, 8),
    image_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE arenas ENABLE ROW LEVEL SECURITY;

-- Data for arenas
INSERT INTO arenas (id, name, capacity, city, country) VALUES
(gen_random_uuid(), 'Sportcentrum Kardinge', 800, 'Groningen', 'Netherlands'),
(gen_random_uuid(), 'IJssportcentrum Stappegoor', 2500, 'Tilburg', 'Netherlands'),
(gen_random_uuid(), 'Thialf', 3300, 'Heerenveen', 'Netherlands'),
(gen_random_uuid(), 'De Uithof', 2600, 'The Hague', 'Netherlands'),
(gen_random_uuid(), 'Glanerbrook', 1200, 'Geleen', 'Netherlands'),
(gen_random_uuid(), 'Triavium', 1450, 'Nijmegen', 'Netherlands'),
(gen_random_uuid(), 'Patinoire de Liège', 1250, 'Liège', 'Belgium'),
(gen_random_uuid(), 'IJsbaan Leuven', 800, 'Leuven', 'Belgium'),
(gen_random_uuid(), 'Sportoase Groot Schijn', 1000, 'Antwerp', 'Belgium'),
(gen_random_uuid(), 'Patinoire Kockelscheuer', 1000, 'Kockelscheuer', 'Luxembourg');

INSERT INTO arenas (id, name, city, country) VALUES
(gen_random_uuid(), '11Stedenhal', 'Leeuwarden', 'Nederland'),
(gen_random_uuid(), 'De Meent', 'Alkmaar', 'Nederland'),
(gen_random_uuid(), 'IJsbaan Twente', 'Enschede', 'Nederland'),
(gen_random_uuid(), 'Jaap Eden', 'Amsterdam', 'Nederland'),
(gen_random_uuid(), 'IJssportcentrum', 'Eindhoven', 'Nederland'),
(gen_random_uuid(), 'Sportboulevard Dordrecht', 'Dordrecht', 'Nederland'),
(gen_random_uuid(), 'De Vechtsebanen', 'Utrecht', 'Nederland'),
(gen_random_uuid(), 'De Westfries', 'Hoorn', 'Nederland'),
(gen_random_uuid(), 'IJshal De Vliet', 'Leiden', 'Nederland'),
(gen_random_uuid(), 'IceFun Sportiom', 'Den Bosch', 'Nederland'),
(gen_random_uuid(), 'SilverDome', 'Zoetermeer', 'Nederland'),
(gen_random_uuid(), 'Kunstijsbaan Breda', 'Breda', 'Nederland'),
(gen_random_uuid(), 'IJsbaan Haarlem', 'Haarlem', 'Nederland'),
(gen_random_uuid(), 'Sport Vlaanderen Herentals', 'Herentals', 'België'),
(gen_random_uuid(), 'Patinoire de Charleroi', 'Charleroi', 'België'),
(gen_random_uuid(), 'IJsbaan Kristallijn', 'Gent', 'België'),
(gen_random_uuid(), 'Sport Vlaanderen (Schaverdijn)', 'Hasselt', 'België'),
(gen_random_uuid(), 'IJsbaan De Piste', 'Kortrijk', 'België'),
(gen_random_uuid(), 'IJsbaan Netepark', 'Herentals', 'België'),
(gen_random_uuid(), 'IJsbaan Heuvelkouter', 'Liedekerke', 'België'),
(gen_random_uuid(), 'Sportcentrum Die Swaene', 'Heist-op-den-Berg', 'België'),
(gen_random_uuid(), 'Ice Skating Center Mechelen', 'Mechelen', 'België'),
(gen_random_uuid(), 'IJsbaan Finlandia', 'Gullegem', 'België'),
(gen_random_uuid(), 'Ice Park Beaufort', 'Beaufort', 'Luxemburg');
