-- 34. editorial_columns
CREATE TABLE editorial_columns (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ECOL',
    name VARCHAR(100),
    author_id UUID REFERENCES authors(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE editorial_columns ENABLE ROW LEVEL SECURITY;
