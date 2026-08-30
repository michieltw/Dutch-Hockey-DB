-- 14. video_reviews
CREATE TABLE video_reviews (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'VIDR',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    period_id UUID REFERENCES periods(id) ON DELETE CASCADE,
    reason TEXT,
    result VARCHAR(50), -- 'Confirmed', 'Overturned', 'Inconclusive'
    time_elapsed INTERVAL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE video_reviews ENABLE ROW LEVEL SECURITY;
