-- 51. historical_records
CREATE TABLE historical_records (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'HIRE',
    record_name VARCHAR(255), -- 'Most Goals in a Season'
    record_value VARCHAR(100),
    holder_player_id UUID REFERENCES players(id) ON DELETE SET NULL,
    holder_team_id UUID REFERENCES teams(id) ON DELETE SET NULL,
    date_achieved DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE historical_records ENABLE ROW LEVEL SECURITY;
