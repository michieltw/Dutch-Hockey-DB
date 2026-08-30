-- 38. staff_schedules
CREATE TABLE staff_schedules (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'STSC',
    staff_id UUID NOT NULL REFERENCES staff(id) ON DELETE CASCADE,
    shift_start TIMESTAMPTZ,
    shift_end TIMESTAMPTZ,
    role_assigned VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE staff_schedules ENABLE ROW LEVEL SECURITY;
