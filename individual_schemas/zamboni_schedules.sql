-- 19. zamboni_schedules
CREATE TABLE zamboni_schedules (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ZAMB',
    rink_id UUID NOT NULL REFERENCES rinks(id) ON DELETE CASCADE,
    scheduled_time TIMESTAMPTZ,
    driver_id UUID REFERENCES staff(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE zamboni_schedules ENABLE ROW LEVEL SECURITY;
