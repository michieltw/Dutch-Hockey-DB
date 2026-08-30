-- 7. players
CREATE TABLE players (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PLYR',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    nationality_id UUID REFERENCES nationalities(id) ON DELETE SET NULL,
    height_cm INTEGER,
    weight_kg INTEGER,
    shoots shoots_catches_enum,
    primary_position position_enum,
    player_role player_role_enum,
    birth_city VARCHAR(100),
    birth_country VARCHAR(100),
    draft_year INTEGER,
    draft_overall_pick INTEGER,
    is_active BOOLEAN DEFAULT TRUE,
    ijnl_id VARCHAR(50),
    elite_prospects_id VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE players ENABLE ROW LEVEL SECURITY;
