-- team_operations_settings.sql
CREATE TABLE team_operations_settings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TMOP',
    team_id UUID NOT NULL UNIQUE REFERENCES teams(id) ON DELETE CASCADE,
    home_arena_override_id UUID REFERENCES arenas(id) ON DELETE SET NULL,
    notify_staff_on_injury BOOLEAN DEFAULT TRUE,
    notify_staff_on_trade_offer BOOLEAN DEFAULT TRUE,
    social_media_auto_post_final_score BOOLEAN DEFAULT FALSE,
    x_handle VARCHAR(100),
    instagram_handle VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_team_operations_settings_team_id ON team_operations_settings(team_id);
CREATE INDEX idx_team_operations_settings_home_arena_override_id ON team_operations_settings(home_arena_override_id);

ALTER TABLE team_operations_settings ENABLE ROW LEVEL SECURITY;
