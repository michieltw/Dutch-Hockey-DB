-- league_roster_rules_settings.sql
CREATE TABLE league_roster_rules_settings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LRRS',
    league_id UUID NOT NULL UNIQUE REFERENCES leagues(id) ON DELETE CASCADE,
    max_active_roster INT DEFAULT 23,
    min_active_roster INT DEFAULT 20,
    max_dressed_game INT DEFAULT 20,
    max_dressed_goalies INT DEFAULT 2,
    max_imports INT,
    min_age_eligible INT,
    max_age_eligible INT,
    allow_age_dispensations BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_league_roster_rules_settings_league_id ON league_roster_rules_settings(league_id);

ALTER TABLE league_roster_rules_settings ENABLE ROW LEVEL SECURITY;
