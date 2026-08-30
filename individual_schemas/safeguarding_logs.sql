-- 8. safeguarding_logs
CREATE TABLE safeguarding_logs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SAFE',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    document_type VARCHAR(100), -- 'VOG'
    issue_date DATE,
    expiry_date DATE,
    status VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE safeguarding_logs ENABLE ROW LEVEL SECURITY;
