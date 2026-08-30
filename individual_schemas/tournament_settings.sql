-- tournament_settings.sql
CREATE TABLE tournament_settings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TRNS',
    tournament_id UUID NOT NULL UNIQUE REFERENCES tournaments(id) ON DELETE CASCADE,
    format tournament_format_enum DEFAULT 'Round Robin',
    tiebreaker_1 tiebreaker_enum,
    tiebreaker_2 tiebreaker_enum,
    tiebreaker_3 tiebreaker_enum,
    group_count INT,
    teams_advancing_per_group INT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_tournament_settings_tournament_id ON tournament_settings(tournament_id);

ALTER TABLE tournament_settings ENABLE ROW LEVEL SECURITY;
