CREATE TABLE Users (
    ID INT PRIMARY KEY,
    Email VARCHAR(255) NOT NULL,
    Password VARCHAR(255) NOT NULL
);

CREATE TABLE Profiles (
    ID INT PRIMARY KEY,
    UserID INT,
    Prénom VARCHAR(255),
    Nom VARCHAR(255),
    Date_de_naissance DATE,
    Image_de_profil BLOB,
    Langue_des_signes VARCHAR(255),
    FOREIGN KEY (UserID) REFERENCES Users(ID)
);

CREATE TABLE Friends (
    ID INT PRIMARY KEY,
    UserID INT,
    FriendID INT,
    FOREIGN KEY (UserID) REFERENCES Users(ID),
    FOREIGN KEY (FriendID) REFERENCES Users(ID)
);

CREATE TABLE History (
    ID INT PRIMARY KEY,
    UserID INT,
    Action VARCHAR(255),
    Date DATE,
    FOREIGN KEY (UserID) REFERENCES Users(ID)
);

CREATE TABLE Subscriptions (
    ID INT PRIMARY KEY,
    UserID INT,
    Nom VARCHAR(255),
    Montant DECIMAL(10, 2),
    Date_de_début DATE,
    Date_de_fin DATE,
    FOREIGN KEY (UserID) REFERENCES Users(ID)
);

CREATE TABLE Notifications (
    ID INT PRIMARY KEY,
    UserID INT,
    Message TEXT,
    Date DATE,
    FOREIGN KEY (UserID) REFERENCES Users(ID)
);