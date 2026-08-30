-- 4. penalties
CREATE TABLE penalties (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PENA',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    period_id UUID REFERENCES periods(id) ON DELETE SET NULL,
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    player_id UUID REFERENCES players(id) ON DELETE SET NULL,
    drawn_by_player_id UUID REFERENCES players(id) ON DELETE SET NULL,
    penalty_type penalty_type_enum,
    infraction penalty_infraction_enum,
    time_of_penalty INTERVAL,
    duration_minutes INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE penalties ENABLE ROW LEVEL SECURITY;
