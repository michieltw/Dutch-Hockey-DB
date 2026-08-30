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
(gen_random_uuid(), 'c0000000-0000-0000-0000-000000000001', '#E31837', '#FFFFFF'), -- GIJS Groningen (Red/White)
(gen_random_uuid(), 'c0000000-0000-0000-0000-000000000002', '#FDB913', '#0033A0'), -- Tilburg Trappers (Yellow/Blue)
(gen_random_uuid(), 'c0000000-0000-0000-0000-000000000003', '#000000', '#FF0000'), -- UNIS Flyers (Black/Red)
(gen_random_uuid(), 'c0000000-0000-0000-0000-000000000004', '#E31837', '#000000'), -- Hijs Hokij (Red/Black)
(gen_random_uuid(), 'c0000000-0000-0000-0000-000000000005', '#E31837', '#FFFFFF'), -- Eaters (Red/White)
(gen_random_uuid(), 'c0000000-0000-0000-0000-000000000006', '#000000', '#E31837'), -- Devils (Black/Red)
(gen_random_uuid(), 'c0000000-0000-0000-0000-000000000007', '#0033A0', '#FDB913'), -- Bulldogs (Blue/Yellow)
(gen_random_uuid(), 'c0000000-0000-0000-0000-000000000008', '#000000', '#FFFFFF'), -- Chiefs (Black/White)
(gen_random_uuid(), 'c0000000-0000-0000-0000-000000000009', '#0033A0', '#FFFFFF'), -- Phantoms (Blue/White)
(gen_random_uuid(), 'c0000000-0000-0000-0000-000000000010', '#000000', '#FDB913'); -- Tornado (Black/Yellow)
