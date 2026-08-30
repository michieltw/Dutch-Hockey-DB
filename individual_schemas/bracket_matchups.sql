-- 19. bracket_matchups
CREATE TABLE bracket_matchups (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'BRAC',
    tournament_id UUID NOT NULL REFERENCES tournaments(id) ON DELETE CASCADE,
    round_number INTEGER,
    matchup_id UUID REFERENCES series(id) ON DELETE CASCADE,
    next_matchup_id UUID REFERENCES series(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE bracket_matchups ENABLE ROW LEVEL SECURITY;
