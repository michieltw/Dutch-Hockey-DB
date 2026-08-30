-- 9. player_attributes
CREATE TABLE player_attributes (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PLAT',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    speed INTEGER CHECK (speed BETWEEN 1 AND 100),
    checking INTEGER CHECK (checking BETWEEN 1 AND 100),
    awareness INTEGER CHECK (awareness BETWEEN 1 AND 100),
    shooting_accuracy INTEGER CHECK (shooting_accuracy BETWEEN 1 AND 100),
    passing INTEGER CHECK (passing BETWEEN 1 AND 100),
    evaluated_date DATE,
    evaluator_id UUID REFERENCES staff(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE player_attributes ENABLE ROW LEVEL SECURITY;
