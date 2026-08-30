-- 8. injuries
CREATE TABLE injuries (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'INJU',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    injury_type injury_type_enum,
    status injury_status_enum DEFAULT 'Active',
    date_injured DATE,
    expected_return_date DATE,
    actual_return_date DATE,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE injuries ENABLE ROW LEVEL SECURITY;
