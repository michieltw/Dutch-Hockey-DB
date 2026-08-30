-- 13. appeals
CREATE TABLE appeals (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'APPL',
    incident_id UUID REFERENCES incident_reports(id) ON DELETE CASCADE,
    filed_by_id UUID REFERENCES persons(id) ON DELETE CASCADE,
    description TEXT,
    status VARCHAR(50),
    resolution TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE appeals ENABLE ROW LEVEL SECURITY;
