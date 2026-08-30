-- 2. events (Generic game event log)
CREATE TABLE events (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'EVNT',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    period_id UUID REFERENCES periods(id) ON DELETE CASCADE,
    event_type VARCHAR(50), -- 'Goal', 'Penalty', 'Shot', 'Hit', etc.
    time_elapsed INTERVAL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE events ENABLE ROW LEVEL SECURITY;
