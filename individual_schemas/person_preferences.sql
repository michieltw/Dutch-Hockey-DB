-- person_preferences
CREATE TABLE person_preferences (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PREF',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    favourite_club_1_id UUID REFERENCES clubs(id) ON DELETE SET NULL,
    favourite_club_2_id UUID REFERENCES clubs(id) ON DELETE SET NULL,
    favourite_club_3_id UUID REFERENCES clubs(id) ON DELETE SET NULL,
    disliked_club_1_id UUID REFERENCES clubs(id) ON DELETE SET NULL,
    disliked_club_2_id UUID REFERENCES clubs(id) ON DELETE SET NULL,
    disliked_club_3_id UUID REFERENCES clubs(id) ON DELETE SET NULL,
    favourite_person_1_id UUID REFERENCES persons(id) ON DELETE SET NULL,
    favourite_person_2_id UUID REFERENCES persons(id) ON DELETE SET NULL,
    favourite_person_3_id UUID REFERENCES persons(id) ON DELETE SET NULL,
    disliked_person_1_id UUID REFERENCES persons(id) ON DELETE SET NULL,
    disliked_person_2_id UUID REFERENCES persons(id) ON DELETE SET NULL,
    disliked_person_3_id UUID REFERENCES persons(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE person_preferences ENABLE ROW LEVEL SECURITY;
