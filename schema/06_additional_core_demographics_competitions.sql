-- 06_additional_core_demographics_competitions.sql
-- Continuing from core entities, demographics, and competitions

-- 1. affiliations
CREATE TABLE affiliations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'AFFL',
    parent_club_id UUID REFERENCES clubs(id) ON DELETE CASCADE,
    farm_club_id UUID REFERENCES clubs(id) ON DELETE CASCADE,
    start_date DATE,
    end_date DATE,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE affiliations ENABLE ROW LEVEL SECURITY;

-- 2. club_hierarchies
CREATE TABLE club_hierarchies (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CLHI',
    parent_organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    child_organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    relationship_type VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE club_hierarchies ENABLE ROW LEVEL SECURITY;

-- 3. player_history
CREATE TABLE player_history (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PHIS',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    season_id UUID REFERENCES seasons(id) ON DELETE SET NULL,
    team_id UUID REFERENCES teams(id) ON DELETE SET NULL,
    league_id UUID REFERENCES leagues(id) ON DELETE SET NULL,
    games_played INTEGER DEFAULT 0,
    goals INTEGER DEFAULT 0,
    assists INTEGER DEFAULT 0,
    points INTEGER DEFAULT 0,
    penalty_minutes INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE player_history ENABLE ROW LEVEL SECURITY;

-- 4. family_connections
CREATE TABLE family_connections (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'FCON',
    person1_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    person2_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    relationship_type VARCHAR(50), -- e.g., 'Father', 'Brother', 'Son'
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE family_connections ENABLE ROW LEVEL SECURITY;

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

-- 6. alumni_associations
CREATE TABLE alumni_associations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ALUM',
    club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    name VARCHAR(255),
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE alumni_associations ENABLE ROW LEVEL SECURITY;

-- 7. hall_of_fame_inductions
CREATE TABLE hall_of_fame_inductions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'HOFI',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    organization_id UUID REFERENCES organizations(id) ON DELETE SET NULL, -- Who inducted them
    year_inducted INTEGER,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE hall_of_fame_inductions ENABLE ROW LEVEL SECURITY;

-- 8. national_team_selections
CREATE TABLE national_team_selections (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'NTSE',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    nationality_id UUID NOT NULL REFERENCES nationalities(id) ON DELETE CASCADE,
    tournament_id UUID REFERENCES tournaments(id) ON DELETE SET NULL,
    year INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE national_team_selections ENABLE ROW LEVEL SECURITY;

-- 9. player_attributes
CREATE TABLE player_attributes (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PLAT',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    speed INTEGER CHECK (speed BETWEEN 1 AND 100),
    checking INTEGER CHECK (checking BETWEEN 1 AND 100),
    awareness INTEGER CHECK (awareness BETWEEN 1 AND 100),
    shooting_accuracy INTEGER CHECK (shooting_accuracy BETWEEN 1 AND 100),
    passing INTEGER CHECK (passing BETWEEN 1 AND 100),
    evaluated_date DATE,
    evaluator_id UUID REFERENCES staff(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE player_attributes ENABLE ROW LEVEL SECURITY;

-- 10. player_roles (table version if distinct from enum)
CREATE TABLE player_roles (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PLRO',
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE player_roles ENABLE ROW LEVEL SECURITY;

-- 11. player_morale
CREATE TABLE player_morale (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PLMO',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    morale_score INTEGER CHECK (morale_score BETWEEN 1 AND 100),
    last_updated DATE,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE player_morale ENABLE ROW LEVEL SECURITY;

-- 12. line_chemistry
CREATE TABLE line_chemistry (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LICH',
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    player1_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    player2_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    chemistry_score INTEGER CHECK (chemistry_score BETWEEN 1 AND 100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE line_chemistry ENABLE ROW LEVEL SECURITY;

-- 13. cups
CREATE TABLE cups (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CUPS',
    name VARCHAR(255) NOT NULL,
    federation_id UUID REFERENCES federations(id) ON DELETE SET NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE cups ENABLE ROW LEVEL SECURITY;

-- 14. phases
CREATE TABLE phases (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PHAS',
    tournament_id UUID REFERENCES tournaments(id) ON DELETE CASCADE,
    name VARCHAR(100), -- e.g., 'Group Stage', 'Playoffs'
    start_date DATE,
    end_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE phases ENABLE ROW LEVEL SECURITY;

-- 15. series
CREATE TABLE series (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SERI',
    phase_id UUID REFERENCES phases(id) ON DELETE CASCADE,
    team1_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    team2_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    format series_format_enum,
    winner_team_id UUID REFERENCES teams(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE series ENABLE ROW LEVEL SECURITY;

-- 16. standings
CREATE TABLE standings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'STAN',
    league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
    season_id UUID NOT NULL REFERENCES seasons(id) ON DELETE CASCADE,
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    games_played INTEGER DEFAULT 0,
    wins INTEGER DEFAULT 0,
    losses INTEGER DEFAULT 0,
    ot_wins INTEGER DEFAULT 0,
    ot_losses INTEGER DEFAULT 0,
    points INTEGER DEFAULT 0,
    goals_for INTEGER DEFAULT 0,
    goals_against INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE standings ENABLE ROW LEVEL SECURITY;

-- 17. tiebreakers
CREATE TABLE tiebreakers (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TIEB',
    league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
    rule_description TEXT NOT NULL,
    priority_order INTEGER NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE tiebreakers ENABLE ROW LEVEL SECURITY;

-- 18. relegation_rules
CREATE TABLE relegation_rules (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'REGR',
    league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
    description TEXT,
    spots_relegated INTEGER,
    spots_promoted INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE relegation_rules ENABLE ROW LEVEL SECURITY;

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

-- 20. wildcard_standings
CREATE TABLE wildcard_standings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'WILD',
    conference_id UUID NOT NULL REFERENCES conferences(id) ON DELETE CASCADE,
    season_id UUID NOT NULL REFERENCES seasons(id) ON DELETE CASCADE,
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    points INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE wildcard_standings ENABLE ROW LEVEL SECURITY;

-- 21. age_dispensations
CREATE TABLE age_dispensations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'AGDI',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
    season_id UUID NOT NULL REFERENCES seasons(id) ON DELETE CASCADE,
    reason TEXT,
    approved BOOLEAN DEFAULT FALSE,
    approved_by_id UUID REFERENCES users(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE age_dispensations ENABLE ROW LEVEL SECURITY;

-- 22. import_quotas
CREATE TABLE import_quotas (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'IMPQ',
    league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
    season_id UUID NOT NULL REFERENCES seasons(id) ON DELETE CASCADE,
    max_imports_per_team INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE import_quotas ENABLE ROW LEVEL SECURITY;

-- 23. game_day_roles
CREATE TABLE game_day_roles (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'GDRO',
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE game_day_roles ENABLE ROW LEVEL SECURITY;

-- 24. volunteers
CREATE TABLE volunteers (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'VOLU',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    club_id UUID REFERENCES clubs(id) ON DELETE CASCADE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE volunteers ENABLE ROW LEVEL SECURITY;

-- 25. digital_game_sheets
CREATE TABLE digital_game_sheets (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'DWFS',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    submitted_by_id UUID REFERENCES users(id) ON DELETE SET NULL,
    submitted_at TIMESTAMPTZ,
    pdf_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE digital_game_sheets ENABLE ROW LEVEL SECURITY;

-- 26. game_sheet_signatures
CREATE TABLE game_sheet_signatures (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'GSIG',
    game_sheet_id UUID NOT NULL REFERENCES digital_game_sheets(id) ON DELETE CASCADE,
    signer_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role VARCHAR(50), -- 'Home Coach', 'Away Coach', 'Referee'
    signed_at TIMESTAMPTZ DEFAULT NOW(),
    signature_data TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE game_sheet_signatures ENABLE ROW LEVEL SECURITY;

-- 27. security_personnel
CREATE TABLE security_personnel (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SECU',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    arena_id UUID REFERENCES arenas(id) ON DELETE CASCADE,
    company_name VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE security_personnel ENABLE ROW LEVEL SECURITY;

-- 29. ice_resurfacing_schedule
CREATE TABLE ice_resurfacing_schedule (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ICRS',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    scheduled_time TIMESTAMPTZ,
    completed BOOLEAN DEFAULT FALSE,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE ice_resurfacing_schedule ENABLE ROW LEVEL SECURITY;

-- Indexes for foreign keys
CREATE INDEX idx_affiliations_parent_club_id ON affiliations(parent_club_id);
CREATE INDEX idx_affiliations_farm_club_id ON affiliations(farm_club_id);
CREATE INDEX idx_club_hierarchies_parent_organization_id ON club_hierarchies(parent_organization_id);
CREATE INDEX idx_club_hierarchies_child_organization_id ON club_hierarchies(child_organization_id);
CREATE INDEX idx_player_history_player_id ON player_history(player_id);
CREATE INDEX idx_player_history_season_id ON player_history(season_id);
CREATE INDEX idx_player_history_team_id ON player_history(team_id);
CREATE INDEX idx_player_history_league_id ON player_history(league_id);
CREATE INDEX idx_family_connections_person1_id ON family_connections(person1_id);
CREATE INDEX idx_family_connections_person2_id ON family_connections(person2_id);
CREATE INDEX idx_career_milestones_player_id ON career_milestones(player_id);
CREATE INDEX idx_career_milestones_game_id ON career_milestones(game_id);
CREATE INDEX idx_alumni_associations_club_id ON alumni_associations(club_id);
CREATE INDEX idx_hall_of_fame_inductions_person_id ON hall_of_fame_inductions(person_id);
CREATE INDEX idx_hall_of_fame_inductions_organization_id ON hall_of_fame_inductions(organization_id);
CREATE INDEX idx_national_team_selections_player_id ON national_team_selections(player_id);
CREATE INDEX idx_national_team_selections_nationality_id ON national_team_selections(nationality_id);
CREATE INDEX idx_national_team_selections_tournament_id ON national_team_selections(tournament_id);
CREATE INDEX idx_player_attributes_player_id ON player_attributes(player_id);
CREATE INDEX idx_player_attributes_evaluator_id ON player_attributes(evaluator_id);
CREATE INDEX idx_player_morale_player_id ON player_morale(player_id);
CREATE INDEX idx_line_chemistry_team_id ON line_chemistry(team_id);
CREATE INDEX idx_line_chemistry_player1_id ON line_chemistry(player1_id);
CREATE INDEX idx_line_chemistry_player2_id ON line_chemistry(player2_id);
CREATE INDEX idx_cups_federation_id ON cups(federation_id);
CREATE INDEX idx_phases_tournament_id ON phases(tournament_id);
CREATE INDEX idx_series_phase_id ON series(phase_id);
CREATE INDEX idx_series_team1_id ON series(team1_id);
CREATE INDEX idx_series_team2_id ON series(team2_id);
CREATE INDEX idx_series_winner_team_id ON series(winner_team_id);
CREATE INDEX idx_standings_league_id ON standings(league_id);
CREATE INDEX idx_standings_season_id ON standings(season_id);
CREATE INDEX idx_standings_team_id ON standings(team_id);
CREATE INDEX idx_tiebreakers_league_id ON tiebreakers(league_id);
CREATE INDEX idx_relegation_rules_league_id ON relegation_rules(league_id);
CREATE INDEX idx_bracket_matchups_tournament_id ON bracket_matchups(tournament_id);
CREATE INDEX idx_bracket_matchups_matchup_id ON bracket_matchups(matchup_id);
CREATE INDEX idx_bracket_matchups_next_matchup_id ON bracket_matchups(next_matchup_id);
CREATE INDEX idx_wildcard_standings_conference_id ON wildcard_standings(conference_id);
CREATE INDEX idx_wildcard_standings_season_id ON wildcard_standings(season_id);
CREATE INDEX idx_wildcard_standings_team_id ON wildcard_standings(team_id);
CREATE INDEX idx_age_dispensations_player_id ON age_dispensations(player_id);
CREATE INDEX idx_age_dispensations_league_id ON age_dispensations(league_id);
CREATE INDEX idx_age_dispensations_season_id ON age_dispensations(season_id);
CREATE INDEX idx_age_dispensations_approved_by_id ON age_dispensations(approved_by_id);
CREATE INDEX idx_import_quotas_league_id ON import_quotas(league_id);
CREATE INDEX idx_import_quotas_season_id ON import_quotas(season_id);
CREATE INDEX idx_volunteers_person_id ON volunteers(person_id);
CREATE INDEX idx_volunteers_club_id ON volunteers(club_id);
CREATE INDEX idx_digital_game_sheets_game_id ON digital_game_sheets(game_id);
CREATE INDEX idx_digital_game_sheets_submitted_by_id ON digital_game_sheets(submitted_by_id);
CREATE INDEX idx_game_sheet_signatures_game_sheet_id ON game_sheet_signatures(game_sheet_id);
CREATE INDEX idx_game_sheet_signatures_signer_id ON game_sheet_signatures(signer_id);
CREATE INDEX idx_security_personnel_person_id ON security_personnel(person_id);
CREATE INDEX idx_security_personnel_arena_id ON security_personnel(arena_id);
CREATE INDEX idx_ice_resurfacing_schedule_game_id ON ice_resurfacing_schedule(game_id);
