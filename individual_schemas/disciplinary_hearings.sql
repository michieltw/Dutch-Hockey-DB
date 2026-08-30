-- 15. disciplinary_hearings
CREATE TABLE disciplinary_hearings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'DISH',
    incident_id UUID REFERENCES incident_reports(id) ON DELETE CASCADE,
    hearing_date TIMESTAMPTZ,
    outcome TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE disciplinary_hearings ENABLE ROW LEVEL SECURITY;
