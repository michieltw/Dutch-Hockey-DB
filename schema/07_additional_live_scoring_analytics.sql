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

-- 4. faceoffs

-- 5. hits

-- 6. blocked_shots

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

-- 9. takeaways

-- 10. icings

-- 11. offsides

-- 12. time_outs

-- 13. shootouts

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

-- Indexes for foreign keys
CREATE INDEX idx_lineups_game_id ON lineups(game_id);
CREATE INDEX idx_lineups_team_id ON lineups(team_id);
CREATE INDEX idx_lineups_player_id ON lineups(player_id);
CREATE INDEX idx_events_game_id ON events(game_id);
CREATE INDEX idx_events_period_id ON events(period_id);
CREATE INDEX idx_assists_goal_id ON assists(goal_id);
CREATE INDEX idx_assists_player_id ON assists(player_id);
CREATE INDEX idx_faceoffs_game_id ON faceoffs(game_id);
CREATE INDEX idx_faceoffs_period_id ON faceoffs(period_id);
CREATE INDEX idx_faceoffs_winning_player_id ON faceoffs(winning_player_id);
CREATE INDEX idx_faceoffs_losing_player_id ON faceoffs(losing_player_id);
CREATE INDEX idx_hits_game_id ON hits(game_id);
CREATE INDEX idx_hits_period_id ON hits(period_id);
CREATE INDEX idx_hits_hitting_player_id ON hits(hitting_player_id);
CREATE INDEX idx_hits_hit_player_id ON hits(hit_player_id);
CREATE INDEX idx_blocked_shots_game_id ON blocked_shots(game_id);
CREATE INDEX idx_blocked_shots_period_id ON blocked_shots(period_id);
CREATE INDEX idx_blocked_shots_blocking_player_id ON blocked_shots(blocking_player_id);
CREATE INDEX idx_blocked_shots_shooting_player_id ON blocked_shots(shooting_player_id);
CREATE INDEX idx_shifts_game_id ON shifts(game_id);
CREATE INDEX idx_shifts_period_id ON shifts(period_id);
CREATE INDEX idx_shifts_player_id ON shifts(player_id);
CREATE INDEX idx_giveaways_game_id ON giveaways(game_id);
CREATE INDEX idx_giveaways_period_id ON giveaways(period_id);
CREATE INDEX idx_giveaways_player_id ON giveaways(player_id);
CREATE INDEX idx_takeaways_game_id ON takeaways(game_id);
CREATE INDEX idx_takeaways_period_id ON takeaways(period_id);
CREATE INDEX idx_takeaways_player_id ON takeaways(player_id);
CREATE INDEX idx_icings_game_id ON icings(game_id);
CREATE INDEX idx_icings_period_id ON icings(period_id);
CREATE INDEX idx_icings_offending_team_id ON icings(offending_team_id);
CREATE INDEX idx_offsides_game_id ON offsides(game_id);
CREATE INDEX idx_offsides_period_id ON offsides(period_id);
CREATE INDEX idx_offsides_offending_team_id ON offsides(offending_team_id);
CREATE INDEX idx_time_outs_game_id ON time_outs(game_id);
CREATE INDEX idx_time_outs_period_id ON time_outs(period_id);
CREATE INDEX idx_time_outs_team_id ON time_outs(team_id);
CREATE INDEX idx_shootouts_game_id ON shootouts(game_id);
CREATE INDEX idx_shootouts_shooter_id ON shootouts(shooter_id);
CREATE INDEX idx_shootouts_goalie_id ON shootouts(goalie_id);
CREATE INDEX idx_video_reviews_game_id ON video_reviews(game_id);
CREATE INDEX idx_video_reviews_period_id ON video_reviews(period_id);
CREATE INDEX idx_goaltender_stats_game_id ON goaltender_stats(game_id);
CREATE INDEX idx_goaltender_stats_player_id ON goaltender_stats(player_id);
CREATE INDEX idx_goaltender_stats_team_id ON goaltender_stats(team_id);
CREATE INDEX idx_player_game_stats_game_id ON player_game_stats(game_id);
CREATE INDEX idx_player_game_stats_player_id ON player_game_stats(player_id);
CREATE INDEX idx_player_game_stats_team_id ON player_game_stats(team_id);
CREATE INDEX idx_team_game_stats_game_id ON team_game_stats(game_id);
CREATE INDEX idx_team_game_stats_team_id ON team_game_stats(team_id);
CREATE INDEX idx_advanced_player_metrics_player_id ON advanced_player_metrics(player_id);
CREATE INDEX idx_advanced_player_metrics_season_id ON advanced_player_metrics(season_id);
CREATE INDEX idx_advanced_team_metrics_team_id ON advanced_team_metrics(team_id);
CREATE INDEX idx_advanced_team_metrics_season_id ON advanced_team_metrics(season_id);
CREATE INDEX idx_zone_starts_player_id ON zone_starts(player_id);
CREATE INDEX idx_zone_starts_game_id ON zone_starts(game_id);
CREATE INDEX idx_zone_entries_player_id ON zone_entries(player_id);
CREATE INDEX idx_zone_entries_game_id ON zone_entries(game_id);
CREATE INDEX idx_zone_exits_player_id ON zone_exits(player_id);
CREATE INDEX idx_zone_exits_game_id ON zone_exits(game_id);
CREATE INDEX idx_shot_locations_shot_id ON shot_locations(shot_id);
CREATE INDEX idx_puck_tracking_data_game_id ON puck_tracking_data(game_id);
CREATE INDEX idx_player_tracking_data_player_id ON player_tracking_data(player_id);
CREATE INDEX idx_player_tracking_data_game_id ON player_tracking_data(game_id);
CREATE INDEX idx_expected_goals_shot_id ON expected_goals(shot_id);
CREATE INDEX idx_passing_metrics_player_id ON passing_metrics(player_id);
CREATE INDEX idx_passing_metrics_game_id ON passing_metrics(game_id);
CREATE INDEX idx_faceoff_win_percentages_player_id ON faceoff_win_percentages(player_id);
CREATE INDEX idx_faceoff_win_percentages_season_id ON faceoff_win_percentages(season_id);
CREATE INDEX idx_skating_speed_records_player_id ON skating_speed_records(player_id);
CREATE INDEX idx_skating_speed_records_game_id ON skating_speed_records(game_id);
CREATE INDEX idx_shot_speed_records_shot_id ON shot_speed_records(shot_id);
CREATE INDEX idx_shot_speed_records_player_id ON shot_speed_records(player_id);
CREATE INDEX idx_distance_traveled_player_id ON distance_traveled(player_id);
CREATE INDEX idx_distance_traveled_game_id ON distance_traveled(game_id);
