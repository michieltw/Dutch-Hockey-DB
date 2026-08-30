-- 2. periods
CREATE TABLE periods (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PERI',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    period_number INTEGER NOT NULL, -- 1, 2, 3, 4 (OT), etc.
    start_time TIMESTAMPTZ,
    end_time TIMESTAMPTZ,
    length_minutes INTEGER DEFAULT 20,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE periods ENABLE ROW LEVEL SECURITY;
