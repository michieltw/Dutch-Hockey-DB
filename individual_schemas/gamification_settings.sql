-- gamification_settings.sql
CREATE TABLE gamification_settings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'GMFS',
    league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
    achievements_enabled BOOLEAN DEFAULT TRUE,
    fan_predictions_enabled BOOLEAN DEFAULT TRUE,
    leaderboard_visible BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_gamification_settings_league_id ON gamification_settings(league_id);

ALTER TABLE gamification_settings ENABLE ROW LEVEL SECURITY;
