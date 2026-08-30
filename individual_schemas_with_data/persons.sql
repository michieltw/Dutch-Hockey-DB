-- 1. persons (Core human record)
CREATE TABLE persons (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PERS',
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    gender VARCHAR(20),
    email VARCHAR(255),
    phone_number VARCHAR(50),
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    city VARCHAR(100),
    state_province VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100),
    profile_picture_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE persons ENABLE ROW LEVEL SECURITY;

-- Data for persons (for retailers)
INSERT INTO persons (id, first_name, last_name, email) VALUES
('00000000-0000-0000-0000-000000000001', 'Shop', 'IJshockeyshop', 'info@ijshockeyshop.nl'),
('00000000-0000-0000-0000-000000000002', 'Pro', 'Hockey', 'info@prohockey.nl'),
('00000000-0000-0000-0000-000000000003', 'Waterman', 'Sport', 'info@waterman-sport.nl'),
('00000000-0000-0000-0000-000000000004', 'Hockeygear', 'Eu', 'info@hockeygear.eu');
