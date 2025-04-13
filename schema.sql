CREATE TABLE artists(
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(32) NOT NULL
);

CREATE TABLE genres(
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `genre` VARCHAR(32) NOT NULL
);

CREATE TABLE `keys`(
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `key_name` VARCHAR(10) NOT NULL
);

CREATE TABLE tracks(
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL,
    `year` YEAR NOT NULL,
    `duration` INT NOT NULL,
    `genre_id` INT,
    `popularity` INT NOT NULL,
    FOREIGN KEY (`genre_id`) REFERENCES `genres`(`id`)
);

CREATE TABLE artist_track(
    `artist_id` INT,
    `track_id` INT,
    PRIMARY KEY (`artist_id`,`track_id`),
    FOREIGN KEY (`artist_id`) REFERENCES `artists`(`id`),
    FOREIGN KEY(`track_id`) REFERENCES `tracks`(`id`)
);

CREATE TABLE track_attributes(
    `track_id` INT,
    `key_id` INT,
    `time_signature` FLOAT NOT NULL,
    `danceability` FLOAT NOT NULL,
    `energy` FLOAT NOT NULL,
    `loudness` FLOAT NOT NULL,
    `mode` TINYINT NOT NULL,
    `speechiness` FLOAT NOT NULL,
    `acousticness` FLOAT NOT NULL,
    `instrumentalness` FLOAT NOT NULL,
    `liveness` FLOAT NOT NULL,
    `valence` FLOAT NOT NULL,
    `tempo` FLOAT NOT NULL,
    PRIMARY KEY (`track_id`,`key_id`),
    FOREIGN KEY(`track_id`) REFERENCES `tracks`(`id`),
    FOREIGN KEY(`key_id`) REFERENCES `keys`(`id`)

);

CREATE INDEX idx_tracks_attributes_track ON track_attributes(`track_id`);

CREATE INDEX idx_tracks_attributes_key ON track_attributes(`key_id`);

CREATE INDEX idx_artists_id ON artists(`id`);

CREATE INDEX idx_tracks_id ON tracks(`id`);

CREATE INDEX idx_genres_id ON genres(`id`);

CREATE INDEX idx_tracks_genre_id ON tracks(`genre_id`);

CREATE INDEX idx_artist_track_artist_id ON artist_track(`artist_id`);

CREATE INDEX idx_artist_track_track_id ON artist_track(`track_id`);

CREATE INDEX idx_track_attributes_key_id ON track_attributes(`key_id`);

CREATE INDEX idx_track_attributes_track_id ON track_attributes(`track_id`);

CREATE INDEX idx_track_key ON track_attributes(`track_id`, `key_id`);


CREATE VIEW popular_tracks AS
SELECT t.id, t.name, t.popularity, g.genre
FROM tracks t
JOIN genres g ON t.genre_id = g.id
WHERE t.popularity > 50;



CREATE VIEW artist_contributions AS
SELECT a.name, COUNT(at.track_id) AS track_count
FROM artists a
JOIN artist_track at ON a.id = at.artist_id
GROUP BY a.name;


CREATE VIEW track_attribute_summary AS
SELECT t.name, ka.key_name, ta.danceability, ta.energy, ta.loudness
FROM tracks t
JOIN track_attributes ta ON t.id = ta.track_id
JOIN `keys` ka ON ta.key_id = ka.id;
