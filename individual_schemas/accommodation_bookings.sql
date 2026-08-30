-- 37. accommodation_bookings
CREATE TABLE accommodation_bookings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ACBO',
    itinerary_id UUID NOT NULL REFERENCES travel_itineraries(id) ON DELETE CASCADE,
    hotel_name VARCHAR(255),
    check_in_date DATE,
    check_out_date DATE,
    rooms_booked INTEGER,
    cost NUMERIC(10, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE accommodation_bookings ENABLE ROW LEVEL SECURITY;
