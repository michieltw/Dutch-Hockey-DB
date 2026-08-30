-- 12. incident_reports
CREATE TABLE incident_reports (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'INCR',
    game_id UUID REFERENCES games(id) ON DELETE SET NULL,
    reported_by_id UUID REFERENCES users(id) ON DELETE SET NULL,
    incident_date TIMESTAMPTZ,
    description TEXT,
    status VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE incident_reports ENABLE ROW LEVEL SECURITY;
