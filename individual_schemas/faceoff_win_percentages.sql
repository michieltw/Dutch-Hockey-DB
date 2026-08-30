-- 28. faceoff_win_percentages
CREATE TABLE faceoff_win_percentages (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'FOWP',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    season_id UUID NOT NULL REFERENCES seasons(id) ON DELETE CASCADE,
    faceoffs_taken INTEGER DEFAULT 0,
    faceoffs_won INTEGER DEFAULT 0,
    win_percentage NUMERIC(5, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE faceoff_win_percentages ENABLE ROW LEVEL SECURITY;
