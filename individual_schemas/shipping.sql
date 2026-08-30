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
