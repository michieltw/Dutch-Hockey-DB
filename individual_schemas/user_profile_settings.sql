-- user_profile_settings.sql
CREATE TABLE user_profile_settings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'UPRF',
    user_id UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
    avatar_url VARCHAR(255),
    cover_photo_url VARCHAR(255),
    bio TEXT,
    favorite_team_id UUID REFERENCES teams(id) ON DELETE SET NULL,
    favorite_player_id UUID REFERENCES players(id) ON DELETE SET NULL,
    show_achievements BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_user_profile_settings_user_id ON user_profile_settings(user_id);
CREATE INDEX idx_user_profile_settings_favorite_team_id ON user_profile_settings(favorite_team_id);
CREATE INDEX idx_user_profile_settings_favorite_player_id ON user_profile_settings(favorite_player_id);

ALTER TABLE user_profile_settings ENABLE ROW LEVEL SECURITY;
