# Design Document

By Dendy Kurniari Agman
edx id: dendy_kurniary

Video overview: <https://www.youtube.com/watch?v=rU_9FgZHEk4>

## Dataset Source
15,000 Music Tracks - 19 Genres (w/ Spotify Data)

<https://www.kaggle.com/datasets/thebumpkin/10400-classic-hits-10-genres-1923-to-2023>

## Scope

The purpose of this database is to store, organize, and retrieve data related to classic hit songs. This includes data on artists, tracks, genres, and the musical attributes of each track such as danceability, energy, tempo, etc. The database is designed to make it easy to query and analyze songs, artists, and genres, while also allowing users to study the musical attributes of tracks.

The entities included in the scope of the database are:
Artists: Information about music artists. It includes attibutes such as ID, and artist name
Genres: Types of music genres.
Keys: Musical keys used in tracks.
Tracks: Details about individual songs like the track name, The year the track was released., the duration of the track in milliseconds, genre that can be accessed by genre id's from genres table and the track popularity.
Artist-Track Relationships: Relationships between artists and tracks they are associated with.
Track Attributes: Musical attributes of tracks such as time_signature (The musical time signature of the track e.g., 4/4), danceability (A measure of how suitable the track is for dancing, ranging from 0.0 to 1.0.), energy (A measure of the intensity and activity of the track, ranging from 0.0 to 1.0.), key that used on the track that can be explained more by accessing keys table, loudness (measured by decibels) and mode (The modality of the track, typically major (1) or minor (0).)

Even so, there are some tracks information that's outside this database scope such as if the songs if from albums or singles, this track album/singles cover art metadata, tracks lyrics, and the audio files of the track itself.

## Functional Requirements

* Add, update, delete and retrieve details about artists, tracks, genres, and their attributes.
* Search for tracks based on their popularity.
* View how many tracks each artist has contributed.
* View a summary of track attributes, including key musical features.

## Representation

### Entities

Artists:

* id: This is the unique identifier for each artist, defined as an INT with AUTO_INCREMENT, so each artist will be assigned a new unique ID automatically when they are added. It's the Primary Key (PRIMARY KEY) for the table to ensure each artist is distinct.

* name: This represents the name of the artist. It's a VARCHAR(32) because artist names typically don't exceed 32 characters. The column is marked as NOT NULL to ensure that every artist must have a name when added to the database.

Genres:
* id: This is the unique identifier for each genre, defined as an INT with AUTO_INCREMENT and serves as the Primary Key (PRIMARY KEY). Each genre will be assigned a unique ID automatically.

* genre: The genre of the track, represented as VARCHAR(32), which allows enough space for different music genres (e.g., "Pop", "Alternative Rock"). This field is NOT NULL to ensure that every track is categorized by genre.

Keys:
* id: An auto-incrementing integer that uniquely identifies each musical key. It's the Primary Key (PRIMARY KEY) for the table to ensure each key is distinct.

* key_name: The name of the musical key. Limited to 10 characters as musical keys are typically short. The column is marked as NOT NULL to ensure that the key_name is not empty.

Tracks:
* id: The unique identifier for each track. This is an INTEGER and serves as the PRIMARY KEY, with AUTO_INCREMENT to ensure uniqueness.

* name: The name of the track. The data type is VARCHAR(50) because track names are variable-length text but should not exceed 50 characters. This field cannot be empty (NOT NULL).

* year: The release year of the track. The data type is YEAR to ensure it captures valid years. This field is required, so it cannot be empty (NOT NULL).

* duration: The length of the track in milliseconds. Since durations are represented as whole numbers, the data type is INT. This field cannot be left blank (NOT NULL).

* genre_id: A foreign key (INT) linking the track to its genre. It refers to the id in the genres table (FOREIGN KEY (genre_id) REFERENCES genres(id)).

* popularity: Represents how popular the track is, its on a scale from 0 to 100. The data type is INT to represent whole numbers, and it cannot be empty (NOT NULL).

Artist-Track Relationships:
* artist_id: Refers to the artist who performed the track. This is an INTEGER and serves as a foreign key to the artists table (FOREIGN KEY (artist_id) REFERENCES artists(id)).

* track_id: Refers to the track the artist contributed to. This is an INTEGER and serves as a foreign key to the tracks table (FOREIGN KEY (track_id) REFERENCES tracks(id)).
PRIMARY KEY (artist_id, track_id): This table uses a composite primary key combining artist_id and track_id to represent the many-to-many relationship between artists and tracks.

Track Attributes:
* track_id: The ID of the track these attributes belong to. This is an INTEGER and acts as a foreign key to the tracks table (FOREIGN KEY (track_id) REFERENCES tracks(id)).

* key_id: The musical key of the track. This is an INTEGER and serves as a foreign key to the keys table (FOREIGN KEY (key_id) REFERENCES keys(id)).

* time_signature: The time signature of the track (e.g., 4/4, 3/4). This is a FLOAT to allow for fractional values.

* danceability: A measure of how suitable a track is for dancing. The data type is FLOAT because this value ranges from 0.0 to 1.0. It cannot be empty (NOT NULL).

* energy: A measure of the intensity and activity of the track. The data type is FLOAT to allow for a wide range of values, and it cannot be empty (NOT NULL).

* loudness: The loudness of the track in decibels. This field is a FLOAT because decibels are measured as decimals, and it cannot be empty (NOT NULL).
mode: Whether the track is in a major or minor key. This field is a TINYINT (0 or 1) and represents major or minor, respectively. It cannot be left blank (NOT NULL).
speechiness: Represents the amount of spoken words in the track. It is a FLOAT to represent a continuous range of values. It cannot be empty (NOT NULL).
acousticness: A measure of how acoustic the track is. This field is a FLOAT and cannot be empty (NOT NULL).
instrumentalness: Represents the likelihood of the track being instrumental (no vocals). The data type is FLOAT and it cannot be empty (NOT NULL).
liveness: A measure of how likely the track is a live performance. This is a FLOAT and cannot be left empty (NOT NULL).
valence: Represents the musical positivity of the track. The data type is FLOAT, and it cannot be empty (NOT NULL).
tempo: The tempo of the track in beats per minute. The data type is FLOAT and is required (NOT NULL).
PRIMARY KEY (track_id, key_id): The primary key is a composite of track_id and key_id, ensuring each track’s attributes are unique to that key.

Attribute Choices:

Data Types: Chosen to reflect the nature of the data (e.g., VARCHAR for names, INT for IDs, FLOAT for numerical attributes).
Constraints: Ensures data integrity and consistency (e.g., NOT NULL, PRIMARY KEY, FOREIGN KEY).


### Relationships

![alt text](<ER diagram classic hits.png>)

## Optimizations

Indexes
    Indexes on Foreign Keys: Improve query performance for joins.
        idx_tracks_genre_id on tracks(genre_id)
        idx_artist_track_artist_id on artist_track(artist_id)
        idx_artist_track_track_id on artist_track(track_id)
        idx_track_attributes_key_id on track_attributes(key_id)
        idx_track_attributes_track_id on track_attributes(track_id)

Views
    popular_tracks View: Provides a convenient way to query tracks with popularity over 50.
    artist_contributions View: Summarizes the number of tracks contributed by each artist.
    track_attribute_summary View: Aggregates key track attributes for quick reference.

## Limitations
Limited Artist Information: Only basic details about artists are stored (i.e., name), excluding biographies or other personal information.

Scalability: As the database grows, complex queries involving multiple joins might impact performance if not properly indexed or optimized.

Extensibility: Adding new attributes or entities (e.g., albums, recording sessions) may require significant schema changes.

Key Table Name Confusion: the usage of word keys for musical key on this database may causes problems since we need to use (``) to encase the table name on the query in order to run properly
