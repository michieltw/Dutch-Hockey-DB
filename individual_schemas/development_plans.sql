-- 5. development_plans
CREATE TABLE development_plans (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'DEVP',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    coach_id UUID REFERENCES coaches(id) ON DELETE SET NULL,
    start_date DATE,
    end_date DATE,
    goals TEXT,
    progress_notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE development_plans ENABLE ROW LEVEL SECURITY;
