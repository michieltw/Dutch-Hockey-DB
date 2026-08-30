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
(gen_random_uuid(), 'Federation', 'IJshockey Nederland', 'IJNL', 'https://www.ijshockeynederland.nl', 'Netherlands'),
(gen_random_uuid(), 'Federation', 'Royal Belgian Ice Hockey Federation', 'RBIHF', 'https://www.rbihf.be', 'Belgium'),
(gen_random_uuid(), 'Federation', 'Fédération Luxembourgeoise de Hockey sur Glace', 'FLHG', 'http://www.icehockey.lu/', 'Luxembourg'),
(gen_random_uuid(), 'Federation', 'International Ice Hockey Federation', 'IIHF', 'https://www.iihf.com', 'Switzerland');

-- Initial Data for organizations (Clubs in Benelux)
INSERT INTO organizations (id, organization_type, name, abbreviation, city, country) VALUES
(gen_random_uuid(), 'Club', 'GIJS Groningen', 'GIJS', 'Groningen', 'Netherlands'),
(gen_random_uuid(), 'Club', 'Tilburg Trappers', 'TIL', 'Tilburg', 'Netherlands'),
(gen_random_uuid(), 'Club', 'UNIS Flyers Heerenveen', 'HEE', 'Heerenveen', 'Netherlands'),
(gen_random_uuid(), 'Club', 'Hijs Hokij Den Haag', 'DHG', 'The Hague', 'Netherlands'),
(gen_random_uuid(), 'Club', 'Snackpoint Eaters Limburg', 'GEE', 'Geleen', 'Netherlands'),
(gen_random_uuid(), 'Club', 'Nijmegen Devils', 'NIJ', 'Nijmegen', 'Netherlands'),
(gen_random_uuid(), 'Club', 'Bulldogs Liège', 'LIE', 'Liège', 'Belgium'),
(gen_random_uuid(), 'Club', 'Chiefs Leuven', 'LEU', 'Leuven', 'Belgium'),
(gen_random_uuid(), 'Club', 'Phantoms Antwerp', 'ANT', 'Antwerp', 'Belgium'),
(gen_random_uuid(), 'Club', 'Tornado Luxembourg', 'TOR', 'Kockelscheuer', 'Luxembourg');

-- Initial Data for organizations (Retailers / Vendors)
INSERT INTO organizations (id, organization_type, name, website_url, country) VALUES
(gen_random_uuid(), 'Vendor', 'IJshockeyshop.nl', 'https://www.ijshockeyshop.nl', 'Netherlands'),
(gen_random_uuid(), 'Vendor', 'Pro Hockey', 'https://www.prohockey.nl', 'Netherlands'),
(gen_random_uuid(), 'Vendor', 'Waterman Sport', 'https://www.waterman-sport.nl', 'Netherlands'),
(gen_random_uuid(), 'Vendor', 'Hockeygear.eu', 'https://www.hockeygear.eu', 'Netherlands');
