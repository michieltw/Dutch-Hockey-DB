-- 19. advanced_team_metrics
CREATE TABLE advanced_team_metrics (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ADVT',
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    season_id UUID NOT NULL REFERENCES seasons(id) ON DELETE CASCADE,
    corsi_for_percentage NUMERIC(5, 2),
    fenwick_for_percentage NUMERIC(5, 2),
    pdo NUMERIC(5, 2),
    expected_goals_for NUMERIC(5, 2),
    expected_goals_against NUMERIC(5, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE advanced_team_metrics ENABLE ROW LEVEL SECURITY;
