-- 10. official_evaluations
CREATE TABLE official_evaluations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'OFEV',
    official_id UUID NOT NULL REFERENCES officials(id) ON DELETE CASCADE,
    game_id UUID REFERENCES games(id) ON DELETE SET NULL,
    evaluator_id UUID REFERENCES staff(id) ON DELETE SET NULL,
    score INTEGER CHECK (score BETWEEN 1 AND 100),
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE official_evaluations ENABLE ROW LEVEL SECURITY;
