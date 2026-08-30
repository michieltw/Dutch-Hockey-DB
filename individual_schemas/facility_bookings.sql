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
