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
    Percentage INT DEFAULT 5,
    MinPercentage INT DEFAULT Null,
    CONSTRAINT data_crimes_list_data_crimes_categories_ID_fk FOREIGN KEY (CategorieID) REFERENCES data_crimes_categories (ID) ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE log_chat ENGINE=MyISAM;

CREATE TABLE log_kills
(
    ID INT PRIMARY KEY,
    Attacker VARCHAR(255),
    Target VARCHAR(255),
    AttackerFaction INT,
    TargetFaction INT,
    BlacklistOrWantedkill INT DEFAULT 0,
    WeaponID INT DEFAULT 0,
    Timestamp TIMESTAMP DEFAULT current_timestamp
);

CREATE TABLE user_crimes
(
    ID INT PRIMARY KEY,
    Nickname VARCHAR(255),
    CrimeID INT,
    CrimePercentage INT,
    AdditionalReason TEXT,
    Timestamp TIMESTAMP DEFAULT current_timestamp,
    CONSTRAINT user_crimes_user_Nickname_fk FOREIGN KEY (Nickname) REFERENCES user (Nickname) ON DELETE CASCADE ON UPDATE CASCADE
);