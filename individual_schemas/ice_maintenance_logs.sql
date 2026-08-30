-- 18. ice_maintenance_logs
CREATE TABLE ice_maintenance_logs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ICML',
    rink_id UUID NOT NULL REFERENCES rinks(id) ON DELETE CASCADE,
    maintenance_date TIMESTAMPTZ,
    task_description TEXT,
    performed_by_id UUID REFERENCES staff(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE ice_maintenance_logs ENABLE ROW LEVEL SECURITY;
