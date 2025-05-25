-- Active: 1747442988800@@127.0.0.1@5432@conservation_db

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(150) NOT NULL
);

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(100) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(200)
);

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INTEGER REFERENCES rangers (ranger_id) ON DELETE CASCADE,
    species_id INTEGER REFERENCES species (species_id) ON DELETE CASCADE,
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(200) NOT NULL,
    notes TEXT NULL
);

INSERT INTO
    rangers (name, region)
VALUES (
        'Alice Green',
        'Northern Hills'
    ),
    ('Bob White', 'River Delta'),
    (
        'Carol King',
        'Mountain Range'
    );

INSERT INTO
    species (
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        'Snow Leopard',
        'Panthera uncia',
        '1775-01-01',
        'Endangered'
    ),
    (
        'Bengal Tiger',
        'Panthera tigris tigris',
        '1758-01-01',
        'Endangered'
    ),
    (
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Vulnerable'
    ),
    (
        'Asiatic Elephant',
        'Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    );

INSERT INTO
    sightings (
        species_id,
        ranger_id,
        location,
        sighting_time,
        notes
    )
VALUES (
        1,
        1,
        'Peak Ridge',
        '2024-05-10 07:45:00',
        'Camera trap image captured'
    ),
    (
        2,
        2,
        'Bankwood Area',
        '2024-05-12 16:20:00',
        'Juvenile seen'
    ),
    (
        3,
        3,
        'Bamboo Grove East',
        '2024-05-15 09:10:00',
        'Feeding observed'
    ),
    (
        1,
        2,
        'Snowfall Pass',
        '2024-05-18 18:30:00',
        null
    );

-- Problem 1
INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- Problem 2
SELECT count(DISTINCT species_id) AS unique_species_count
FROM sightings;

-- Problem 3
SELECT * FROM sightings WHERE location LIKE '%Pass%';

-- Problem 4
SELECT rangers.name, s.total_sightings
FROM (
        SELECT sightings.ranger_id, count(sightings.species_id) AS total_sightings
        FROM sightings
        GROUP BY
            sightings.ranger_id
    ) s
    JOIN rangers ON s.ranger_id = rangers.ranger_id;

-- Problem 5
SELECT common_name
FROM species
WHERE
    species_id NOT IN (
        SELECT species_id
        FROM sightings
    );

-- Problem 6
SELECT sp_sig.common_name, sp_sig.sighting_time, rangers.name
FROM (
        SELECT species.common_name, sig.sighting_time, sig.ranger_id
        FROM (
                SELECT
                    species_id, sighting_time, ranger_id
                FROM sightings
                ORDER BY sighting_time DESC
                LIMIT 2
            ) sig
            JOIN species ON species.species_id = sig.species_id
    ) sp_sig
    JOIN rangers ON rangers.ranger_id = sp_sig.ranger_id;

-- Problem 7
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    discovery_date < '1800-01-01';

-- Problem 8
SELECT
    sighting_id,
    CASE
        WHEN sighting_time::time < '12:00:00' THEN 'Morning'
        WHEN sighting_time::time >= '12:00:00'
        AND sighting_time::time <= '17:00:00' THEN 'Afternoon'
        WHEN sighting_time::time > '17:00:00' THEN 'Evening'
    END AS time_of_day
FROM sightings;

-- Problem 9
DELETE FROM rangers
WHERE
    ranger_id = (
        SELECT ranger_id
        FROM rangers
        WHERE
            ranger_id NOT IN (
                SELECT ranger_id
                FROM sightings
            )
    );