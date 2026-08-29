-- 09_development_facilities_social_gamification.sql
-- Player Development, Medical, Facilities, Equipment, Social, Gamification, Media

-- 1. training_sessions
CREATE TABLE training_sessions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TRNS',
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    rink_id UUID REFERENCES rinks(id) ON DELETE SET NULL,
    scheduled_time TIMESTAMPTZ,
    duration_minutes INTEGER,
    focus_area VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE training_sessions ENABLE ROW LEVEL SECURITY;

-- 2. practice_attendance
CREATE TABLE practice_attendance (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PRAT',
    session_id UUID NOT NULL REFERENCES training_sessions(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    status VARCHAR(50), -- 'Present', 'Absent', 'Excused'
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE practice_attendance ENABLE ROW LEVEL SECURITY;

-- 3. drills
CREATE TABLE drills (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'DRIL',
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50), -- 'Skating', 'Shooting', 'Passing'
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE drills ENABLE ROW LEVEL SECURITY;

-- 4. skill_evaluations
CREATE TABLE skill_evaluations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SKEV',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    evaluator_id UUID REFERENCES staff(id) ON DELETE SET NULL,
    evaluation_date DATE,
    overall_score INTEGER CHECK (overall_score BETWEEN 1 AND 100),
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE skill_evaluations ENABLE ROW LEVEL SECURITY;

-- 5. development_plans
CREATE TABLE development_plans (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'DEVP',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    coach_id UUID REFERENCES coaches(id) ON DELETE SET NULL,
    start_date DATE,
    end_date DATE,
    goals TEXT,
    progress_notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE development_plans ENABLE ROW LEVEL SECURITY;

-- 6. fitness_tests
CREATE TABLE fitness_tests (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'FITT',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    test_date DATE,
    vo2_max NUMERIC(5, 2),
    bench_press_max INTEGER,
    sprint_time NUMERIC(5, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE fitness_tests ENABLE ROW LEVEL SECURITY;

-- 7. scouts
CREATE TABLE scouts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SCOU',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    organization_id UUID REFERENCES organizations(id) ON DELETE SET NULL,
    region_covered VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE scouts ENABLE ROW LEVEL SECURITY;

-- 8. scouting_reports
CREATE TABLE scouting_reports (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SCOR',
    scout_id UUID NOT NULL REFERENCES scouts(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    game_id UUID REFERENCES games(id) ON DELETE SET NULL,
    report_date DATE,
    grade VARCHAR(10),
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE scouting_reports ENABLE ROW LEVEL SECURITY;

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

-- 10. draft_prospects
CREATE TABLE draft_prospects (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'DRPR',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
    draft_year INTEGER,
    projected_round INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE draft_prospects ENABLE ROW LEVEL SECURITY;

-- 11. draft_rankings
CREATE TABLE draft_rankings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'DRRK',
    prospect_id UUID NOT NULL REFERENCES draft_prospects(id) ON DELETE CASCADE,
    source_name VARCHAR(100), -- 'EliteProspects', 'Central Scouting'
    rank_position INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE draft_rankings ENABLE ROW LEVEL SECURITY;

-- 12. draft_picks
CREATE TABLE draft_picks (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'DRPK',
    league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
    draft_year INTEGER,
    round_number INTEGER,
    pick_number INTEGER,
    club_id UUID REFERENCES clubs(id) ON DELETE CASCADE,
    player_id UUID REFERENCES players(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE draft_picks ENABLE ROW LEVEL SECURITY;

-- 13. rehab_programs
CREATE TABLE rehab_programs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'REHB',
    injury_id UUID NOT NULL REFERENCES injuries(id) ON DELETE CASCADE,
    start_date DATE,
    end_date DATE,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE rehab_programs ENABLE ROW LEVEL SECURITY;

-- 14. concussion_protocols
CREATE TABLE concussion_protocols (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CONC',
    injury_id UUID NOT NULL REFERENCES injuries(id) ON DELETE CASCADE,
    step_reached INTEGER, -- 1 to 6 return-to-play steps
    cleared BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE concussion_protocols ENABLE ROW LEVEL SECURITY;

-- 15. treatment_logs
CREATE TABLE treatment_logs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TREL',
    injury_id UUID NOT NULL REFERENCES injuries(id) ON DELETE CASCADE,
    treatment_date DATE,
    description TEXT,
    administered_by_id UUID REFERENCES staff(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE treatment_logs ENABLE ROW LEVEL SECURITY;

-- 16. locker_rooms
CREATE TABLE locker_rooms (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LOCK',
    arena_id UUID NOT NULL REFERENCES arenas(id) ON DELETE CASCADE,
    room_number VARCHAR(50),
    capacity INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE locker_rooms ENABLE ROW LEVEL SECURITY;

-- 17. locker_assignments
CREATE TABLE locker_assignments (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LCAS',
    locker_room_id UUID NOT NULL REFERENCES locker_rooms(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    locker_number VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE locker_assignments ENABLE ROW LEVEL SECURITY;

-- 18. ice_maintenance_logs
CREATE TABLE ice_maintenance_logs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ICML',
    rink_id UUID NOT NULL REFERENCES rinks(id) ON DELETE CASCADE,
    maintenance_date TIMESTAMPTZ,
    task_description TEXT,
    performed_by_id UUID REFERENCES staff(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE ice_maintenance_logs ENABLE ROW LEVEL SECURITY;

-- 19. zamboni_schedules
CREATE TABLE zamboni_schedules (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ZAMB',
    rink_id UUID NOT NULL REFERENCES rinks(id) ON DELETE CASCADE,
    scheduled_time TIMESTAMPTZ,
    driver_id UUID REFERENCES staff(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE zamboni_schedules ENABLE ROW LEVEL SECURITY;

-- 20. facility_bookings
CREATE TABLE facility_bookings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'FBOO',
    rink_id UUID NOT NULL REFERENCES rinks(id) ON DELETE CASCADE,
    booked_by_org_id UUID REFERENCES organizations(id) ON DELETE SET NULL,
    start_time TIMESTAMPTZ,
    end_time TIMESTAMPTZ,
    purpose VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE facility_bookings ENABLE ROW LEVEL SECURITY;

-- 21. equipment_inventory
CREATE TABLE equipment_inventory (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'EQIN',
    club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    item_name VARCHAR(100),
    quantity INTEGER,
    condition VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE equipment_inventory ENABLE ROW LEVEL SECURITY;

-- 22. equipment_repairs
CREATE TABLE equipment_repairs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'EQRE',
    inventory_id UUID NOT NULL REFERENCES equipment_inventory(id) ON DELETE CASCADE,
    repair_date DATE,
    cost NUMERIC(10, 2),
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE equipment_repairs ENABLE ROW LEVEL SECURITY;

-- 23. skate_sharpening_logs
CREATE TABLE skate_sharpening_logs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SKSL',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    hollow_radius VARCHAR(50),
    sharpened_by_id UUID REFERENCES staff(id) ON DELETE SET NULL,
    date_sharpened DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE skate_sharpening_logs ENABLE ROW LEVEL SECURITY;

-- 24. safety_inspections
CREATE TABLE safety_inspections (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SAFI',
    arena_id UUID NOT NULL REFERENCES arenas(id) ON DELETE CASCADE,
    inspection_date DATE,
    inspector_name VARCHAR(100),
    passed BOOLEAN,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE safety_inspections ENABLE ROW LEVEL SECURITY;

-- 25. player_skates
CREATE TABLE player_skates (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PSKA',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    brand_id UUID REFERENCES brands(id) ON DELETE SET NULL,
    model VARCHAR(100),
    size NUMERIC(4, 1),
    status equipment_status_enum,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE player_skates ENABLE ROW LEVEL SECURITY;

-- 26. player_protective_gear
CREATE TABLE player_protective_gear (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PPGR',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    gear_type VARCHAR(100), -- 'Helmet', 'Gloves', 'Pants'
    brand_id UUID REFERENCES brands(id) ON DELETE SET NULL,
    model VARCHAR(100),
    status equipment_status_enum,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE player_protective_gear ENABLE ROW LEVEL SECURITY;

-- 27. profiles
CREATE TABLE profiles (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PROF',
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    bio TEXT,
    favorite_club_id UUID REFERENCES clubs(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- 28. friendships
CREATE TABLE friendships (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'FRIE',
    user1_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    user2_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    status VARCHAR(50), -- 'Pending', 'Accepted'
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE friendships ENABLE ROW LEVEL SECURITY;

-- 29. follows
CREATE TABLE follows (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'FOLL',
    follower_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    followed_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE follows ENABLE ROW LEVEL SECURITY;

-- 30. likes
CREATE TABLE likes (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LIKE',
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    post_id UUID REFERENCES posts(id) ON DELETE CASCADE,
    comment_id UUID REFERENCES comments(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE likes ENABLE ROW LEVEL SECURITY;

-- 31. shares
CREATE TABLE shares (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SHAR',
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    post_id UUID NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE shares ENABLE ROW LEVEL SECURITY;

-- 32. messages
CREATE TABLE messages (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'MESS',
    sender_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    receiver_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    content TEXT,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;

-- 33. chat_rooms
CREATE TABLE chat_rooms (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CHAT',
    name VARCHAR(100),
    is_private BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE chat_rooms ENABLE ROW LEVEL SECURITY;

-- 34. forum_categories
CREATE TABLE forum_categories (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'FCAT',
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE forum_categories ENABLE ROW LEVEL SECURITY;

-- 35. forum_topics
CREATE TABLE forum_topics (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'FTOP',
    category_id UUID NOT NULL REFERENCES forum_categories(id) ON DELETE CASCADE,
    author_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE forum_topics ENABLE ROW LEVEL SECURITY;

-- 36. forum_replies
CREATE TABLE forum_replies (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'FREP',
    topic_id UUID NOT NULL REFERENCES forum_topics(id) ON DELETE CASCADE,
    author_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE forum_replies ENABLE ROW LEVEL SECURITY;

-- 37. polls
CREATE TABLE polls (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'POLL',
    question TEXT NOT NULL,
    created_by_id UUID REFERENCES users(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE polls ENABLE ROW LEVEL SECURITY;

-- 38. poll_votes
CREATE TABLE poll_votes (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PVOT',
    poll_id UUID NOT NULL REFERENCES polls(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    option_selected VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE poll_votes ENABLE ROW LEVEL SECURITY;

-- 39. fan_clubs
CREATE TABLE fan_clubs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'FANC',
    club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    name VARCHAR(255),
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE fan_clubs ENABLE ROW LEVEL SECURITY;

-- 40. user_roles (Many to Many explicit role assignments if needed)
CREATE TABLE user_roles (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'USRR',
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role user_role_enum NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE user_roles ENABLE ROW LEVEL SECURITY;
