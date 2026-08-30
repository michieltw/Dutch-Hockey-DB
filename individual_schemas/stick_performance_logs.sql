-- 13. stick_performance_logs (Linked to player_sticks)
CREATE TABLE stick_performance_logs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'STPL',
    stick_id UUID NOT NULL REFERENCES player_sticks(id) ON DELETE CASCADE,
    logged_date DATE NOT NULL,
    games_played_with INTEGER DEFAULT 0,
    practices_used INTEGER DEFAULT 0,
    estimated_performance_score NUMERIC(5, 2), -- 0.00 to 100.00
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE stick_performance_logs ENABLE ROW LEVEL SECURITY;
