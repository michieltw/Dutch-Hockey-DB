-- 13. cups
CREATE TABLE cups (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CUPS',
    name VARCHAR(255) NOT NULL,
    federation_id UUID REFERENCES federations(id) ON DELETE SET NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE cups ENABLE ROW LEVEL SECURITY;
