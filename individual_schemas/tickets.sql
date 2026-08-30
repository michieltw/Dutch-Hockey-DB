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
