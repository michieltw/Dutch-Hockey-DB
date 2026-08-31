-- 11_unified_game_events.sql
-- A massive, unified table for recording all live game events in one place

CREATE TABLE unified_game_events (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'UEVN',

    -- Context
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    period_id UUID REFERENCES periods(id) ON DELETE CASCADE,
    time_elapsed INTERVAL NOT NULL,
    event_type VARCHAR(50) NOT NULL, -- 'Goal', 'Shot', 'Penalty', 'Hit', 'Faceoff', 'Block', 'Takeaway', 'Giveaway', 'Stoppage'
    team_id UUID REFERENCES teams(id) ON DELETE CASCADE, -- Primary team involved (e.g., scoring team, penalised team, faceoff winning team)
    opposing_team_id UUID REFERENCES teams(id) ON DELETE CASCADE,

    -- Actors (Polymorphic naming to accommodate different event types)
    primary_player_id UUID REFERENCES players(id) ON DELETE SET NULL, -- Scorer, Shooter, Hitter, Penalised Player, Faceoff Winner
    secondary_player_id UUID REFERENCES players(id) ON DELETE SET NULL, -- Primary Assist, Goalie (for shots), Hit Player, Drawn By (penalty), Faceoff Loser
    tertiary_player_id UUID REFERENCES players(id) ON DELETE SET NULL, -- Secondary Assist, Goalie (if secondary player was assist)

    -- Location
    x_coordinate NUMERIC(5, 2),
    y_coordinate NUMERIC(5, 2),
    zone VARCHAR(50), -- 'Offensive', 'Defensive', 'Neutral'
    distance_to_net NUMERIC(5, 2),

    -- Goal & Shot Specifics
    shot_type shot_type_enum,
    is_goal BOOLEAN DEFAULT FALSE,
    is_powerplay BOOLEAN DEFAULT FALSE,
    is_shorthanded BOOLEAN DEFAULT FALSE,
    is_empty_net BOOLEAN DEFAULT FALSE,
    is_extra_attacker BOOLEAN DEFAULT FALSE,
    is_penalty_shot BOOLEAN DEFAULT FALSE,
    is_game_winning BOOLEAN DEFAULT FALSE,

    -- Penalty Specifics
    penalty_type penalty_type_enum,
    penalty_infraction penalty_infraction_enum,
    penalty_duration_minutes INTEGER,

    -- Faceoff & Stoppage Specifics
    faceoff_won_by_team_id UUID REFERENCES teams(id) ON DELETE SET NULL,
    stoppage_reason VARCHAR(100), -- 'Icing', 'Offside', 'Goalie Freeze', 'Puck Out of Bounds', 'Hand Pass', 'High Sticking the Puck'

    -- Game Context at time of event
    home_team_score INTEGER,
    away_team_score INTEGER,
    home_team_on_ice_strength INTEGER, -- e.g. 5 for 5v5, 4 for 5v4
    away_team_on_ice_strength INTEGER,
    called_by_official_id UUID REFERENCES game_officials(id) ON DELETE SET NULL,
    video_review_occurred BOOLEAN DEFAULT FALSE,

    -- Flexible Metadata for future-proofing
    metadata JSONB,

    -- System Fields
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE unified_game_events ENABLE ROW LEVEL SECURITY;
