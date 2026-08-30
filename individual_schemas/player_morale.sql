-- 11. player_morale
CREATE TABLE player_morale (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PLMO',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    morale_score INTEGER CHECK (morale_score BETWEEN 1 AND 100),
    last_updated DATE,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE player_morale ENABLE ROW LEVEL SECURITY;
