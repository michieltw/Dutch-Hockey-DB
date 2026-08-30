-- 18. transfer_rumors
CREATE TABLE transfer_rumors (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TRRM',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    target_club_id UUID REFERENCES clubs(id) ON DELETE SET NULL,
    source_url TEXT,
    reliability_score INTEGER CHECK (reliability_score BETWEEN 1 AND 100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE transfer_rumors ENABLE ROW LEVEL SECURITY;
