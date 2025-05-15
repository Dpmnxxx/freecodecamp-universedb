camper: /project$ psql --username=freecodecamp --dbname=postgres
Border style is 2.
Pager usage is off.
psql (12.17 (Ubuntu 12.17-1.pgdg22.04+1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
Type "help" for help.

postgres=> CREATE DATABASE universe;
CREATE DATABASE
postgres=> \c universe;
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
You are now connected to database "universe" as user "freecodecamp".
universe=> CREATE TABLE galaxy(galaxy_id SERIAL PRIMARY KEY NOT NULL, speed INT, description TEXT);
CREATE TABLE
universe=> CREATE TABLE star (star_id SERIAL PRIMARY KEY NOT NULL, radius INT NOT NULL, color VARCHAR(255) NOT NULL, name VARCHAR(255) NOT NULL, galaxy_id INT, CONSTRAINT fk_galaxy FOREIGN KEY(galaxy_id) REFERENCES galaxy(galaxy_id) );
CREATE TABLE
universe=> ALTER TABLE galaxy ADD COLUMN name VARCHAR(255) NOT NULL;
ALTER TABLE
universe=> CREATE TABLE planet(planet_id SERIAL PRIMARY KEY NOT NULL, name VARCHAR(255) NOT NULL, amount_of_people NUMERIC,time_travel DEFAULT(false) NOT NULL, star_id INT NOT NULL, CONSTRAINT fk_star FOREIGN KEY(star_id) REFERENCES star(star_id) );
ERROR:  syntax error at or near "DEFAULT"
LINE 1: ...5) NOT NULL, amount_of_people NUMERIC,time_travel DEFAULT(fa...
                                                             ^
universe=> CREATE TABLE planet(planet_id SERIAL PRIMARY KEY NOT NULL, name VARCHAR(255) NOT NULL, amount_of_people NUMERIC,time_travel boolean DEFAULT(false) NOT NUL
L, star_id INT NOT NULL, CONSTRAINT fk_star FOREIGN KEY(star_id) REFERENCES star(star_id) );
CREATE TABLE
universe=> \d planet;
                                             Table "public.planet"
+------------------+------------------------+-----------+----------+-------------------------------------------+
|      Column      |          Type          | Collation | Nullable |                  Default                  |
+------------------+------------------------+-----------+----------+-------------------------------------------+
| planet_id        | integer                |           | not null | nextval('planet_planet_id_seq'::regclass) |
| name             | character varying(255) |           | not null |                                           |
| amount_of_people | numeric                |           |          |                                           |
| time_travel      | boolean                |           | not null | false                                     |
| star_id          | integer                |           | not null |                                           |
+------------------+------------------------+-----------+----------+-------------------------------------------+
Indexes:
    "planet_pkey" PRIMARY KEY, btree (planet_id)
Foreign-key constraints:
    "fk_star" FOREIGN KEY (star_id) REFERENCES star(star_id)

universe=> CREATE TABLE moon (moon_id SERIAL PRIMARY KEY NOT NULL, name VARCHAR(255) NOT NULL, name_code VARCHAR(255) UNIQUE, has_water boolean NOT NULL, planet_id INT NOT NULL, CONSTRAINT fk_planet FOREIGN KEY (planet_id) REFERENCES planet(planet_id) ); 
CREATE TABLE
universe=> \d moon;
                                         Table "public.moon"
+-----------+------------------------+-----------+----------+---------------------------------------+
|  Column   |          Type          | Collation | Nullable |                Default                |
+-----------+------------------------+-----------+----------+---------------------------------------+
| moon_id   | integer                |           | not null | nextval('moon_moon_id_seq'::regclass) |
| name      | character varying(255) |           | not null |                                       |
| name_code | character varying(255) |           |          |                                       |
| has_water | boolean                |           | not null |                                       |
| planet_id | integer                |           | not null |                                       |
+-----------+------------------------+-----------+----------+---------------------------------------+
Indexes:
    "moon_pkey" PRIMARY KEY, btree (moon_id)
    "moon_name_code_key" UNIQUE CONSTRAINT, btree (name_code)
Foreign-key constraints:
    "fk_planet" FOREIGN KEY (planet_id) REFERENCES planet(planet_id)

universe=> ALTER TABLE moon DROP COLUMN name_code;
ALTER TABLE
universe=> ALTER TABLE moon ADD COLUMN name_code VARCHAR(255) UNIQUE NOT NULL;
ALTER TABLE
universe=> \d moon;
                                         Table "public.moon"
+-----------+------------------------+-----------+----------+---------------------------------------+
|  Column   |          Type          | Collation | Nullable |                Default                |
+-----------+------------------------+-----------+----------+---------------------------------------+
| moon_id   | integer                |           | not null | nextval('moon_moon_id_seq'::regclass) |
| name      | character varying(255) |           | not null |                                       |
| has_water | boolean                |           | not null |                                       |
| planet_id | integer                |           | not null |                                       |
| name_code | character varying(255) |           | not null |                                       |
+-----------+------------------------+-----------+----------+---------------------------------------+
Indexes:
    "moon_pkey" PRIMARY KEY, btree (moon_id)
    "moon_name_code_key" UNIQUE CONSTRAINT, btree (name_code)
Foreign-key constraints:
    "fk_planet" FOREIGN KEY (planet_id) REFERENCES planet(planet_id)

universe=> CREATE TABLE blackhole(blackhole_id SERIAL PRIMARY KEY NOT NULL, gravity INT, galaxy_id INT, wormhole boolean DEFAULT(false) NOT NULL);
CREATE TABLE
universe=> \d 
                        List of relations
+--------+----------------------------+----------+--------------+
| Schema |            Name            |   Type   |    Owner     |
+--------+----------------------------+----------+--------------+
| public | blackhole                  | table    | freecodecamp |
| public | blackhole_blackhole_id_seq | sequence | freecodecamp |
| public | galaxy                     | table    | freecodecamp |
| public | galaxy_galaxy_id_seq       | sequence | freecodecamp |
| public | moon                       | table    | freecodecamp |
| public | moon_moon_id_seq           | sequence | freecodecamp |
| public | planet                     | table    | freecodecamp |
| public | planet_planet_id_seq       | sequence | freecodecamp |
| public | star                       | table    | freecodecamp |
| public | star_star_id_seq           | sequence | freecodecamp |
+--------+----------------------------+----------+--------------+
(10 rows)

universe=> \d galaxy
                                           Table "public.galaxy"
+-------------+------------------------+-----------+----------+-------------------------------------------+
|   Column    |          Type          | Collation | Nullable |                  Default                  |
+-------------+------------------------+-----------+----------+-------------------------------------------+
| galaxy_id   | integer                |           | not null | nextval('galaxy_galaxy_id_seq'::regclass) |
| speed       | integer                |           |          |                                           |
| description | text                   |           |          |                                           |
| name        | character varying(255) |           | not null |                                           |
+-------------+------------------------+-----------+----------+-------------------------------------------+
Indexes:
    "galaxy_pkey" PRIMARY KEY, btree (galaxy_id)
Referenced by:
    TABLE "star" CONSTRAINT "fk_galaxy" FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)

universe=> INSERT INTO galaxy(name) VALUES('andromeda');
INSERT 0 1
universe=> SELECT * FROM galaxy;
+-----------+-------+-------------+-----------+
| galaxy_id | speed | description |   name    |
+-----------+-------+-------------+-----------+
|         1 |       |             | andromeda |
+-----------+-------+-------------+-----------+
(1 row)

universe=> INSERT INTO galaxy(name) VALUES('cigar');
INSERT 0 1
universe=> INSERT INTO galaxy(name) VALUES('milkyway');
INSERT 0 1
universe=> INSERT INTO galaxy(name) VALUES('blackeye');
INSERT 0 1
universe=> INSERT INTO galaxy(name) VALUES('centauri');
INSERT 0 1
universe=> INSERT INTO galaxy(name) VALUES('condor');
INSERT 0 1
universe=> SELECT * FROM galaxy;
+-----------+-------+-------------+-----------+
| galaxy_id | speed | description |   name    |
+-----------+-------+-------------+-----------+
|         1 |       |             | andromeda |
|         2 |       |             | cigar     |
|         3 |       |             | milkyway  |
|         4 |       |             | blackeye  |
|         5 |       |             | centauri  |
|         6 |       |             | condor    |
+-----------+-------+-------------+-----------+
(6 rows)

universe=> INSERT INTO star(radius, color, name, galaxy_id) VALUES(1234, 'red', 'beattlejuice', 1);
INSERT 0 1
universe=> INSERT INTO star(radius, color, name, galaxy_id) VALUES(1234, 'red', 'winona',2);
INSERT 0 1
universe=> INSERT INTO star(radius, color, name, galaxy_id) VALUES(1234, 'red', 'redfield', 3);
INSERT 0 1
universe=> INSERT INTO star(radius, color, name, galaxy_id) VALUES(1234, 'red', 'jane', 3);
INSERT 0 1
universe=> INSERT INTO star(radius, color, name, galaxy_id) VALUES(1234, 'red', 'claire', 4);
INSERT 0 1
universe=> INSERT INTO star(radius, color, name, galaxy_id) VALUES(1234, 'red', 'wong', 5);
INSERT 0 1
universe=> SELECT * FROM star;
+---------+--------+-------+--------------+-----------+
| star_id | radius | color |     name     | galaxy_id |
+---------+--------+-------+--------------+-----------+
|       1 |   1234 | red   | beattlejuice |         1 |
|       2 |   1234 | red   | winona       |         2 |
|       3 |   1234 | red   | redfield     |         3 |
|       4 |   1234 | red   | jane         |         3 |
|       5 |   1234 | red   | claire       |         4 |
|       6 |   1234 | red   | wong         |         5 |
+---------+--------+-------+--------------+-----------+
(6 rows)

universe=> INSERT INTO planet(name, star_id,) VALUES('earth', 1);
ERROR:  syntax error at or near ")"
LINE 1: INSERT INTO planet(name, star_id,) VALUES('earth', 1);
                                         ^
universe=> INSERT INTO planet(name, star_id) VALUES('earth', 1);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('mars', 1);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('neptune', 1);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('jupyter', 1);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('uranus', 1);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('venus', 1);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('saturn', 1);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('mercury', 1);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('pluto', 1);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('cholo', 1);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('keto', 2);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('feto', 2);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id) VALUES('beto', 3);
INSERT 0 1
universe=> SELECT * FROM planet;
+-----------+---------+------------------+-------------+---------+
| planet_id |  name   | amount_of_people | time_travel | star_id |
+-----------+---------+------------------+-------------+---------+
|         1 | earth   |                  | f           |       1 |
|         2 | mars    |                  | f           |       1 |
|         3 | neptune |                  | f           |       1 |
|         4 | jupyter |                  | f           |       1 |
|         5 | uranus  |                  | f           |       1 |
|         6 | venus   |                  | f           |       1 |
|         7 | saturn  |                  | f           |       1 |
|         8 | mercury |                  | f           |       1 |
|         9 | pluto   |                  | f           |       1 |
|        10 | cholo   |                  | f           |       1 |
|        11 | keto    |                  | f           |       2 |
|        12 | feto    |                  | f           |       2 |
|        13 | beto    |                  | f           |       3 |
+-----------+---------+------------------+-------------+---------+
(13 rows)

universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon1', true, 2, 'm1');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon2', true, 3, 'm2');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon2', true, 3, 'm3');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon2', true, 3, 'm4');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon2', true, 3, 'm5');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon2', true, 3, 'm6');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon2', true, 3, 'm7');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon2', true, 3, 'm8');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon2', true, 3, 'm9');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon2', true, 3, 'm10');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon2', true, 3, 'm11');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon2', true, 3, 'm12');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon2', true, 3, 'm13');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon2', true, 3, 'm14');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon2', true, 3, 'm15');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon2', true, 3, 'm16');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon2', true, 3, 'm17');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon2', true, 3, 'm18');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon2', true, 3, 'm19');
INSERT 0 1
universe=> INSERT INTO moon(name, has_water, planet_id, name_code) VALUES('moon2', true, 3, 'm20');
INSERT 0 1
universe=> SELECT * FROM moon;
+---------+-------+-----------+-----------+-----------+
| moon_id | name  | has_water | planet_id | name_code |
+---------+-------+-----------+-----------+-----------+
|       1 | moon1 | t         |         2 | m1        |
|       2 | moon2 | t         |         3 | m2        |
|       3 | moon2 | t         |         3 | m3        |
|       4 | moon2 | t         |         3 | m4        |
|       5 | moon2 | t         |         3 | m5        |
|       6 | moon2 | t         |         3 | m6        |
|       7 | moon2 | t         |         3 | m7        |
|       8 | moon2 | t         |         3 | m8        |
|       9 | moon2 | t         |         3 | m9        |
|      10 | moon2 | t         |         3 | m10       |
|      11 | moon2 | t         |         3 | m11       |
|      12 | moon2 | t         |         3 | m12       |
|      13 | moon2 | t         |         3 | m13       |
|      14 | moon2 | t         |         3 | m14       |
|      15 | moon2 | t         |         3 | m15       |
|      16 | moon2 | t         |         3 | m16       |
|      17 | moon2 | t         |         3 | m17       |
|      18 | moon2 | t         |         3 | m18       |
|      19 | moon2 | t         |         3 | m19       |
|      20 | moon2 | t         |         3 | m20       |
+---------+-------+-----------+-----------+-----------+
(20 rows)

universe=> ALTER TABLE galaxy ADD COLUMN rotation_speed INT NOT NULL DEFAULT(100);
ALTER TABLE
universe=> ALTER TABLE blackhole ADD COLUMN name VARCHAR(255) NOT NULL UNIQUE;
ALTER TABLE
universe=> INSERT INTO blackhole(name) VALUES('bh1');
INSERT 0 1
universe=> INSERT INTO blackhole(name) VALUES('bh2');
INSERT 0 1
universe=> INSERT INTO blackhole(name) VALUES('bh3');
INSERT 0 1
universe=> ALTER TABLE galaxy ADD CONSTRAINT name_unique UNIQUE (name);
ALTER TABLE
universe=> ALTER TABLE star ADD CONSTRAINT name_unique_star UNIQUE (name);
ALTER TABLE
universe=> ALTER TABLE planet ADD CONSTRAINT name_unique_planet UNIQUE (name);
ALTER TABLE
universe=> 
