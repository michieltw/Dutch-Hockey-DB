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
