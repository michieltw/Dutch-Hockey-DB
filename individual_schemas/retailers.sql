-- 1. retailers
CREATE TABLE retailers (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'RETL',
    organization_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    return_policy TEXT,
    shipping_regions TEXT[],
    customer_service_email VARCHAR(255),
    rating NUMERIC(3, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE retailers ENABLE ROW LEVEL SECURITY;
