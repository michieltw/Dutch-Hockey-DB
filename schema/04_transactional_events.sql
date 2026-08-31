-- 04_transactional_events.sql
-- Highly relational transactional data and events (Games, Goals, Penalties, Contracts, Orders)

-- 1. games
CREATE TABLE games (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'GAME',
    league_id UUID REFERENCES leagues(id) ON DELETE CASCADE,
    season_id UUID REFERENCES seasons(id) ON DELETE CASCADE,
    home_team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    away_team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    arena_id UUID REFERENCES arenas(id) ON DELETE SET NULL,
    start_time TIMESTAMPTZ,
    end_time TIMESTAMPTZ,
    status game_status_enum DEFAULT 'Scheduled',
    home_score INTEGER DEFAULT 0,
    away_score INTEGER DEFAULT 0,
    attendance INTEGER,
    ijnl_id VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE games ENABLE ROW LEVEL SECURITY;

-- 2. periods
CREATE TABLE periods (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PERI',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    period_number INTEGER NOT NULL, -- 1, 2, 3, 4 (OT), etc.
    start_time TIMESTAMPTZ,
    end_time TIMESTAMPTZ,
    length_minutes INTEGER DEFAULT 20,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE periods ENABLE ROW LEVEL SECURITY;

-- 3. goals

-- 4. penalties

-- 5. shots

-- 6. contracts
CREATE TABLE contracts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CONT',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    contract_type contract_type_enum,
    status contract_status_enum DEFAULT 'Active',
    start_date DATE,
    end_date DATE,
    signing_date DATE,
    base_salary NUMERIC(12, 2),
    signing_bonus NUMERIC(12, 2),
    currency VARCHAR(3) DEFAULT 'EUR',
    cap_hit NUMERIC(12, 2),
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE contracts ENABLE ROW LEVEL SECURITY;

-- 7. transfers
CREATE TABLE transfers (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TRAN',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    from_club_id UUID REFERENCES clubs(id) ON DELETE SET NULL,
    to_club_id UUID REFERENCES clubs(id) ON DELETE SET NULL,
    transfer_type transfer_type_enum,
    status transfer_status_enum DEFAULT 'Pending',
    transfer_date DATE,
    fee_amount NUMERIC(12, 2),
    currency VARCHAR(3) DEFAULT 'EUR',
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE transfers ENABLE ROW LEVEL SECURITY;

-- 8. injuries
CREATE TABLE injuries (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'INJU',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    injury_type injury_type_enum,
    status injury_status_enum DEFAULT 'Active',
    date_injured DATE,
    expected_return_date DATE,
    actual_return_date DATE,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE injuries ENABLE ROW LEVEL SECURITY;

-- 10. orders
CREATE TABLE orders (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ORDR',
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    order_date TIMESTAMPTZ DEFAULT NOW(),
    status order_status_enum DEFAULT 'Pending',
    total_amount NUMERIC(10, 2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'EUR',
    shipping_address_line1 VARCHAR(255),
    shipping_city VARCHAR(100),
    shipping_postal_code VARCHAR(20),
    shipping_country VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

-- 11. order_items
CREATE TABLE order_items (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ODRI',
    order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE RESTRICT,
    quantity INTEGER NOT NULL,
    unit_price NUMERIC(10, 2) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;

-- 12. tickets
CREATE TABLE tickets (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TICK',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    order_id UUID REFERENCES orders(id) ON DELETE SET NULL,
    status ticket_status_enum DEFAULT 'Available',
    section VARCHAR(50),
    row VARCHAR(50),
    seat VARCHAR(50),
    price NUMERIC(10, 2),
    barcode VARCHAR(255) UNIQUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE tickets ENABLE ROW LEVEL SECURITY;

-- 13. posts (Social / Media)
CREATE TABLE posts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'POST',
    author_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(255),
    content TEXT NOT NULL,
    media_url TEXT,
    media_type media_type_enum,
    status post_status_enum DEFAULT 'Published',
    club_id UUID REFERENCES clubs(id) ON DELETE CASCADE, -- if post is specific to a club
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;

-- 14. comments
CREATE TABLE comments (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'COMM',
    post_id UUID NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
    author_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    parent_comment_id UUID REFERENCES comments(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE comments ENABLE ROW LEVEL SECURITY;

-- 15. expenses (Club Management)
CREATE TABLE expenses (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'EXPS',
    club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    amount NUMERIC(12, 2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'EUR',
    expense_date DATE,
    category VARCHAR(100),
    description TEXT,
    receipt_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE expenses ENABLE ROW LEVEL SECURITY;

-- Indexes for foreign keys
CREATE INDEX idx_games_league_id ON games(league_id);
CREATE INDEX idx_games_season_id ON games(season_id);
CREATE INDEX idx_games_home_team_id ON games(home_team_id);
CREATE INDEX idx_games_away_team_id ON games(away_team_id);
CREATE INDEX idx_games_arena_id ON games(arena_id);
CREATE INDEX idx_periods_game_id ON periods(game_id);
CREATE INDEX idx_goals_game_id ON goals(game_id);
CREATE INDEX idx_goals_period_id ON goals(period_id);
CREATE INDEX idx_goals_scoring_team_id ON goals(scoring_team_id);
CREATE INDEX idx_goals_scorer_id ON goals(scorer_id);
CREATE INDEX idx_goals_primary_assist_id ON goals(primary_assist_id);
CREATE INDEX idx_goals_secondary_assist_id ON goals(secondary_assist_id);
CREATE INDEX idx_penalties_game_id ON penalties(game_id);
CREATE INDEX idx_penalties_period_id ON penalties(period_id);
CREATE INDEX idx_penalties_team_id ON penalties(team_id);
CREATE INDEX idx_penalties_player_id ON penalties(player_id);
CREATE INDEX idx_penalties_drawn_by_player_id ON penalties(drawn_by_player_id);
CREATE INDEX idx_shots_game_id ON shots(game_id);
CREATE INDEX idx_shots_period_id ON shots(period_id);
CREATE INDEX idx_shots_team_id ON shots(team_id);
CREATE INDEX idx_shots_shooter_id ON shots(shooter_id);
CREATE INDEX idx_shots_goalie_id ON shots(goalie_id);
CREATE INDEX idx_contracts_player_id ON contracts(player_id);
CREATE INDEX idx_contracts_club_id ON contracts(club_id);
CREATE INDEX idx_transfers_player_id ON transfers(player_id);
CREATE INDEX idx_transfers_from_club_id ON transfers(from_club_id);
CREATE INDEX idx_transfers_to_club_id ON transfers(to_club_id);
CREATE INDEX idx_injuries_player_id ON injuries(player_id);
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);
CREATE INDEX idx_tickets_game_id ON tickets(game_id);
CREATE INDEX idx_tickets_user_id ON tickets(user_id);
CREATE INDEX idx_tickets_order_id ON tickets(order_id);
CREATE INDEX idx_posts_author_id ON posts(author_id);
CREATE INDEX idx_posts_club_id ON posts(club_id);
CREATE INDEX idx_comments_post_id ON comments(post_id);
CREATE INDEX idx_comments_author_id ON comments(author_id);
CREATE INDEX idx_comments_parent_comment_id ON comments(parent_comment_id);
CREATE INDEX idx_expenses_club_id ON expenses(club_id);
