-- 6. rulebooks
CREATE TABLE rulebooks (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'RULE',
    name VARCHAR(255) NOT NULL, -- e.g. "IIHF Official Rule Book"
    publisher VARCHAR(255),
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE rulebooks ENABLE ROW LEVEL SECURITY;
