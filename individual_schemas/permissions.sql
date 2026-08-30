-- permissions.sql
CREATE TABLE permissions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PERM',
    name VARCHAR(255) NOT NULL,
    description TEXT,
    module VARCHAR(255),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE permissions ENABLE ROW LEVEL SECURITY;
