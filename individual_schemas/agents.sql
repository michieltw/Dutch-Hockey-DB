-- 14. agents
CREATE TABLE agents (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'AGNT',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    certification_number VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE agents ENABLE ROW LEVEL SECURITY;
