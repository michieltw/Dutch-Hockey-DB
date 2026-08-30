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
