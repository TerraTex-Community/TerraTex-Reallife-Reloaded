ALTER TABLE user_gold ADD SkillBooster INT DEFAULT 0 NULL;

ALTER TABLE user ADD Gender VARCHAR(20) DEFAULT "anonym" NULL;

ALTER TABLE user_data ADD children VARCHAR(255) DEFAULT "{}" NULL;

CREATE TABLE data_crimes_categories
(
    ID INT PRIMARY KEY,
    CategorieName VARCHAR(255),
    `Order` INT DEFAULT 50
);

CREATE TABLE data_crimes_list
(
    ID INT PRIMARY KEY,
    CategorieID INT,
    Name VARCHAR(255),
    percentage INT DEFAULT 5,
    CONSTRAINT data_crimes_list_data_crimes_categories_ID_fk FOREIGN KEY (CategorieID) REFERENCES data_crimes_categories (ID) ON DELETE CASCADE ON UPDATE CASCADE
);