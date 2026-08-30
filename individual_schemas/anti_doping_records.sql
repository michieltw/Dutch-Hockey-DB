-- 7. anti_doping_records
CREATE TABLE anti_doping_records (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ADOP',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    test_date DATE,
    result VARCHAR(50),
    tested_by VARCHAR(100),
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE anti_doping_records ENABLE ROW LEVEL SECURITY;
