-- 49. trophies
CREATE TABLE trophies (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TROP',
    name VARCHAR(255),
    description TEXT,
    league_id UUID REFERENCES leagues(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE trophies ENABLE ROW LEVEL SECURITY;
