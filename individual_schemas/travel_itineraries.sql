-- 35. travel_itineraries
CREATE TABLE travel_itineraries (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TRIT',
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    game_id UUID REFERENCES games(id) ON DELETE SET NULL,
    departure_time TIMESTAMPTZ,
    arrival_time TIMESTAMPTZ,
    destination VARCHAR(255),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE travel_itineraries ENABLE ROW LEVEL SECURITY;
