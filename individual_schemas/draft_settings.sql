-- draft_settings.sql
CREATE TABLE draft_settings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'DRFS',
    league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
    season_id UUID NOT NULL REFERENCES seasons(id) ON DELETE CASCADE,
    number_of_rounds INT DEFAULT 7,
    time_limit_per_pick_seconds INT DEFAULT 180,
    draft_format draft_format_enum DEFAULT 'Standard',
    lottery_enabled BOOLEAN DEFAULT FALSE,
    min_eligible_birth_year INT,
    max_eligible_birth_year INT,
    allow_pick_trading BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_draft_settings_league_id ON draft_settings(league_id);
CREATE INDEX idx_draft_settings_season_id ON draft_settings(season_id);

ALTER TABLE draft_settings ENABLE ROW LEVEL SECURITY;
