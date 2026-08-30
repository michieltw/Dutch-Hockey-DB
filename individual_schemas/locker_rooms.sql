-- 16. locker_rooms
CREATE TABLE locker_rooms (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LOCK',
    arena_id UUID NOT NULL REFERENCES arenas(id) ON DELETE CASCADE,
    room_number VARCHAR(50),
    capacity INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE locker_rooms ENABLE ROW LEVEL SECURITY;
