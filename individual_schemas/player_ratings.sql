-- 9. player_ratings
CREATE TABLE player_ratings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PLRT',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    rating_source VARCHAR(100), -- e.g., 'EA NHL', 'Internal Algorithm'
    overall_rating INTEGER CHECK (overall_rating BETWEEN 1 AND 99),
    updated_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE player_ratings ENABLE ROW LEVEL SECURITY;
