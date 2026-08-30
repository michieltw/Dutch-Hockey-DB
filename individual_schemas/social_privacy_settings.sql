-- social_privacy_settings.sql
CREATE TABLE social_privacy_settings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SCPS',
    user_id UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
    allow_direct_messages BOOLEAN DEFAULT TRUE,
    show_online_status BOOLEAN DEFAULT TRUE,
    share_activity_feed BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_social_privacy_settings_user_id ON social_privacy_settings(user_id);

ALTER TABLE social_privacy_settings ENABLE ROW LEVEL SECURITY;
