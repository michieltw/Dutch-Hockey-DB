-- 8. coaches
CREATE TABLE coaches (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'COCH',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    coaching_level VARCHAR(50),
    years_experience INTEGER,
    is_active BOOLEAN DEFAULT TRUE,
    ijnl_id VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE coaches ENABLE ROW LEVEL SECURITY;
