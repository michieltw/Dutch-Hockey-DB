-- 27. security_personnel
CREATE TABLE security_personnel (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SECU',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    arena_id UUID REFERENCES arenas(id) ON DELETE CASCADE,
    company_name VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE security_personnel ENABLE ROW LEVEL SECURITY;
