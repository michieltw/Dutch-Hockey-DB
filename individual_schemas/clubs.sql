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
