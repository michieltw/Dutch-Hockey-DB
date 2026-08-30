-- team_branding_settings.sql
CREATE TABLE team_branding_settings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TMBR',
    team_id UUID NOT NULL UNIQUE REFERENCES teams(id) ON DELETE CASCADE,
    primary_color_hex VARCHAR(7),
    secondary_color_hex VARCHAR(7),
    tertiary_color_hex VARCHAR(7),
    jersey_home_image_url VARCHAR(255),
    jersey_away_image_url VARCHAR(255),
    goal_horn_audio_url VARCHAR(255),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_team_branding_settings_team_id ON team_branding_settings(team_id);

ALTER TABLE team_branding_settings ENABLE ROW LEVEL SECURITY;
