-- user_connected_accounts.sql
CREATE TABLE user_connected_accounts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'UCON',
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    provider provider_enum NOT NULL,
    provider_account_id VARCHAR(255) NOT NULL,
    sync_avatar BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_user_connected_accounts_user_id ON user_connected_accounts(user_id);

ALTER TABLE user_connected_accounts ENABLE ROW LEVEL SECURITY;
