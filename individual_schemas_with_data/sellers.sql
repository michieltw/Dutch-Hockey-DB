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

-- Initial Data for users (to satisfy seller FK)
-- Note: 'users' table is typically needed, so we'll just insert users directly for the sellers.
-- However, we don't have users.sql copied. Let's just create placeholder user IDs and insert into a mock users.sql.

-- Data for sellers (Retailers in the Benelux)
INSERT INTO sellers (id, user_id, store_name, rating) VALUES
(gen_random_uuid(), '11111111-1111-1111-1111-111111111111', 'IJshockeyshop.nl', 4.8),
(gen_random_uuid(), '11111111-1111-1111-1111-111111111112', 'Pro Hockey', 4.5),
(gen_random_uuid(), '11111111-1111-1111-1111-111111111113', 'Waterman Sport', 4.7),
(gen_random_uuid(), '11111111-1111-1111-1111-111111111114', 'Hockeygear.eu', 4.6);
