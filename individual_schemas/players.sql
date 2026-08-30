-- 7. players
CREATE TABLE players (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PLYR',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    nationality_id UUID REFERENCES nationalities(id) ON DELETE SET NULL,
    known_as VARCHAR(100),
    height_cm INTEGER,
    weight_kg INTEGER,
    shoots shoots_catches_enum,
    catches shoots_catches_enum,
    primary_position position_enum,
    player_role player_role_enum,
    jersey_number INTEGER,
    birth_city VARCHAR(100),
    birth_state VARCHAR(100),
    birth_country VARCHAR(100),
    draft_year INTEGER,
    draft_overall_pick INTEGER,
    nhl_draft_team_id UUID REFERENCES teams(id) ON DELETE SET NULL,
    cap_hit NUMERIC,
    is_alternate_captain BOOLEAN DEFAULT FALSE,
    is_rookie BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    ijnl_id VARCHAR(50),
    elite_prospects_id VARCHAR(50),
    nhl_id VARCHAR(50),
    iihf_id VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_players_person_id ON players(person_id);
CREATE INDEX idx_players_nationality_id ON players(nationality_id);
CREATE INDEX idx_players_nhl_draft_team_id ON players(nhl_draft_team_id);

ALTER TABLE players ENABLE ROW LEVEL SECURITY;
