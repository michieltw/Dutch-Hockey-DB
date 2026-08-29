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
