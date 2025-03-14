-- Drop existing tables if they exist
DROP TABLE IF EXISTS CharacterSubscriptionLink CASCADE;
DROP TABLE IF EXISTS CharacterNotification CASCADE;
DROP TABLE IF EXISTS CharacterSelfie CASCADE;
DROP TABLE IF EXISTS Notification CASCADE;
DROP TABLE IF EXISTS Character CASCADE;
DROP TABLE IF EXISTS PaymentMethod CASCADE;
DROP TABLE IF EXISTS Subscription CASCADE;
DROP TABLE IF EXISTS UserAccount CASCADE;

-- Create UserAccount table
CREATE TABLE UserAccount (
    UserID UUID PRIMARY KEY,
    Email TEXT NOT NULL,
    AccountCreationDate TIMESTAMP NOT NULL,
    Age INTEGER,
    Height FLOAT,
    Weight FLOAT
);

-- Create Subscription table
CREATE TABLE Subscription (
    SubscriptionID SERIAL PRIMARY KEY,
    UserID UUID REFERENCES UserAccount(UserID),
    SubscriptionStartDate TIMESTAMP NOT NULL,
    SubscriptionEndDate TIMESTAMP NOT NULL,
    SubscriptionAmount FLOAT NOT NULL
);

-- Create PaymentMethod table
CREATE TABLE PaymentMethod (
    PaymentMethodID SERIAL PRIMARY KEY,
    Type TEXT NOT NULL,
    Details JSON NOT NULL,
    UserID UUID REFERENCES UserAccount(UserID)
);

-- Create Character table
CREATE TABLE Character (
    CharacterID UUID PRIMARY KEY,
    UserID UUID REFERENCES UserAccount(UserID),
    Name TEXT NOT NULL,
    Realm TEXT NOT NULL,
    Race TEXT NOT NULL,
    Class TEXT NOT NULL,
    Strength FLOAT
);

-- Create CharacterSelfie table
CREATE TABLE CharacterSelfie (
    SelfieID SERIAL PRIMARY KEY,
    CharacterID UUID REFERENCES Character(CharacterID),
    ImageURL TEXT NOT NULL,
    CaptureDate TIMESTAMP NOT NULL
);

-- Create Notification table
CREATE TABLE Notification (
    NotificationID SERIAL PRIMARY KEY,
    ExpansionName TEXT NOT NULL,
    Details XML NOT NULL
);

-- Create CharacterNotification junction table for M:N relationship between Character and Notification
CREATE TABLE CharacterNotification (
    CharacterID UUID REFERENCES Character(CharacterID),
    NotificationID INTEGER REFERENCES Notification(NotificationID),
    PRIMARY KEY (CharacterID, NotificationID)
);

-- Create CharacterSubscriptionLink table for ternary relationship
CREATE TABLE CharacterSubscriptionLink (
    LinkID SERIAL PRIMARY KEY,
    UserID UUID REFERENCES UserAccount(UserID),
    SubscriptionID INTEGER REFERENCES Subscription(SubscriptionID),
    CharacterID UUID REFERENCES Character(CharacterID),
    CreationDate TIMESTAMP NOT NULL
);
