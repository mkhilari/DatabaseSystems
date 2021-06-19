CREATE TABLE Monke (
    MonkeID INT NOT NULL, 
    MonkeName VARCHAR(100), 
    MonkeDOB DATE, 
    MonkeColour ENUM('Black', 'Brown', "Grey"), 
    OwnerID INT, 
    ZooID INT,
    PRIMARY KEY (MonkeID), 
    FOREIGN KEY (OwnerID) REFERENCES Human(HumanID), 
    FOREIGN KEY (ZooID) REFERENCES Zoo(ZooID)
)

CREATE TABLE Human (
    HumanID INT NOT NULL, 
    HumaName VARCHAR(100), 
    HumanDOB DATE, 
    MotherID INT, 
    FatherID INT, 
    PRIMARY KEY (HumanID), 
    FOREIGN KEY (MotherID) REFERENCES Human(HumanID), 
    FOREIGN KEY (FatherID) REFERENCES Human(HumanID)
)

CREATE TABLE Zoo (
    ZooID INT NOT NULL, 
    ZooName VARCHAR(100), 
    ZooStartDate DATE, 
    ZooCity VARCHAR(100), 
    PRIMARY KEY (ZooID)
)