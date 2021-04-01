CREATE TABLE User (
UserID BIGINT, 
Nickname VARCHAR(50), 
AvatarPhotoFilename VARCHAR(200), 
MaturityLevel ENUM('G', 'PG', 'M', 'MA 15+', 'R 18+')
)