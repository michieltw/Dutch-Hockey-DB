-- 08_compliance_administration_management.sql
-- Compliance, Administration, Club Management, Coaching

-- 1. federation_memberships
CREATE TABLE federation_memberships (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'FDMB',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    federation_id UUID NOT NULL REFERENCES federations(id) ON DELETE CASCADE,
    membership_number VARCHAR(100), -- Bondsnummer
    start_date DATE,
    end_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE federation_memberships ENABLE ROW LEVEL SECURITY;

-- 2. rule_versions
CREATE TABLE rule_versions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'RULV',
    rulebook_id UUID NOT NULL REFERENCES rulebooks(id) ON DELETE CASCADE,
    version_string VARCHAR(50),
    effective_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE rule_versions ENABLE ROW LEVEL SECURITY;

-- 3. rule_changes
CREATE TABLE rule_changes (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'RULC',
    rule_version_id UUID NOT NULL REFERENCES rule_versions(id) ON DELETE CASCADE,
    rule_number VARCHAR(50),
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE rule_changes ENABLE ROW LEVEL SECURITY;

-- 4. international_transfer_cards
CREATE TABLE international_transfer_cards (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ITCS',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    from_federation_id UUID REFERENCES federations(id) ON DELETE SET NULL,
    to_federation_id UUID REFERENCES federations(id) ON DELETE SET NULL,
    issue_date DATE,
    status VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE international_transfer_cards ENABLE ROW LEVEL SECURITY;

-- 5. rink_specifications
CREATE TABLE rink_specifications (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'RNKS',
    rink_id UUID NOT NULL REFERENCES rinks(id) ON DELETE CASCADE,
    glass_height_cm INTEGER,
    boards_height_cm INTEGER,
    ice_temperature NUMERIC(5, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE rink_specifications ENABLE ROW LEVEL SECURITY;

-- 6. equipment_specifications
CREATE TABLE equipment_specifications (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'EQSP',
    league_id UUID REFERENCES leagues(id) ON DELETE CASCADE,
    visor_mandatory BOOLEAN DEFAULT FALSE,
    neck_guard_mandatory BOOLEAN DEFAULT FALSE,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE equipment_specifications ENABLE ROW LEVEL SECURITY;

-- 7. anti_doping_records
CREATE TABLE anti_doping_records (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ADOP',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    test_date DATE,
    result VARCHAR(50),
    tested_by VARCHAR(100),
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE anti_doping_records ENABLE ROW LEVEL SECURITY;

-- 8. safeguarding_logs
CREATE TABLE safeguarding_logs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SAFE',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    document_type VARCHAR(100), -- 'VOG'
    issue_date DATE,
    expiry_date DATE,
    status VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE safeguarding_logs ENABLE ROW LEVEL SECURITY;

-- 9. safe_sport_certifications
CREATE TABLE safe_sport_certifications (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SSCT',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    certification_name VARCHAR(255),
    completed_date DATE,
    expiry_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE safe_sport_certifications ENABLE ROW LEVEL SECURITY;

-- 10. official_evaluations
CREATE TABLE official_evaluations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'OFEV',
    official_id UUID NOT NULL REFERENCES officials(id) ON DELETE CASCADE,
    game_id UUID REFERENCES games(id) ON DELETE SET NULL,
    evaluator_id UUID REFERENCES staff(id) ON DELETE SET NULL,
    score INTEGER CHECK (score BETWEEN 1 AND 100),
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE official_evaluations ENABLE ROW LEVEL SECURITY;

-- 11. training_certifications
CREATE TABLE training_certifications (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TRCT',
    coach_id UUID NOT NULL REFERENCES coaches(id) ON DELETE CASCADE,
    certification_level VARCHAR(100),
    date_achieved DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE training_certifications ENABLE ROW LEVEL SECURITY;

-- 12. incident_reports
CREATE TABLE incident_reports (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'INCR',
    game_id UUID REFERENCES games(id) ON DELETE SET NULL,
    reported_by_id UUID REFERENCES users(id) ON DELETE SET NULL,
    incident_date TIMESTAMPTZ,
    description TEXT,
    status VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE incident_reports ENABLE ROW LEVEL SECURITY;

-- 13. appeals
CREATE TABLE appeals (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'APPL',
    incident_id UUID REFERENCES incident_reports(id) ON DELETE CASCADE,
    filed_by_id UUID REFERENCES persons(id) ON DELETE CASCADE,
    description TEXT,
    status VARCHAR(50),
    resolution TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE appeals ENABLE ROW LEVEL SECURITY;

-- 14. suspensions
CREATE TABLE suspensions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SUSP',
    player_id UUID REFERENCES players(id) ON DELETE CASCADE,
    official_id UUID REFERENCES officials(id) ON DELETE CASCADE,
    coach_id UUID REFERENCES coaches(id) ON DELETE CASCADE,
    reason TEXT,
    games_suspended INTEGER,
    start_date DATE,
    end_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE suspensions ENABLE ROW LEVEL SECURITY;

-- 15. disciplinary_hearings
CREATE TABLE disciplinary_hearings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'DISH',
    incident_id UUID REFERENCES incident_reports(id) ON DELETE CASCADE,
    hearing_date TIMESTAMPTZ,
    outcome TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE disciplinary_hearings ENABLE ROW LEVEL SECURITY;

-- 16. licenses
CREATE TABLE licenses (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LICE',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    license_type_id UUID NOT NULL REFERENCES license_types(id) ON DELETE CASCADE,
    issue_date DATE,
    expiry_date DATE,
    status VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE licenses ENABLE ROW LEVEL SECURITY;

-- 17. transfer_rules
CREATE TABLE transfer_rules (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TRRU',
    league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
    deadline DATE,
    max_transfers_per_season INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE transfer_rules ENABLE ROW LEVEL SECURITY;

-- 18. transfer_rumors
CREATE TABLE transfer_rumors (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TRRM',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    target_club_id UUID REFERENCES clubs(id) ON DELETE SET NULL,
    source_url TEXT,
    reliability_score INTEGER CHECK (reliability_score BETWEEN 1 AND 100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE transfer_rumors ENABLE ROW LEVEL SECURITY;

-- 19. contract_clauses
CREATE TABLE contract_clauses (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CNCL',
    contract_id UUID NOT NULL REFERENCES contracts(id) ON DELETE CASCADE,
    clause_type VARCHAR(100), -- 'NMC', 'NTC', 'Performance Bonus'
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE contract_clauses ENABLE ROW LEVEL SECURITY;

-- 20. salaries
CREATE TABLE salaries (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SALA',
    contract_id UUID NOT NULL REFERENCES contracts(id) ON DELETE CASCADE,
    season_id UUID NOT NULL REFERENCES seasons(id) ON DELETE CASCADE,
    base_amount NUMERIC(12, 2),
    bonus_amount NUMERIC(12, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE salaries ENABLE ROW LEVEL SECURITY;

-- 21. retained_salaries
CREATE TABLE retained_salaries (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'RETS',
    contract_id UUID NOT NULL REFERENCES contracts(id) ON DELETE CASCADE,
    retaining_club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    retained_percentage NUMERIC(5, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE retained_salaries ENABLE ROW LEVEL SECURITY;

-- 22. salary_caps
CREATE TABLE salary_caps (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SCAP',
    league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
    season_id UUID NOT NULL REFERENCES seasons(id) ON DELETE CASCADE,
    cap_limit NUMERIC(15, 2),
    floor_limit NUMERIC(15, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE salary_caps ENABLE ROW LEVEL SECURITY;

-- 23. waivers
CREATE TABLE waivers (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'WAIV',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    date_placed DATE,
    status VARCHAR(50), -- 'Cleared', 'Claimed'
    claimed_by_club_id UUID REFERENCES clubs(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE waivers ENABLE ROW LEVEL SECURITY;

-- 24. buyouts
CREATE TABLE buyouts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'BYOT',
    contract_id UUID NOT NULL REFERENCES contracts(id) ON DELETE CASCADE,
    club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    buyout_date DATE,
    total_cost NUMERIC(12, 2),
    cap_hit_penalty NUMERIC(12, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE buyouts ENABLE ROW LEVEL SECURITY;

-- 25. loan_agreements
CREATE TABLE loan_agreements (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LOAN',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    parent_club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    loan_club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    start_date DATE,
    end_date DATE,
    recallable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE loan_agreements ENABLE ROW LEVEL SECURITY;

-- 26. two_way_contracts
CREATE TABLE two_way_contracts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TWOC',
    contract_id UUID NOT NULL REFERENCES contracts(id) ON DELETE CASCADE,
    major_league_salary NUMERIC(12, 2),
    minor_league_salary NUMERIC(12, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE two_way_contracts ENABLE ROW LEVEL SECURITY;

-- 27. referee_assignments
CREATE TABLE referee_assignments (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'RFAS',
    official_id UUID NOT NULL REFERENCES officials(id) ON DELETE CASCADE,
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    role VARCHAR(50),
    status VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE referee_assignments ENABLE ROW LEVEL SECURITY;

-- 28. insurance_policies
CREATE TABLE insurance_policies (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'INSP',
    club_id UUID REFERENCES clubs(id) ON DELETE CASCADE,
    player_id UUID REFERENCES players(id) ON DELETE CASCADE,
    provider_name VARCHAR(255),
    policy_number VARCHAR(100),
    coverage_amount NUMERIC(15, 2),
    expiry_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE insurance_policies ENABLE ROW LEVEL SECURITY;

-- 29. background_checks
CREATE TABLE background_checks (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'BGCK',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    check_date DATE,
    status VARCHAR(50),
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE background_checks ENABLE ROW LEVEL SECURITY;

-- 30. sponsorship_deals
CREATE TABLE sponsorship_deals (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SPND',
    sponsor_id UUID NOT NULL REFERENCES sponsors(id) ON DELETE CASCADE,
    club_id UUID REFERENCES clubs(id) ON DELETE CASCADE,
    league_id UUID REFERENCES leagues(id) ON DELETE CASCADE,
    deal_value NUMERIC(12, 2),
    start_date DATE,
    end_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE sponsorship_deals ENABLE ROW LEVEL SECURITY;

-- 31. advertising_inventory
CREATE TABLE advertising_inventory (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ADIN',
    arena_id UUID NOT NULL REFERENCES arenas(id) ON DELETE CASCADE,
    location VARCHAR(100), -- 'Boards', 'Ice', 'Zamboni'
    price NUMERIC(10, 2),
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE advertising_inventory ENABLE ROW LEVEL SECURITY;

-- 32. club_finances
CREATE TABLE club_finances (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CLFN',
    club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    season_id UUID NOT NULL REFERENCES seasons(id) ON DELETE CASCADE,
    total_revenue NUMERIC(15, 2),
    total_expenses NUMERIC(15, 2),
    net_income NUMERIC(15, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE club_finances ENABLE ROW LEVEL SECURITY;

-- 33. invoices
CREATE TABLE invoices (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'INVO',
    club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    issued_to_person_id UUID REFERENCES persons(id) ON DELETE SET NULL,
    issued_to_org_id UUID REFERENCES organizations(id) ON DELETE SET NULL,
    amount NUMERIC(12, 2),
    issue_date DATE,
    due_date DATE,
    status VARCHAR(50), -- 'Paid', 'Unpaid', 'Overdue'
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE invoices ENABLE ROW LEVEL SECURITY;

-- 34. budgets
CREATE TABLE budgets (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'BUDG',
    club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    season_id UUID NOT NULL REFERENCES seasons(id) ON DELETE CASCADE,
    department VARCHAR(100),
    allocated_amount NUMERIC(12, 2),
    spent_amount NUMERIC(12, 2) DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE budgets ENABLE ROW LEVEL SECURITY;

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

-- 36. transportation_logs
CREATE TABLE transportation_logs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TRLO',
    itinerary_id UUID NOT NULL REFERENCES travel_itineraries(id) ON DELETE CASCADE,
    vehicle_type VARCHAR(100),
    driver_name VARCHAR(255),
    cost NUMERIC(10, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE transportation_logs ENABLE ROW LEVEL SECURITY;

-- 37. accommodation_bookings
CREATE TABLE accommodation_bookings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ACBO',
    itinerary_id UUID NOT NULL REFERENCES travel_itineraries(id) ON DELETE CASCADE,
    hotel_name VARCHAR(255),
    check_in_date DATE,
    check_out_date DATE,
    rooms_booked INTEGER,
    cost NUMERIC(10, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE accommodation_bookings ENABLE ROW LEVEL SECURITY;

-- 38. staff_schedules
CREATE TABLE staff_schedules (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'STSC',
    staff_id UUID NOT NULL REFERENCES staff(id) ON DELETE CASCADE,
    shift_start TIMESTAMPTZ,
    shift_end TIMESTAMPTZ,
    role_assigned VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE staff_schedules ENABLE ROW LEVEL SECURITY;

-- 39. academy_enrollments
CREATE TABLE academy_enrollments (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ACEN',
    academy_id UUID NOT NULL REFERENCES youth_academies(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    enrollment_date DATE,
    status VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE academy_enrollments ENABLE ROW LEVEL SECURITY;

-- 40. regional_talent_centers
CREATE TABLE regional_talent_centers (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'RTCS',
    federation_id UUID NOT NULL REFERENCES federations(id) ON DELETE CASCADE,
    region_id UUID NOT NULL REFERENCES regions(id) ON DELETE CASCADE,
    name VARCHAR(255),
    director_id UUID REFERENCES staff(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE regional_talent_centers ENABLE ROW LEVEL SECURITY;

-- 41. coaching_strategies
CREATE TABLE coaching_strategies (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CSTR',
    coach_id UUID NOT NULL REFERENCES coaches(id) ON DELETE CASCADE,
    strategy_name VARCHAR(100), -- '1-3-1', 'Trap'
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE coaching_strategies ENABLE ROW LEVEL SECURITY;

-- Indexes for foreign keys
CREATE INDEX idx_federation_memberships_person_id ON federation_memberships(person_id);
CREATE INDEX idx_federation_memberships_federation_id ON federation_memberships(federation_id);
CREATE INDEX idx_rule_versions_rulebook_id ON rule_versions(rulebook_id);
CREATE INDEX idx_rule_changes_rule_version_id ON rule_changes(rule_version_id);
CREATE INDEX idx_international_transfer_cards_player_id ON international_transfer_cards(player_id);
CREATE INDEX idx_international_transfer_cards_from_federation_id ON international_transfer_cards(from_federation_id);
CREATE INDEX idx_international_transfer_cards_to_federation_id ON international_transfer_cards(to_federation_id);
CREATE INDEX idx_rink_specifications_rink_id ON rink_specifications(rink_id);
CREATE INDEX idx_equipment_specifications_league_id ON equipment_specifications(league_id);
CREATE INDEX idx_anti_doping_records_player_id ON anti_doping_records(player_id);
CREATE INDEX idx_safeguarding_logs_person_id ON safeguarding_logs(person_id);
CREATE INDEX idx_safe_sport_certifications_person_id ON safe_sport_certifications(person_id);
CREATE INDEX idx_official_evaluations_official_id ON official_evaluations(official_id);
CREATE INDEX idx_official_evaluations_game_id ON official_evaluations(game_id);
CREATE INDEX idx_official_evaluations_evaluator_id ON official_evaluations(evaluator_id);
CREATE INDEX idx_training_certifications_coach_id ON training_certifications(coach_id);
CREATE INDEX idx_incident_reports_game_id ON incident_reports(game_id);
CREATE INDEX idx_incident_reports_reported_by_id ON incident_reports(reported_by_id);
CREATE INDEX idx_appeals_incident_id ON appeals(incident_id);
CREATE INDEX idx_appeals_filed_by_id ON appeals(filed_by_id);
CREATE INDEX idx_suspensions_player_id ON suspensions(player_id);
CREATE INDEX idx_suspensions_official_id ON suspensions(official_id);
CREATE INDEX idx_suspensions_coach_id ON suspensions(coach_id);
CREATE INDEX idx_disciplinary_hearings_incident_id ON disciplinary_hearings(incident_id);
CREATE INDEX idx_licenses_person_id ON licenses(person_id);
CREATE INDEX idx_licenses_license_type_id ON licenses(license_type_id);
CREATE INDEX idx_transfer_rules_league_id ON transfer_rules(league_id);
CREATE INDEX idx_transfer_rumors_player_id ON transfer_rumors(player_id);
CREATE INDEX idx_transfer_rumors_target_club_id ON transfer_rumors(target_club_id);
CREATE INDEX idx_contract_clauses_contract_id ON contract_clauses(contract_id);
CREATE INDEX idx_salaries_contract_id ON salaries(contract_id);
CREATE INDEX idx_salaries_season_id ON salaries(season_id);
CREATE INDEX idx_retained_salaries_contract_id ON retained_salaries(contract_id);
CREATE INDEX idx_retained_salaries_retaining_club_id ON retained_salaries(retaining_club_id);
CREATE INDEX idx_salary_caps_league_id ON salary_caps(league_id);
CREATE INDEX idx_salary_caps_season_id ON salary_caps(season_id);
CREATE INDEX idx_waivers_player_id ON waivers(player_id);
CREATE INDEX idx_waivers_club_id ON waivers(club_id);
CREATE INDEX idx_waivers_claimed_by_club_id ON waivers(claimed_by_club_id);
CREATE INDEX idx_buyouts_contract_id ON buyouts(contract_id);
CREATE INDEX idx_buyouts_club_id ON buyouts(club_id);
CREATE INDEX idx_loan_agreements_player_id ON loan_agreements(player_id);
CREATE INDEX idx_loan_agreements_parent_club_id ON loan_agreements(parent_club_id);
CREATE INDEX idx_loan_agreements_loan_club_id ON loan_agreements(loan_club_id);
CREATE INDEX idx_two_way_contracts_contract_id ON two_way_contracts(contract_id);
CREATE INDEX idx_referee_assignments_official_id ON referee_assignments(official_id);
CREATE INDEX idx_referee_assignments_game_id ON referee_assignments(game_id);
CREATE INDEX idx_insurance_policies_club_id ON insurance_policies(club_id);
CREATE INDEX idx_insurance_policies_player_id ON insurance_policies(player_id);
CREATE INDEX idx_background_checks_person_id ON background_checks(person_id);
CREATE INDEX idx_sponsorship_deals_sponsor_id ON sponsorship_deals(sponsor_id);
CREATE INDEX idx_sponsorship_deals_club_id ON sponsorship_deals(club_id);
CREATE INDEX idx_sponsorship_deals_league_id ON sponsorship_deals(league_id);
CREATE INDEX idx_advertising_inventory_arena_id ON advertising_inventory(arena_id);
CREATE INDEX idx_club_finances_club_id ON club_finances(club_id);
CREATE INDEX idx_club_finances_season_id ON club_finances(season_id);
CREATE INDEX idx_invoices_club_id ON invoices(club_id);
CREATE INDEX idx_invoices_issued_to_person_id ON invoices(issued_to_person_id);
CREATE INDEX idx_invoices_issued_to_org_id ON invoices(issued_to_org_id);
CREATE INDEX idx_budgets_club_id ON budgets(club_id);
CREATE INDEX idx_budgets_season_id ON budgets(season_id);
CREATE INDEX idx_travel_itineraries_team_id ON travel_itineraries(team_id);
CREATE INDEX idx_travel_itineraries_game_id ON travel_itineraries(game_id);
CREATE INDEX idx_transportation_logs_itinerary_id ON transportation_logs(itinerary_id);
CREATE INDEX idx_accommodation_bookings_itinerary_id ON accommodation_bookings(itinerary_id);
CREATE INDEX idx_staff_schedules_staff_id ON staff_schedules(staff_id);
CREATE INDEX idx_academy_enrollments_academy_id ON academy_enrollments(academy_id);
CREATE INDEX idx_academy_enrollments_player_id ON academy_enrollments(player_id);
CREATE INDEX idx_regional_talent_centers_federation_id ON regional_talent_centers(federation_id);
CREATE INDEX idx_regional_talent_centers_region_id ON regional_talent_centers(region_id);
CREATE INDEX idx_regional_talent_centers_director_id ON regional_talent_centers(director_id);
CREATE INDEX idx_coaching_strategies_coach_id ON coaching_strategies(coach_id);
