-- 12. line_chemistry
CREATE TABLE line_chemistry (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LICH',
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    player1_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    player2_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    chemistry_score INTEGER CHECK (chemistry_score BETWEEN 1 AND 100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE line_chemistry ENABLE ROW LEVEL SECURITY;
