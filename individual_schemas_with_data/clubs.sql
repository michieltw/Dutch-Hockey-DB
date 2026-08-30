-- 4. clubs
CREATE TABLE clubs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CLUB',
    organization_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    federation_id UUID REFERENCES federations(id) ON DELETE SET NULL,
    home_arena_id UUID REFERENCES arenas(id) ON DELETE SET NULL,
    primary_color VARCHAR(20),
    secondary_color VARCHAR(20),
    ijnl_id VARCHAR(50),
    elite_prospects_id VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE clubs ENABLE ROW LEVEL SECURITY;

-- Data for clubs
INSERT INTO clubs (id, organization_id, primary_color, secondary_color) VALUES
(gen_random_uuid(), (SELECT id FROM organizations WHERE name = 'GIJS Groningen'), '#E31837', '#FFFFFF'),
(gen_random_uuid(), (SELECT id FROM organizations WHERE name = 'Tilburg Trappers'), '#FDB913', '#0033A0'),
(gen_random_uuid(), (SELECT id FROM organizations WHERE name = 'UNIS Flyers Heerenveen'), '#000000', '#FF0000'),
(gen_random_uuid(), (SELECT id FROM organizations WHERE name = 'Hijs Hokij Den Haag'), '#E31837', '#000000'),
(gen_random_uuid(), (SELECT id FROM organizations WHERE name = 'Snackpoint Eaters Limburg'), '#E31837', '#FFFFFF'),
(gen_random_uuid(), (SELECT id FROM organizations WHERE name = 'Nijmegen Devils'), '#000000', '#E31837'),
(gen_random_uuid(), (SELECT id FROM organizations WHERE name = 'Bulldogs Liège'), '#0033A0', '#FDB913'),
(gen_random_uuid(), (SELECT id FROM organizations WHERE name = 'Chiefs Leuven'), '#000000', '#FFFFFF'),
(gen_random_uuid(), (SELECT id FROM organizations WHERE name = 'Phantoms Antwerp'), '#0033A0', '#FFFFFF'),
(gen_random_uuid(), (SELECT id FROM organizations WHERE name = 'Tornado Luxembourg'), '#000000', '#FDB913');
