-- 41. coaching_strategies
CREATE TABLE coaching_strategies (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CSTR',
    coach_id UUID NOT NULL REFERENCES coaches(id) ON DELETE CASCADE,
    strategy_name VARCHAR(100), -- '1-3-1', 'Trap'
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE coaching_strategies ENABLE ROW LEVEL SECURITY;
