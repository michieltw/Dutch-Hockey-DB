-- 2. rule_versions
CREATE TABLE rule_versions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'RULV',
    rulebook_id UUID NOT NULL REFERENCES rulebooks(id) ON DELETE CASCADE,
    version_string VARCHAR(50),
    effective_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE rule_versions ENABLE ROW LEVEL SECURITY;
