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
