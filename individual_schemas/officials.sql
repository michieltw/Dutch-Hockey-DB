-- 13. officials (Referees, Linesmen)
CREATE TABLE officials (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'OFFI',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    federation_id UUID REFERENCES federations(id) ON DELETE SET NULL,
    certification_level VARCHAR(50),
    years_experience INTEGER,
    is_active BOOLEAN DEFAULT TRUE,
    ijnl_id VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE officials ENABLE ROW LEVEL SECURITY;
