-- league_game_rules_settings.sql
CREATE TABLE league_game_rules_settings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LGRS',
    league_id UUID NOT NULL UNIQUE REFERENCES leagues(id) ON DELETE CASCADE,
    period_length_minutes INT DEFAULT 20,
    number_of_periods INT DEFAULT 3,
    minor_penalty_minutes INT DEFAULT 2,
    major_penalty_minutes INT DEFAULT 5,
    misconduct_penalty_minutes INT DEFAULT 10,
    overtime_format overtime_format_enum DEFAULT '5v5',
    overtime_length_minutes INT DEFAULT 5,
    shootout_enabled BOOLEAN DEFAULT TRUE,
    shootout_rounds INT DEFAULT 3,
    points_for_win INT DEFAULT 3,
    points_for_ot_win INT DEFAULT 2,
    points_for_ot_loss INT DEFAULT 1,
    icing_rule icing_rule_enum DEFAULT 'Hybrid',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_league_game_rules_settings_league_id ON league_game_rules_settings(league_id);

ALTER TABLE league_game_rules_settings ENABLE ROW LEVEL SECURITY;
