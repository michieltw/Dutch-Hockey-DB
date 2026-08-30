-- 3. rule_changes
CREATE TABLE rule_changes (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'RULC',
    rule_version_id UUID NOT NULL REFERENCES rule_versions(id) ON DELETE CASCADE,
    rule_number VARCHAR(50),
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE rule_changes ENABLE ROW LEVEL SECURITY;
