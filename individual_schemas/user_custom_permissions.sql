-- user_custom_permissions.sql
CREATE TABLE user_custom_permissions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'USCP',
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    permission_id UUID NOT NULL REFERENCES permissions(id) ON DELETE CASCADE,
    is_allowed BOOLEAN,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_user_custom_permissions_user_id ON user_custom_permissions(user_id);
CREATE INDEX idx_user_custom_permissions_permission_id ON user_custom_permissions(permission_id);

ALTER TABLE user_custom_permissions ENABLE ROW LEVEL SECURITY;
