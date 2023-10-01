CREATE TABLE Users (
  Id SERIAL PRIMARY KEY,
  "42Id" INTEGER UNIQUE,
  DisplayName VARCHAR(50) UNIQUE,
  AvatarUrl TEXT,
  IsTwoFactorEnabled BOOLEAN,
  Wins INTEGER,
  Losses INTEGER
);

select * from Users

INSERT INTO Users ("42Id", DisplayName, AvatarUrl, IsTwoFactorEnabled, Wins, Losses)
VALUES
(123, 'user1', 'http://example.com/user1.png', TRUE, 5, 3),
(456, 'user2', 'http://example.com/user2.png', FALSE, 7, 2),
(789, 'user3', 'http://example.com/user3.png', TRUE, 2, 8),
(101112, 'user4', 'http://example.com/user4.png', FALSE, 4, 6),
(131415, 'user5', 'http://example.com/user5.png', TRUE, 6, 4),
(161718, 'user6', 'http://example.com/user6.png', FALSE, 9, 1),
(192021, 'user7', 'http://example.com/user7.png', TRUE, 3, 7),
(222324, 'user8', 'http://example.com/user8.png', FALSE, 8, 2),
(252627, 'user9', 'http://example.com/user9.png', TRUE, 4, 6),
(282930, 'user10', 'http://example.com/user10.png', FALSE, 2, 8);

CREATE TABLE UserFriends (
  Id SERIAL PRIMARY KEY,
  UserId INTEGER,
  FriendId INTEGER,
  FOREIGN KEY (UserId) REFERENCES User (Id),
  FOREIGN KEY (FriendId) REFERENCES User (Id),
  CONSTRAINT unique_user_friend_pair UNIQUE (UserId, FriendId)
);

select * from UserFriends

INSERT INTO UserFriends (UserId, FriendId)
VALUES
  (1, 3),
  (1, 3),
  (2, 3),
  (3, 4),
  (4, 2);

CREATE TABLE GameHistory (
  Id SERIAL PRIMARY KEY,
  User1Id INTEGER,
  User2Id INTEGER,
  User1Point INTEGER,
  User2Point INTEGER,
  FOREIGN KEY (User1Id) REFERENCES Users (Id),
  FOREIGN KEY (User2Id) REFERENCES Users (Id)
);

select * from GameHistory

INSERT INTO GameHistory (User1Id, User2Id, User1Point, User2Point)
VALUES
  (1, 2, 10, 5),
  (1, 3, 8, 12),
  (2, 3, 6, 8),
  (3, 4, 2, 0),
  (4, 2, 4, 6);

CREATE TYPE ChannelTypeEnum AS ENUM ('1', '2', '3');

CREATE TABLE Channels (
  Id SERIAL PRIMARY KEY,
  ChannelType ChannelTypeEnum,
  OwnerId INTEGER,
  FOREIGN KEY (OwnerId) REFERENCES Users (Id)
);

select * from Channels

ALTER TABLE Channels ADD COLUMN ChannelName VARCHAR(50) UNIQUE;

INSERT INTO Channels (ChannelType, OwnerId, ChannelName)
VALUES
  ('1', 1, 'Channel 1'),
  ('2', 2, 'Channel 2'),
  ('3', 3, 'Channel 3'),
  ('1', 4, 'Channel 4'),
  ('2', 2, 'Channel 5');

CREATE TABLE ChannelMessages (
  Id SERIAL PRIMARY KEY,
  ChannelId integer,
  UserId INTEGER,
  Message TEXT,
  PublishDate timestamp,
  FOREIGN KEY (ChannelId) REFERENCES Channels (Id),
  FOREIGN KEY (UserId) references Users (Id)
);

select * from ChannelMessages

INSERT INTO ChannelMessages (ChannelId, UserId, Message, PublishDate)
VALUES
  (1, 1, 'Hello, everyone!', '2023-05-01 12:00:00'),
  (2, 2, 'How is everyone doing?', '2023-05-02 10:30:00'),
  (1, 3, 'I have a question about the project.', '2023-05-03 14:15:00'),
  (3, 4, 'Did anyone else experience an issue with the server?', '2023-05-04 16:00:00'),
  (2, 5, 'I have some exciting news to share!', '2023-05-05 09:45:00');

CREATE TABLE ChannelAdmins (
  Id SERIAL PRIMARY KEY,
  ChannelId INTEGER REFERENCES Channels(Id),
  AdminId INTEGER REFERENCES Users(Id),
  CONSTRAINT unique_channel_admin_pair UNIQUE (ChannelId, AdminId)
);

INSERT INTO ChannelAdmins (ChannelId, AdminId)
VALUES
  (1, 2),
  (1, 3),
  (2, 4),
  (3, 5),
  (3, 6),
  (4, 1),
  (4, 7);

select * from ChannelAdmins

CREATE TABLE ChannelUsers (
  Id SERIAL PRIMARY KEY,
  ChannelId INTEGER REFERENCES Channels(Id),
  UserId INTEGER REFERENCES Users(Id),
  CONSTRAINT unique_channel_user_pair UNIQUE (ChannelId, UserId)
);

INSERT INTO ChannelUsers (ChannelId, UserId)
VALUES
  (1, 2),
  (1, 3),
  (2, 4),
  (3, 5),
  (3, 6),
  (4, 1),
  (4, 7);

select * from ChannelUsers

CREATE TABLE MuteList (
  Id SERIAL PRIMARY KEY,
  ChannelId INTEGER REFERENCES Channels(Id),
  UserId INTEGER REFERENCES Users(Id),
  MutedDate TIMESTAMP,
  ExpireTime INTEGER
);

select * from MuteList

INSERT INTO MuteList (ChannelId, UserId, MutedDate, ExpireTime)
VALUES
  (1, 2, '2023-05-07 10:00:00', 3600),
  (2, 3, '2023-05-07 12:00:00', 7200),
  (3, 4, '2023-05-07 14:00:00', 1800),
  (4, 5, '2023-05-07 16:00:00', 10800),
  (1, 6, '2023-05-07 18:00:00', 3600),
  (2, 7, '2023-05-07 20:00:00', 7200);




