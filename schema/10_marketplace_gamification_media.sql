-- 10_marketplace_gamification_media.sql
-- Remaining Marketplace, Gamification, Media, Broadcasting, History

-- 1. sellers
CREATE TABLE sellers (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SELL',
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    store_name VARCHAR(255),
    rating NUMERIC(3, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE sellers ENABLE ROW LEVEL SECURITY;

-- 2. inventory
CREATE TABLE inventory (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'INVT',
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    seller_id UUID REFERENCES sellers(id) ON DELETE SET NULL,
    retailer_id UUID REFERENCES retailers(id) ON DELETE SET NULL,
    quantity INTEGER DEFAULT 0,
    location VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE inventory ENABLE ROW LEVEL SECURITY;

-- 3. payments
CREATE TABLE payments (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PAYM',
    order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    amount NUMERIC(10, 2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'EUR',
    payment_method VARCHAR(50),
    status payment_status_enum DEFAULT 'Pending',
    transaction_id VARCHAR(255),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;

-- 4. shipping
CREATE TABLE shipping (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SHIP',
    order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    carrier_name VARCHAR(100),
    tracking_number VARCHAR(255),
    status VARCHAR(50),
    estimated_delivery DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE shipping ENABLE ROW LEVEL SECURITY;

-- 5. reviews
CREATE TABLE reviews (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'REVI',
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    rating INTEGER CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;

-- 6. shopping_carts
CREATE TABLE shopping_carts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CART',
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    quantity INTEGER DEFAULT 1,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE shopping_carts ENABLE ROW LEVEL SECURITY;

-- 7. wishlists
CREATE TABLE wishlists (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'WISH',
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE wishlists ENABLE ROW LEVEL SECURITY;

-- 8. classified_ads
CREATE TABLE classified_ads (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CLAD',
    seller_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    price NUMERIC(10, 2),
    currency VARCHAR(3) DEFAULT 'EUR',
    category_id UUID REFERENCES categories(id) ON DELETE SET NULL,
    status VARCHAR(50) DEFAULT 'Active',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE classified_ads ENABLE ROW LEVEL SECURITY;

-- 9. bids
CREATE TABLE bids (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'BIDS',
    ad_id UUID NOT NULL REFERENCES classified_ads(id) ON DELETE CASCADE,
    bidder_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    amount NUMERIC(10, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE bids ENABLE ROW LEVEL SECURITY;

-- 10. season_tickets
CREATE TABLE season_tickets (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SSTI',
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    season_id UUID NOT NULL REFERENCES seasons(id) ON DELETE CASCADE,
    seat_identifier VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE season_tickets ENABLE ROW LEVEL SECURITY;

-- 11. ticket_packages
CREATE TABLE ticket_packages (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TPKG',
    club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    name VARCHAR(255),
    description TEXT,
    price NUMERIC(10, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE ticket_packages ENABLE ROW LEVEL SECURITY;

-- 12. ticket_scans
CREATE TABLE ticket_scans (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TSCN',
    ticket_id UUID NOT NULL REFERENCES tickets(id) ON DELETE CASCADE,
    scanned_at TIMESTAMPTZ DEFAULT NOW(),
    scanned_by_id UUID REFERENCES users(id) ON DELETE SET NULL,
    gate_number VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE ticket_scans ENABLE ROW LEVEL SECURITY;

-- 13. seating_charts
CREATE TABLE seating_charts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SECH',
    arena_id UUID NOT NULL REFERENCES arenas(id) ON DELETE CASCADE,
    layout_name VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE seating_charts ENABLE ROW LEVEL SECURITY;

-- 14. sections
CREATE TABLE sections (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SECT',
    chart_id UUID NOT NULL REFERENCES seating_charts(id) ON DELETE CASCADE,
    name VARCHAR(50),
    capacity INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE sections ENABLE ROW LEVEL SECURITY;

-- 15. rows
CREATE TABLE rows (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SROW',
    section_id UUID NOT NULL REFERENCES sections(id) ON DELETE CASCADE,
    name VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE rows ENABLE ROW LEVEL SECURITY;

-- 16. seats
CREATE TABLE seats (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SEAT',
    row_id UUID NOT NULL REFERENCES rows(id) ON DELETE CASCADE,
    number VARCHAR(50),
    is_accessible BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE seats ENABLE ROW LEVEL SECURITY;

-- Gamification Extensions

-- 17. user_achievements
CREATE TABLE user_achievements (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'UACH',
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    achievement_id UUID NOT NULL REFERENCES achievements(id) ON DELETE CASCADE,
    date_awarded TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE user_achievements ENABLE ROW LEVEL SECURITY;

-- 18. points_ledger
CREATE TABLE points_ledger (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PTLG',
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    points INTEGER,
    reason TEXT,
    transaction_date TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE points_ledger ENABLE ROW LEVEL SECURITY;

-- 19. leaderboards
CREATE TABLE leaderboards (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LDBO',
    name VARCHAR(100),
    type VARCHAR(50), -- 'Global', 'Club Specific'
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE leaderboards ENABLE ROW LEVEL SECURITY;

-- 20. quests
CREATE TABLE quests (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'QEST',
    name VARCHAR(100),
    description TEXT,
    points_reward INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE quests ENABLE ROW LEVEL SECURITY;

-- 21. rewards
CREATE TABLE rewards (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'REWD',
    name VARCHAR(100),
    description TEXT,
    points_cost INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE rewards ENABLE ROW LEVEL SECURITY;

-- 28. predictions
CREATE TABLE predictions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PRED',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    predicted_winner_id UUID REFERENCES teams(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE predictions ENABLE ROW LEVEL SECURITY;

-- 29. prediction_results
CREATE TABLE prediction_results (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PRES',
    prediction_id UUID NOT NULL REFERENCES predictions(id) ON DELETE CASCADE,
    is_correct BOOLEAN,
    points_awarded INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE prediction_results ENABLE ROW LEVEL SECURITY;

-- 30. trivia_questions
CREATE TABLE trivia_questions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TRVQ',
    question TEXT NOT NULL,
    correct_answer TEXT NOT NULL,
    points INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE trivia_questions ENABLE ROW LEVEL SECURITY;

-- 31. trivia_answers
CREATE TABLE trivia_answers (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TRVA',
    question_id UUID NOT NULL REFERENCES trivia_questions(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    user_answer TEXT,
    is_correct BOOLEAN,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE trivia_answers ENABLE ROW LEVEL SECURITY;

-- 32. articles
CREATE TABLE articles (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ARTI',
    title VARCHAR(255) NOT NULL,
    content TEXT,
    author_id UUID REFERENCES users(id) ON DELETE SET NULL,
    published_date TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE articles ENABLE ROW LEVEL SECURITY;

-- 33. authors
CREATE TABLE authors (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'AUTH',
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    bio TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE authors ENABLE ROW LEVEL SECURITY;

-- 34. editorial_columns
CREATE TABLE editorial_columns (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ECOL',
    name VARCHAR(100),
    author_id UUID REFERENCES authors(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE editorial_columns ENABLE ROW LEVEL SECURITY;

-- 35. match_previews
CREATE TABLE match_previews (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'MAPR',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    article_id UUID NOT NULL REFERENCES articles(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE match_previews ENABLE ROW LEVEL SECURITY;

-- 36. match_reports
CREATE TABLE match_reports (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'MARE',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    article_id UUID NOT NULL REFERENCES articles(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE match_reports ENABLE ROW LEVEL SECURITY;

-- 37. interviews
CREATE TABLE interviews (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'INTV',
    article_id UUID NOT NULL REFERENCES articles(id) ON DELETE CASCADE,
    interviewee_person_id UUID REFERENCES persons(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE interviews ENABLE ROW LEVEL SECURITY;

-- 38. newsletters
CREATE TABLE newsletters (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'NEWS',
    subject VARCHAR(255),
    content TEXT,
    sent_date TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE newsletters ENABLE ROW LEVEL SECURITY;

-- 39. galleries
CREATE TABLE galleries (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'GALL',
    name VARCHAR(100),
    description TEXT,
    event_id UUID REFERENCES events(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE galleries ENABLE ROW LEVEL SECURITY;

-- 40. photos
CREATE TABLE photos (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PHOT',
    gallery_id UUID REFERENCES galleries(id) ON DELETE CASCADE,
    image_url TEXT NOT NULL,
    caption TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE photos ENABLE ROW LEVEL SECURITY;

-- 41. videos
CREATE TABLE videos (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'VIDE',
    title VARCHAR(255),
    video_url TEXT NOT NULL,
    game_id UUID REFERENCES games(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE videos ENABLE ROW LEVEL SECURITY;

-- 42. live_streams
CREATE TABLE live_streams (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LSTR',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    stream_url TEXT NOT NULL,
    platform VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE live_streams ENABLE ROW LEVEL SECURITY;

-- 43. broadcast_schedules
CREATE TABLE broadcast_schedules (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'BRSC',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    channel_name VARCHAR(100),
    start_time TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE broadcast_schedules ENABLE ROW LEVEL SECURITY;

-- 44. commentators
CREATE TABLE commentators (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CMNT',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    broadcast_id UUID NOT NULL REFERENCES broadcast_schedules(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE commentators ENABLE ROW LEVEL SECURITY;

-- 45. highlights
CREATE TABLE highlights (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'HIGH',
    video_id UUID NOT NULL REFERENCES videos(id) ON DELETE CASCADE,
    game_id UUID REFERENCES games(id) ON DELETE SET NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE highlights ENABLE ROW LEVEL SECURITY;

-- 46. press_releases
CREATE TABLE press_releases (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PRER',
    organization_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    title VARCHAR(255),
    content TEXT,
    release_date TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE press_releases ENABLE ROW LEVEL SECURITY;

-- 47. podcasts
CREATE TABLE podcasts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PODC',
    name VARCHAR(255),
    host_id UUID REFERENCES users(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE podcasts ENABLE ROW LEVEL SECURITY;

-- 48. podcast_episodes
CREATE TABLE podcast_episodes (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PODE',
    podcast_id UUID NOT NULL REFERENCES podcasts(id) ON DELETE CASCADE,
    title VARCHAR(255),
    audio_url TEXT NOT NULL,
    published_date TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE podcast_episodes ENABLE ROW LEVEL SECURITY;

-- 49. trophies
CREATE TABLE trophies (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TROP',
    name VARCHAR(255),
    description TEXT,
    league_id UUID REFERENCES leagues(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE trophies ENABLE ROW LEVEL SECURITY;

-- 50. award_winners
CREATE TABLE award_winners (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'AWDW',
    award_id UUID NOT NULL REFERENCES awards(id) ON DELETE CASCADE,
    player_id UUID REFERENCES players(id) ON DELETE SET NULL,
    team_id UUID REFERENCES teams(id) ON DELETE SET NULL,
    season_id UUID REFERENCES seasons(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE award_winners ENABLE ROW LEVEL SECURITY;

-- 51. historical_records
CREATE TABLE historical_records (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'HIRE',
    record_name VARCHAR(255), -- 'Most Goals in a Season'
    record_value VARCHAR(100),
    holder_player_id UUID REFERENCES players(id) ON DELETE SET NULL,
    holder_team_id UUID REFERENCES teams(id) ON DELETE SET NULL,
    date_achieved DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE historical_records ENABLE ROW LEVEL SECURITY;

-- 52. championship_banners
CREATE TABLE championship_banners (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CHAM',
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    arena_id UUID REFERENCES arenas(id) ON DELETE CASCADE,
    season_id UUID REFERENCES seasons(id) ON DELETE CASCADE,
    title VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE championship_banners ENABLE ROW LEVEL SECURITY;

-- Indexes for foreign keys
CREATE INDEX idx_sellers_user_id ON sellers(user_id);
CREATE INDEX idx_inventory_product_id ON inventory(product_id);
CREATE INDEX idx_inventory_seller_id ON inventory(seller_id);
CREATE INDEX idx_payments_order_id ON payments(order_id);
CREATE INDEX idx_shipping_order_id ON shipping(order_id);
CREATE INDEX idx_reviews_product_id ON reviews(product_id);
CREATE INDEX idx_reviews_user_id ON reviews(user_id);
CREATE INDEX idx_shopping_carts_user_id ON shopping_carts(user_id);
CREATE INDEX idx_shopping_carts_product_id ON shopping_carts(product_id);
CREATE INDEX idx_wishlists_user_id ON wishlists(user_id);
CREATE INDEX idx_wishlists_product_id ON wishlists(product_id);
CREATE INDEX idx_classified_ads_seller_id ON classified_ads(seller_id);
CREATE INDEX idx_classified_ads_category_id ON classified_ads(category_id);
CREATE INDEX idx_bids_ad_id ON bids(ad_id);
CREATE INDEX idx_bids_bidder_id ON bids(bidder_id);
CREATE INDEX idx_season_tickets_user_id ON season_tickets(user_id);
CREATE INDEX idx_season_tickets_club_id ON season_tickets(club_id);
CREATE INDEX idx_season_tickets_season_id ON season_tickets(season_id);
CREATE INDEX idx_ticket_packages_club_id ON ticket_packages(club_id);
CREATE INDEX idx_ticket_scans_ticket_id ON ticket_scans(ticket_id);
CREATE INDEX idx_ticket_scans_scanned_by_id ON ticket_scans(scanned_by_id);
CREATE INDEX idx_seating_charts_arena_id ON seating_charts(arena_id);
CREATE INDEX idx_sections_chart_id ON sections(chart_id);
CREATE INDEX idx_rows_section_id ON rows(section_id);
CREATE INDEX idx_seats_row_id ON seats(row_id);
CREATE INDEX idx_user_achievements_user_id ON user_achievements(user_id);
CREATE INDEX idx_user_achievements_achievement_id ON user_achievements(achievement_id);
CREATE INDEX idx_points_ledger_user_id ON points_ledger(user_id);
CREATE INDEX idx_predictions_game_id ON predictions(game_id);
CREATE INDEX idx_predictions_user_id ON predictions(user_id);
CREATE INDEX idx_predictions_predicted_winner_id ON predictions(predicted_winner_id);
CREATE INDEX idx_prediction_results_prediction_id ON prediction_results(prediction_id);
CREATE INDEX idx_trivia_answers_question_id ON trivia_answers(question_id);
CREATE INDEX idx_trivia_answers_user_id ON trivia_answers(user_id);
CREATE INDEX idx_articles_author_id ON articles(author_id);
CREATE INDEX idx_authors_user_id ON authors(user_id);
CREATE INDEX idx_editorial_columns_author_id ON editorial_columns(author_id);
CREATE INDEX idx_match_previews_game_id ON match_previews(game_id);
CREATE INDEX idx_match_previews_article_id ON match_previews(article_id);
CREATE INDEX idx_match_reports_game_id ON match_reports(game_id);
CREATE INDEX idx_match_reports_article_id ON match_reports(article_id);
CREATE INDEX idx_interviews_article_id ON interviews(article_id);
CREATE INDEX idx_interviews_interviewee_person_id ON interviews(interviewee_person_id);
CREATE INDEX idx_galleries_event_id ON galleries(event_id);
CREATE INDEX idx_photos_gallery_id ON photos(gallery_id);
CREATE INDEX idx_videos_game_id ON videos(game_id);
CREATE INDEX idx_live_streams_game_id ON live_streams(game_id);
CREATE INDEX idx_broadcast_schedules_game_id ON broadcast_schedules(game_id);
CREATE INDEX idx_commentators_person_id ON commentators(person_id);
CREATE INDEX idx_commentators_broadcast_id ON commentators(broadcast_id);
CREATE INDEX idx_highlights_video_id ON highlights(video_id);
CREATE INDEX idx_highlights_game_id ON highlights(game_id);
CREATE INDEX idx_press_releases_organization_id ON press_releases(organization_id);
CREATE INDEX idx_podcasts_host_id ON podcasts(host_id);
CREATE INDEX idx_podcast_episodes_podcast_id ON podcast_episodes(podcast_id);
CREATE INDEX idx_trophies_league_id ON trophies(league_id);
CREATE INDEX idx_award_winners_award_id ON award_winners(award_id);
CREATE INDEX idx_award_winners_player_id ON award_winners(player_id);
CREATE INDEX idx_award_winners_team_id ON award_winners(team_id);
CREATE INDEX idx_award_winners_season_id ON award_winners(season_id);
CREATE INDEX idx_historical_records_holder_player_id ON historical_records(holder_player_id);
CREATE INDEX idx_historical_records_holder_team_id ON historical_records(holder_team_id);
CREATE INDEX idx_championship_banners_team_id ON championship_banners(team_id);
CREATE INDEX idx_championship_banners_arena_id ON championship_banners(arena_id);
CREATE INDEX idx_championship_banners_season_id ON championship_banners(season_id);
