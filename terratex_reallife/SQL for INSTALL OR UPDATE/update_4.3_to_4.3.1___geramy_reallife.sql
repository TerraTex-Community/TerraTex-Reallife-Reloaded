ALTER TABLE `players` CHANGE `Passwort` `Passwort` VARCHAR(600) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL;

INSERT INTO data_fraktions_namen (ID, Name) VALUES (13, 'Shark Racers');

INSERT INTO data_fraktions_raenge (FrakID, RangID, Name) VALUES
(13 , 1, 'Fahranfänger'),
(13 , 2, 'Crasher'),
(13 , 3, 'Schrotti'),
(13 , 4, 'Tunner'),
(13 , 5, 'Undergrundracer'),
(13 , 6, 'Rennprofi');

INSERT INTO fraktionskasse (FrakID, Munition, Kasse) VALUES (13,0,0);

DROP TABLE dutycounter;
DROP TABLE view_duty_cops_date;