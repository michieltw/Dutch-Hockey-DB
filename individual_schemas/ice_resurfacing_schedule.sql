-- 29. ice_resurfacing_schedule
CREATE TABLE ice_resurfacing_schedule (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ICRS',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    scheduled_time TIMESTAMPTZ,
    completed BOOLEAN DEFAULT FALSE,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE ice_resurfacing_schedule ENABLE ROW LEVEL SECURITY;
