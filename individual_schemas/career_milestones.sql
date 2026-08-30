-- 5. career_milestones
CREATE TABLE career_milestones (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CMIL',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    milestone_type VARCHAR(100), -- e.g., '100th Goal', '500th Game'
    date_achieved DATE,
    game_id UUID REFERENCES games(id) ON DELETE SET NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE career_milestones ENABLE ROW LEVEL SECURITY;
