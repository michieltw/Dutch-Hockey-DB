-- user_app_settings.sql
CREATE TABLE user_app_settings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'UAPP',
    user_id UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
    ui_theme theme_enum DEFAULT 'System',
    language VARCHAR(10) DEFAULT 'en',
    timezone VARCHAR(50),
    email_notifications BOOLEAN DEFAULT TRUE,
    push_notifications BOOLEAN DEFAULT TRUE,
    visibility profile_visibility_enum DEFAULT 'Public',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_user_app_settings_user_id ON user_app_settings(user_id);

ALTER TABLE user_app_settings ENABLE ROW LEVEL SECURITY;
