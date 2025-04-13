
INSERT INTO artists(name) VALUES ('Green Day'), ('Janet Jackson'), ('Michael Jackson'), ('Paul McCartney'), ('System Of A Down');


INSERT INTO genres(genre) VALUES ('Alt. Rock'), ('Metal'), ('Pop'), ('Rock');


INSERT IGNORE INTO `keys` (id, key_name)
VALUES (1, 'C'),
       (2, 'C#'),
       (3, 'D'),
       (4, 'D#'),
       (5, 'E'),
       (6, 'F'),
       (7, 'F#'),
       (8, 'G'),
       (9, 'G#'),
       (10, 'A'),
       (11, 'A#'),
       (12, 'B');


INSERT INTO tracks(name, year, duration, genre_id, popularity)
VALUES('21 Guns', 2009, 321093, (SELECT id FROM genres WHERE genre = 'Alt. Rock'), 75),
('American Idiot', 2004, 176346, (SELECT id FROM genres WHERE genre = 'Alt. Rock'), 80),
('Chop Suey!', 2001, 210240, (SELECT id FROM genres WHERE genre = 'Metal'), 84),
('Toxicity', 2001, 218933, (SELECT id FROM genres WHERE genre = 'Metal'), 83),
('Scream', 1995, 283000, (SELECT id FROM genres WHERE genre = 'Pop'), 77),
('The Girl Is Mine', 1983, 222000, (SELECT id FROM genres WHERE genre = 'Pop'), 66),
('Smooth Criminal', 1989, 222000, (SELECT id FROM genres WHERE genre = 'Pop'), 75);


INSERT INTO artist_track(artist_id, track_id)
    VALUES ((SELECT id FROM artists WHERE name = 'Green Day'), (SELECT id FROM tracks WHERE name = 'American Idiot')),
    ((SELECT id FROM artists WHERE name = 'Green Day'), (SELECT id FROM tracks WHERE name = '21 Guns')),
    ((SELECT id FROM artists WHERE name = 'System Of A Down'), (SELECT id FROM tracks WHERE name = 'Toxicity')),
    ((SELECT id FROM artists WHERE name = 'System Of A Down'), (SELECT id FROM tracks WHERE name = 'Chop Suey!')),
    ((SELECT id FROM artists WHERE name = 'Michael Jackson'), (SELECT id FROM tracks WHERE name = 'Scream')),
    ((SELECT id FROM artists WHERE name = 'Janet Jackson'), (SELECT id FROM tracks WHERE name = 'Scream')),
    ((SELECT id FROM artists WHERE name = 'Michael Jackson'), (SELECT id FROM tracks WHERE name = 'The Girl Is Mine')),
    ((SELECT id FROM artists WHERE name = 'Paul McCartney'), (SELECT id FROM tracks WHERE name = 'The Girl Is Mine')),
    ((SELECT id FROM artists WHERE name = 'Michael Jackson'), (SELECT id FROM tracks WHERE name = 'Smooth Criminal'));

INSERT INTO track_attributes (track_id, key_id, time_signature, danceability, energy, loudness, mode, speechiness, acousticness, instrumentalness, liveness, valence, tempo)
VALUES
((SELECT id FROM tracks WHERE name = '21 Guns'), (SELECT id FROM `keys` WHERE key_name = 'F'), 4, 0.268, 0.742, -4.939, 1, 0.0355, 0.0518, 0, 0.626, 0.416, 159.779),
((SELECT id FROM tracks WHERE name = 'American Idiot'), (SELECT id FROM `keys` WHERE key_name = 'G'), 4, 0.38, 0.988, -2.042, 1, 0.0639, 2.64E-05, 0.0000786, 0.368, 0.769, 186.113),
((SELECT id FROM tracks WHERE name = 'Chop Suey!'), (SELECT id FROM `keys` WHERE key_name = 'D'), 4, 0.417, 0.934, -3.908, 0, 0.119, 0.000278, 0.0015, 0.132, 0.287, 127.066),
((SELECT id FROM tracks WHERE name = 'Toxicity'), (SELECT id FROM `keys` WHERE key_name = 'E'), 3, 0.413, 0.873, -4.151, 1, 0.0536, 0.000264, 0.00249, 0.204, 0.48, 116.68),
((SELECT id FROM tracks WHERE name = 'Scream'), (SELECT id FROM `keys` WHERE key_name = 'C'), 4, 0.772, 0.685, -6.849, 1, 0.0696, 0.019, 0.0000896, 0.131, 0.501, 130.039),
((SELECT id FROM tracks WHERE name = 'The Girl Is Mine'), (SELECT id FROM `keys` WHERE key_name = 'A'), 4, 0.681, 0.527, -10.422, 1, 0.0561, 0.225, 0, 0.0989, 0.707, 81.425),
((SELECT id FROM tracks WHERE name = 'Smooth Criminal'), (SELECT id FROM `keys` WHERE key_name = 'C#'), 4, 0.653, 0.964, -4.26, 0, 0.0578, 0.00316, 0.0051, 0.144, 0.872, 126.928);

-- get track and genres--
SELECT t.name, g.genre
FROM tracks t
JOIN genres g ON t.genre_id = g.id;

--update track genre--

UPDATE tracks
SET genre_id = (SELECT id FROM genres WHERE genre = 'Rock')
WHERE name = '21 Guns';

-- update and deleting track attributes--

UPDATE tracks
SET popularity = 85
WHERE name = 'American Idiot';

UPDATE track_attributes
SET `danceability` = 0.8, `energy` = 0.7
WHERE track_id = (SELECT id FROM tracks WHERE name = 'Chop Suey!')
AND key_id = (SELECT id FROM `keys` WHERE key_name = 'D');

DELETE FROM track_attributes
WHERE track_id = (SELECT id FROM tracks WHERE name = 'Toxicity');

DELETE FROM artist_track
WHERE artist_id = (SELECT id FROM artists WHERE name = 'Michael Jackson')
AND track_id = (SELECT id FROM tracks WHERE name = 'Smooth Criminal');
