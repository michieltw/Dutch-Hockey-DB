-- pre_game_settings.sql
CREATE TABLE pre_game_settings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PRGS',
    league_id UUID REFERENCES leagues(id) ON DELETE CASCADE,
    tournament_id UUID REFERENCES tournaments(id) ON DELETE CASCADE,
    warmup_duration_minutes INT DEFAULT 15,
    anthem_required BOOLEAN DEFAULT FALSE,
    roster_lock_minutes_before_puck_drop INT DEFAULT 60,
    starting_lineup_announcement_required BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    CHECK (
        (league_id IS NOT NULL AND tournament_id IS NULL) OR
        (league_id IS NULL AND tournament_id IS NOT NULL)
    )
);

CREATE INDEX idx_pre_game_settings_league_id ON pre_game_settings(league_id);
CREATE INDEX idx_pre_game_settings_tournament_id ON pre_game_settings(tournament_id);

ALTER TABLE pre_game_settings ENABLE ROW LEVEL SECURITY;
