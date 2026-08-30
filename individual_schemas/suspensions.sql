-- 14. suspensions
CREATE TABLE suspensions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SUSP',
    player_id UUID REFERENCES players(id) ON DELETE CASCADE,
    official_id UUID REFERENCES officials(id) ON DELETE CASCADE,
    coach_id UUID REFERENCES coaches(id) ON DELETE CASCADE,
    reason TEXT,
    games_suspended INTEGER,
    start_date DATE,
    end_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE suspensions ENABLE ROW LEVEL SECURITY;
