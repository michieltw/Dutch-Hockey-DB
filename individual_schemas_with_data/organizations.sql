-- 2. organizations (Core entity record)
CREATE TABLE organizations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ORGA',
    organization_type organization_type_enum NOT NULL,
    name VARCHAR(255) NOT NULL,
    abbreviation VARCHAR(50),
    founded_year INTEGER,
    website_url TEXT,
    logo_url TEXT,
    contact_email VARCHAR(255),
    contact_phone VARCHAR(50),
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    city VARCHAR(100),
    state_province VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100),
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE organizations ENABLE ROW LEVEL SECURITY;

-- Initial Data for organizations (Federations)
-- Need to insert organizations first to reference them in federations
INSERT INTO organizations (id, organization_type, name, abbreviation, website_url, country) VALUES
('f0000000-0000-0000-0000-000000000001', 'Federation', 'IJshockey Nederland', 'IJNL', 'https://www.ijshockeynederland.nl', 'Netherlands'),
('f0000000-0000-0000-0000-000000000002', 'Federation', 'Royal Belgian Ice Hockey Federation', 'RBIHF', 'https://www.rbihf.be', 'Belgium'),
('f0000000-0000-0000-0000-000000000003', 'Federation', 'Fédération Luxembourgeoise de Hockey sur Glace', 'FLHG', 'http://www.icehockey.lu/', 'Luxembourg'),
('f0000000-0000-0000-0000-000000000004', 'Federation', 'International Ice Hockey Federation', 'IIHF', 'https://www.iihf.com', 'Switzerland');

-- Initial Data for organizations (Clubs in Benelux)
INSERT INTO organizations (id, organization_type, name, abbreviation, city, country) VALUES
('c0000000-0000-0000-0000-000000000001', 'Club', 'GIJS Groningen', 'GIJS', 'Groningen', 'Netherlands'),
('c0000000-0000-0000-0000-000000000002', 'Club', 'Tilburg Trappers', 'TIL', 'Tilburg', 'Netherlands'),
('c0000000-0000-0000-0000-000000000003', 'Club', 'UNIS Flyers Heerenveen', 'HEE', 'Heerenveen', 'Netherlands'),
('c0000000-0000-0000-0000-000000000004', 'Club', 'Hijs Hokij Den Haag', 'DHG', 'The Hague', 'Netherlands'),
('c0000000-0000-0000-0000-000000000005', 'Club', 'Snackpoint Eaters Limburg', 'GEE', 'Geleen', 'Netherlands'),
('c0000000-0000-0000-0000-000000000006', 'Club', 'Nijmegen Devils', 'NIJ', 'Nijmegen', 'Netherlands'),
('c0000000-0000-0000-0000-000000000007', 'Club', 'Bulldogs Liège', 'LIE', 'Liège', 'Belgium'),
('c0000000-0000-0000-0000-000000000008', 'Club', 'Chiefs Leuven', 'LEU', 'Leuven', 'Belgium'),
('c0000000-0000-0000-0000-000000000009', 'Club', 'Phantoms Antwerp', 'ANT', 'Antwerp', 'Belgium'),
('c0000000-0000-0000-0000-000000000010', 'Club', 'Tornado Luxembourg', 'TOR', 'Kockelscheuer', 'Luxembourg');
