-- 4. skill_evaluations
CREATE TABLE skill_evaluations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SKEV',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    evaluator_id UUID REFERENCES staff(id) ON DELETE SET NULL,
    evaluation_date DATE,
    overall_score INTEGER CHECK (overall_score BETWEEN 1 AND 100),
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE skill_evaluations ENABLE ROW LEVEL SECURITY;
