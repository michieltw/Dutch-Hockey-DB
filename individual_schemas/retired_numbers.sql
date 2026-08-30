-- retired_numbers
CREATE TABLE retired_numbers (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'RETN',
    club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    jersey_number INTEGER NOT NULL,
    player_id UUID REFERENCES players(id) ON DELETE SET NULL,
    date_retired DATE,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE retired_numbers ENABLE ROW LEVEL SECURITY;
