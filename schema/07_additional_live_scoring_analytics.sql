-- 07_additional_live_scoring_analytics.sql
-- Live Scoring Events and Advanced Analytics

-- 1. lineups
CREATE TABLE lineups (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LINE',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    jersey_number INTEGER,
    position position_enum,
    is_starting BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE lineups ENABLE ROW LEVEL SECURITY;

-- 2. events (Generic game event log)
CREATE TABLE events (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'EVNT',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    period_id UUID REFERENCES periods(id) ON DELETE CASCADE,
    event_type VARCHAR(50), -- 'Goal', 'Penalty', 'Shot', 'Hit', etc.
    time_elapsed INTERVAL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE events ENABLE ROW LEVEL SECURITY;

-- 3. assists
CREATE TABLE assists (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ASST',
    goal_id UUID NOT NULL REFERENCES goals(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    is_primary BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE assists ENABLE ROW LEVEL SECURITY;

-- 4. faceoffs
CREATE TABLE faceoffs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'FACE',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    period_id UUID REFERENCES periods(id) ON DELETE CASCADE,
    winning_player_id UUID REFERENCES players(id) ON DELETE CASCADE,
    losing_player_id UUID REFERENCES players(id) ON DELETE CASCADE,
    zone VARCHAR(20), -- 'Offensive', 'Defensive', 'Neutral'
    x_coordinate NUMERIC(5, 2),
    y_coordinate NUMERIC(5, 2),
    time_elapsed INTERVAL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE faceoffs ENABLE ROW LEVEL SECURITY;

-- 5. hits
CREATE TABLE hits (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'HITS',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    period_id UUID REFERENCES periods(id) ON DELETE CASCADE,
    hitting_player_id UUID REFERENCES players(id) ON DELETE CASCADE,
    hit_player_id UUID REFERENCES players(id) ON DELETE CASCADE,
    x_coordinate NUMERIC(5, 2),
    y_coordinate NUMERIC(5, 2),
    time_elapsed INTERVAL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE hits ENABLE ROW LEVEL SECURITY;

-- 6. blocked_shots
CREATE TABLE blocked_shots (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'BLKS',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    period_id UUID REFERENCES periods(id) ON DELETE CASCADE,
    blocking_player_id UUID REFERENCES players(id) ON DELETE CASCADE,
    shooting_player_id UUID REFERENCES players(id) ON DELETE CASCADE,
    x_coordinate NUMERIC(5, 2),
    y_coordinate NUMERIC(5, 2),
    time_elapsed INTERVAL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE blocked_shots ENABLE ROW LEVEL SECURITY;

-- 7. shifts
CREATE TABLE shifts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SHFT',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    period_id UUID REFERENCES periods(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    start_time INTERVAL,
    end_time INTERVAL,
    duration INTERVAL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE shifts ENABLE ROW LEVEL SECURITY;

-- 8. giveaways
CREATE TABLE giveaways (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'GIVE',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    period_id UUID REFERENCES periods(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    zone VARCHAR(20),
    time_elapsed INTERVAL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE giveaways ENABLE ROW LEVEL SECURITY;

-- 9. takeaways
CREATE TABLE takeaways (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TAKE',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    period_id UUID REFERENCES periods(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    zone VARCHAR(20),
    time_elapsed INTERVAL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE takeaways ENABLE ROW LEVEL SECURITY;

-- 10. icings
CREATE TABLE icings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ICNG',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    period_id UUID REFERENCES periods(id) ON DELETE CASCADE,
    offending_team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    time_elapsed INTERVAL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE icings ENABLE ROW LEVEL SECURITY;

-- 11. offsides
CREATE TABLE offsides (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'OFFS',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    period_id UUID REFERENCES periods(id) ON DELETE CASCADE,
    offending_team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    time_elapsed INTERVAL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE offsides ENABLE ROW LEVEL SECURITY;

-- 12. time_outs
CREATE TABLE time_outs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TOUT',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    period_id UUID REFERENCES periods(id) ON DELETE CASCADE,
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    time_elapsed INTERVAL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE time_outs ENABLE ROW LEVEL SECURITY;

-- 13. shootouts
CREATE TABLE shootouts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SHTO',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    round_number INTEGER,
    shooter_id UUID REFERENCES players(id) ON DELETE CASCADE,
    goalie_id UUID REFERENCES players(id) ON DELETE CASCADE,
    is_goal BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE shootouts ENABLE ROW LEVEL SECURITY;

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

-- 15. goaltender_stats
CREATE TABLE goaltender_stats (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'GSTA',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    shots_against INTEGER DEFAULT 0,
    saves INTEGER DEFAULT 0,
    goals_against INTEGER DEFAULT 0,
    time_on_ice INTERVAL,
    is_win BOOLEAN DEFAULT FALSE,
    is_loss BOOLEAN DEFAULT FALSE,
    is_otl BOOLEAN DEFAULT FALSE,
    is_shutout BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE goaltender_stats ENABLE ROW LEVEL SECURITY;

-- 16. player_game_stats
CREATE TABLE player_game_stats (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PGST',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    goals INTEGER DEFAULT 0,
    assists INTEGER DEFAULT 0,
    points INTEGER DEFAULT 0,
    plus_minus INTEGER DEFAULT 0,
    penalty_minutes INTEGER DEFAULT 0,
    shots INTEGER DEFAULT 0,
    hits INTEGER DEFAULT 0,
    blocked_shots INTEGER DEFAULT 0,
    time_on_ice INTERVAL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE player_game_stats ENABLE ROW LEVEL SECURITY;

-- 17. team_game_stats
CREATE TABLE team_game_stats (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TGST',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    shots INTEGER DEFAULT 0,
    powerplay_opportunities INTEGER DEFAULT 0,
    powerplay_goals INTEGER DEFAULT 0,
    penalty_minutes INTEGER DEFAULT 0,
    faceoffs_won INTEGER DEFAULT 0,
    giveaways INTEGER DEFAULT 0,
    takeaways INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE team_game_stats ENABLE ROW LEVEL SECURITY;

-- 18. advanced_player_metrics
CREATE TABLE advanced_player_metrics (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ADVP',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
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
ALTER TABLE advanced_player_metrics ENABLE ROW LEVEL SECURITY;

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

-- 20. zone_starts
CREATE TABLE zone_starts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ZSTA',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    offensive_zone_starts INTEGER DEFAULT 0,
    defensive_zone_starts INTEGER DEFAULT 0,
    neutral_zone_starts INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE zone_starts ENABLE ROW LEVEL SECURITY;

-- 21. zone_entries
CREATE TABLE zone_entries (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ZENT',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    carried_in INTEGER DEFAULT 0,
    dumped_in INTEGER DEFAULT 0,
    passed_in INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE zone_entries ENABLE ROW LEVEL SECURITY;

-- 22. zone_exits
CREATE TABLE zone_exits (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ZEXT',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    carried_out INTEGER DEFAULT 0,
    passed_out INTEGER DEFAULT 0,
    failed_exits INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE zone_exits ENABLE ROW LEVEL SECURITY;

-- 23. shot_locations
CREATE TABLE shot_locations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SHLO',
    shot_id UUID NOT NULL REFERENCES shots(id) ON DELETE CASCADE,
    zone VARCHAR(50), -- 'High Slot', 'Point', 'Crease'
    x_coordinate NUMERIC(5, 2),
    y_coordinate NUMERIC(5, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE shot_locations ENABLE ROW LEVEL SECURITY;

-- 24. puck_tracking_data
CREATE TABLE puck_tracking_data (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PUCK',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    timestamp TIMESTAMPTZ NOT NULL,
    x_coordinate NUMERIC(8, 4),
    y_coordinate NUMERIC(8, 4),
    z_coordinate NUMERIC(8, 4),
    speed_kmh NUMERIC(5, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE puck_tracking_data ENABLE ROW LEVEL SECURITY;

-- 25. player_tracking_data
CREATE TABLE player_tracking_data (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PLTR',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    timestamp TIMESTAMPTZ NOT NULL,
    x_coordinate NUMERIC(8, 4),
    y_coordinate NUMERIC(8, 4),
    speed_kmh NUMERIC(5, 2),
    heart_rate INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE player_tracking_data ENABLE ROW LEVEL SECURITY;

-- 26. expected_goals
CREATE TABLE expected_goals (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'XGOL',
    shot_id UUID NOT NULL REFERENCES shots(id) ON DELETE CASCADE,
    xg_value NUMERIC(5, 4),
    model_version VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE expected_goals ENABLE ROW LEVEL SECURITY;

-- 27. passing_metrics
CREATE TABLE passing_metrics (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PASS',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    passes_attempted INTEGER DEFAULT 0,
    passes_completed INTEGER DEFAULT 0,
    completion_percentage NUMERIC(5, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE passing_metrics ENABLE ROW LEVEL SECURITY;

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

-- 29. skating_speed_records
CREATE TABLE skating_speed_records (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SKSP',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    top_speed_kmh NUMERIC(5, 2),
    bursts_over_30kmh INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE skating_speed_records ENABLE ROW LEVEL SECURITY;

-- 30. shot_speed_records
CREATE TABLE shot_speed_records (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SHSP',
    shot_id UUID NOT NULL REFERENCES shots(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    speed_kmh NUMERIC(5, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE shot_speed_records ENABLE ROW LEVEL SECURITY;

-- 31. distance_traveled
CREATE TABLE distance_traveled (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'DIST',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    distance_km NUMERIC(5, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE distance_traveled ENABLE ROW LEVEL SECURITY;
