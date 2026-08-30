-- 3. nationalities
CREATE TABLE nationalities (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'NATI',
    name VARCHAR(100) NOT NULL,
    iso_code VARCHAR(3) NOT NULL,
    flag_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE nationalities ENABLE ROW LEVEL SECURITY;
