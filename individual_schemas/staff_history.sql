-- staff_history
CREATE TABLE staff_history (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'STHI',
    staff_id UUID NOT NULL REFERENCES staff(id) ON DELETE CASCADE,
    season_id UUID REFERENCES seasons(id) ON DELETE SET NULL,
    team_id UUID REFERENCES teams(id) ON DELETE SET NULL,
    club_id UUID REFERENCES clubs(id) ON DELETE SET NULL,
    league_id UUID REFERENCES leagues(id) ON DELETE SET NULL,
    role VARCHAR(100),
    games_managed INTEGER DEFAULT 0,
    wins INTEGER DEFAULT 0,
    losses INTEGER DEFAULT 0,
    ties INTEGER DEFAULT 0,
    overtime_losses INTEGER DEFAULT 0,
    championships INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE staff_history ENABLE ROW LEVEL SECURITY;
