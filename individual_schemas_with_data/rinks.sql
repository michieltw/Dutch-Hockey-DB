-- 3. rinks (An arena can have multiple rinks)
CREATE TABLE rinks (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'RINK',
    arena_id UUID NOT NULL REFERENCES arenas(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    length_meters NUMERIC(5, 2),
    width_meters NUMERIC(5, 2),
    ice_type VARCHAR(50),
    is_indoor BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE rinks ENABLE ROW LEVEL SECURITY;

-- Data for rinks
-- Let's extract the arena UUIDs by modifying the arenas insert so we know their IDs, or we can use subqueries.
-- Alternatively, we can just insert with subqueries based on the arena names.
INSERT INTO rinks (id, arena_id, name, length_meters, width_meters, ice_type, is_indoor) VALUES
(gen_random_uuid(), (SELECT id FROM arenas WHERE name = 'Sportcentrum Kardinge'), 'Main Rink Kardinge', 60.00, 30.00, 'Artificial', TRUE),
(gen_random_uuid(), (SELECT id FROM arenas WHERE name = 'IJssportcentrum Stappegoor'), 'T10-Rink', 60.00, 30.00, 'Artificial', TRUE),
(gen_random_uuid(), (SELECT id FROM arenas WHERE name = 'Thialf'), 'IJshockeyhal Thialf', 60.00, 30.00, 'Artificial', TRUE),
(gen_random_uuid(), (SELECT id FROM arenas WHERE name = 'De Uithof'), 'Main Rink De Uithof', 60.00, 30.00, 'Artificial', TRUE),
(gen_random_uuid(), (SELECT id FROM arenas WHERE name = 'Glanerbrook'), 'Glanerbrook Rink', 60.00, 30.00, 'Artificial', TRUE),
(gen_random_uuid(), (SELECT id FROM arenas WHERE name = 'Triavium'), 'Ringbaan / Ice hockey rink', 60.00, 30.00, 'Artificial', TRUE),
(gen_random_uuid(), (SELECT id FROM arenas WHERE name = 'Patinoire de Liège'), 'Main Rink Liège', 60.00, 30.00, 'Artificial', TRUE),
(gen_random_uuid(), (SELECT id FROM arenas WHERE name = 'IJsbaan Leuven'), 'Leuven Rink', 60.00, 30.00, 'Artificial', TRUE),
(gen_random_uuid(), (SELECT id FROM arenas WHERE name = 'Sportoase Groot Schijn'), 'Groot Schijn Rink', 60.00, 30.00, 'Artificial', TRUE),
(gen_random_uuid(), (SELECT id FROM arenas WHERE name = 'Patinoire Kockelscheuer'), 'Main Rink Kockelscheuer', 60.00, 30.00, 'Artificial', TRUE);
