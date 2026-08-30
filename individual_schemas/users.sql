-- 10. users
CREATE TABLE users (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'USER',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    username VARCHAR(100) UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(50),
    primary_role user_role_enum,
    is_verified BOOLEAN DEFAULT FALSE,
    is_suspended BOOLEAN DEFAULT FALSE,
    suspension_reason TEXT,
    last_login TIMESTAMPTZ,
    last_ip_address VARCHAR(45),
    failed_login_attempts INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_users_person_id ON users(person_id);

ALTER TABLE users ENABLE ROW LEVEL SECURITY;
