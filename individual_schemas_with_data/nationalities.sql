-- 3. nationalities
CREATE TABLE nationalities (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'NATI',
    name VARCHAR(100) NOT NULL,
    iso_code VARCHAR(3) NOT NULL,
    flag_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE nationalities ENABLE ROW LEVEL SECURITY;

-- Data for nationalities (focused on Benelux and major hockey nations)
INSERT INTO nationalities (id, name, iso_code) VALUES
(gen_random_uuid(), 'Netherlands', 'NLD'),
(gen_random_uuid(), 'Belgium', 'BEL'),
(gen_random_uuid(), 'Luxembourg', 'LUX'),
(gen_random_uuid(), 'Canada', 'CAN'),
(gen_random_uuid(), 'United States', 'USA'),
(gen_random_uuid(), 'Sweden', 'SWE'),
(gen_random_uuid(), 'Finland', 'FIN'),
(gen_random_uuid(), 'Czech Republic', 'CZE'),
(gen_random_uuid(), 'Germany', 'DEU'),
(gen_random_uuid(), 'Switzerland', 'CHE'),
(gen_random_uuid(), 'Slovakia', 'SVK'),
(gen_random_uuid(), 'Russia', 'RUS'),
(gen_random_uuid(), 'Latvia', 'LVA');

INSERT INTO nationalities (id, name, iso_code) VALUES
(gen_random_uuid(), 'Austria', 'AUT'),
(gen_random_uuid(), 'Denmark', 'DNK'),
(gen_random_uuid(), 'France', 'FRA'),
(gen_random_uuid(), 'Norway', 'NOR'),
(gen_random_uuid(), 'Great Britain', 'GBR'),
(gen_random_uuid(), 'Kazakhstan', 'KAZ'),
(gen_random_uuid(), 'Belarus', 'BLR'),
(gen_random_uuid(), 'Italy', 'ITA'),
(gen_random_uuid(), 'Slovenia', 'SVN'),
(gen_random_uuid(), 'Hungary', 'HUN'),
(gen_random_uuid(), 'Poland', 'POL'),
(gen_random_uuid(), 'Japan', 'JPN'),
(gen_random_uuid(), 'Ukraine', 'UKR'),
(gen_random_uuid(), 'South Korea', 'KOR'),
(gen_random_uuid(), 'China', 'CHN'),
(gen_random_uuid(), 'Romania', 'ROU'),
(gen_random_uuid(), 'Lithuania', 'LTU'),
(gen_random_uuid(), 'Estonia', 'EST');
