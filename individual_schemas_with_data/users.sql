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

-- Data for users (placeholders for retailers)
INSERT INTO users (id, person_id, username, password_hash) VALUES
('11111111-1111-1111-1111-111111111111', '00000000-0000-0000-0000-000000000001', 'ijshockeyshopnl', 'mock_hash_1'),
('11111111-1111-1111-1111-111111111112', '00000000-0000-0000-0000-000000000002', 'prohockey', 'mock_hash_2'),
('11111111-1111-1111-1111-111111111113', '00000000-0000-0000-0000-000000000003', 'waterman', 'mock_hash_3'),
('11111111-1111-1111-1111-111111111114', '00000000-0000-0000-0000-000000000004', 'hockeygear', 'mock_hash_4');
