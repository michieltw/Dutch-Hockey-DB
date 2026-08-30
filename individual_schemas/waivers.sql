-- 23. waivers
CREATE TABLE waivers (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'WAIV',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    date_placed DATE,
    status VARCHAR(50), -- 'Cleared', 'Claimed'
    claimed_by_club_id UUID REFERENCES clubs(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE waivers ENABLE ROW LEVEL SECURITY;
