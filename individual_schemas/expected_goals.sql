-- 26. expected_goals
CREATE TABLE expected_goals (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'XGOL',
    shot_id UUID NOT NULL REFERENCES shots(id) ON DELETE CASCADE,
    xg_value NUMERIC(5, 4),
    model_version VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE expected_goals ENABLE ROW LEVEL SECURITY;
