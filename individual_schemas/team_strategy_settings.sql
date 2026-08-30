-- team_strategy_settings.sql
CREATE TABLE team_strategy_settings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TMST',
    team_id UUID NOT NULL UNIQUE REFERENCES teams(id) ON DELETE CASCADE,
    default_offensive_scheme offensive_scheme_enum,
    default_defensive_scheme defensive_scheme_enum,
    powerplay_formation pp_formation_enum,
    penalty_kill_formation pk_formation_enum,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_team_strategy_settings_team_id ON team_strategy_settings(team_id);

ALTER TABLE team_strategy_settings ENABLE ROW LEVEL SECURITY;
