INSERT INTO `objects_businesses` (`ID`, `Name`, `Preis`, `Kasse`, `x`, `y`, `z`) VALUES (NULL, 'Tombupot Lotterie', '150000', '0', '1628.5', '-1171.5', '24.1');
UPDATE `objects_teleport_markers` SET `x` = '1317.09' WHERE `objects_teleport_markers`.`ID` = 40;
INSERT INTO `objects_sprunk` (`ID`, `X`, `Y`, `Z`, `Rot`, `Kommentar`) VALUES (NULL, '-19.084', '-57.047', '1003.547', '180', '24/7 Shop 2');

ALTER TABLE `objects_drivein` ADD `size` FLOAT NOT NULL DEFAULT '4' AFTER `z`;
INSERT INTO `objects_drivein` (`ID`, `x`, `y`, `z`, `size`, `typ`) VALUES (NULL, '1766.60546875', '-1892.126953125', '13', '1', 'pizza');

INSERT INTO data_crimes_categories (CategorieName, `Order`, hidden) VALUES ('Kleinverbrechen', 100, 0);
INSERT INTO data_crimes_categories (CategorieName, `Order`, hidden) VALUES ('Verbrechen im Straßenverkehr', 200, 0);
INSERT INTO data_crimes_categories (CategorieName, `Order`, hidden) VALUES ('Transporte / Events / Gruppenverbrechen', 300, 0);
INSERT INTO data_crimes_categories (CategorieName, `Order`, hidden) VALUES ('Illegaler Besitz / Handel', 400, 0);
INSERT INTO data_crimes_categories (CategorieName, `Order`, hidden) VALUES ('Gewaltverbrechen / Verbrechen mit Waffen', 500, 0);

INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (900, 'Aufenthalt außerhalb von Los Santos ohne Reisepass', 10, 2);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (900, 'Fehlender Personalausweis trotz Ausweispflicht in San Andreas (ab 25 Spielstunden)', 10, 2);

INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (100, 'Notrufmissbrauch', 10, 5);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (100, 'Sachbeschädigung', 10, 5);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (100, '(versuchter) Diebstahl', 15, 7);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (100, 'Ernstzunehmende Drohung', 10, 5);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (100, 'versuchte Erpressung', 8, 2);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (100, 'Behinderung von Beamtenarbeit', 8, 2);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (100, 'Erregung öfentlichen Ärgernisses', 4, 2);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (200, 'Illegales Straßenrennen', 20, 10);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (200, 'Flucht aus einer Verkehrskontrolle', 20, 10);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (200, 'Durchfahren einer Grenze ohne Maut zu Bezahlen', 25, 15);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (300, 'Fahren eines Waffenmaterialtransportes', 45, 20);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (300, 'Angriff auf einen Atommülltransporters', 45, 20);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (300, 'Angriff auf einen Geldtransporter', 45, 20);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (300, 'Angriff auf einen Alkatraztransport', 60, 30);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (300, 'Flucht aus einem Alkatraztransport', 100, 50);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (300, 'Geiselnahme', 45, 20);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (400, 'Drogenkonsum (mehr als 15g im Blut)', 20, 10);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (400, 'Drogenbesitz bis 50g', 15, 10);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (400, 'Drogenbesitz ab 50g', 30, 20);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (400, 'Drogenbesitz unbekannter Menge (weißes Päckchen)', 30, 20);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (400, 'Drogenverkauf', 40, 20);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (400, 'Waffenmaterialbesitz bis 100 Teile', 20, 10);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (400, 'Waffenmaterialbesitz ab 100 Teile', 40, 20);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (400, 'Waffenmaterialbesitz unbekannter Menge (klirrender Beutel)', 40, 20);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (400, 'Waffenverkauf', 40, 20);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (400, 'Illegale Werbung', 50, 25);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (500, 'Körperverletzung', 10, 5);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (500, 'Vorsätzliches Tragen von Schusswaffen in der Öffentlichkeit', 15, 5);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (500, 'Waffennutzung / Beschuss', 20, 10);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (500, 'Mord', 35, 15);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (500, 'Mehrfachmord', 45, 25);
INSERT INTO data_crimes_list (CategorieID, Name, Percentage, MinPercentage) VALUES (500, 'Terroranschlag', 80, 50);
