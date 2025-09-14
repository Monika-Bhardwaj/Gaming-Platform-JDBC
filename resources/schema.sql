CREATE DATABASE IF NOT EXISTS gaming_platform;
USE gaming_platform;


-- Country
 CREATE TABLE Country (
     CountryId INT PRIMARY KEY AUTO_INCREMENT,
     CountryName VARCHAR(100) NOT NULL
 );

 -- Region
 CREATE TABLE Region (
     RegionId INT PRIMARY KEY AUTO_INCREMENT,
     RegionName VARCHAR(100) NOT NULL
 );

 -- RegionToCountry
 CREATE TABLE RegionToCountry (
     RegionId INT,
     CountryId INT,
     PRIMARY KEY (RegionId, CountryId),
     FOREIGN KEY (RegionId) REFERENCES Region(RegionId),
     FOREIGN KEY (CountryId) REFERENCES Country(CountryId)
 );

 -- Player
 CREATE TABLE Player (
     PlayerId INT PRIMARY KEY AUTO_INCREMENT,
     Username VARCHAR(50) NOT NULL,
     Email VARCHAR(100) NOT NULL UNIQUE,
     PasswordHash VARCHAR(255) NOT NULL,
     Gender VARCHAR(10),
     CountryCode INT,
     RegionId INT,
     DateJoined DATE,
     DateOfBirth DATE,
     ProfileImage VARCHAR(255),
     LastActivity DATETIME,
     IsBanned BOOLEAN DEFAULT FALSE,
     FOREIGN KEY (CountryCode) REFERENCES Country(CountryId),
     FOREIGN KEY (RegionId) REFERENCES Region(RegionId)
 );

 -- PlayerSession
 CREATE TABLE PlayerSession (
     SessionId INT PRIMARY KEY AUTO_INCREMENT,
     PlayerId INT,
     LoginTime DATETIME,
     LogoutTime DATETIME,
     FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId)
 );

 -- Genre
 CREATE TABLE Genre (
     GenreId INT PRIMARY KEY AUTO_INCREMENT,
     Name VARCHAR(100) NOT NULL
 );

 -- MatchType
 CREATE TABLE MatchType (
     MatchTypeId INT PRIMARY KEY AUTO_INCREMENT,
     MatchTypeName VARCHAR(100)
 );

 -- Preferences
 CREATE TABLE Preferences (
     PlayerId INT,
     PreferredGenreId INT,
     PreferredMatchTypeId INT,
     PRIMARY KEY (PlayerId, PreferredGenreId, PreferredMatchTypeId),
     FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId),
     FOREIGN KEY (PreferredGenreId) REFERENCES Genre(GenreId),
     FOREIGN KEY (PreferredMatchTypeId) REFERENCES MatchType(MatchTypeId)
 );

 -- GameMode
 CREATE TABLE GameMode (
     GameModeId INT PRIMARY KEY AUTO_INCREMENT,
     Name VARCHAR(100),
     Description TEXT,
     MaxPlayers INT,
     TeamSize INT
 );

 -- Game
 CREATE TABLE Game (
     GameId INT PRIMARY KEY AUTO_INCREMENT,
     Title VARCHAR(100),
     GenreId INT,
     Description TEXT,
     Paid BOOLEAN,
     ThumbnailImage VARCHAR(255),
     BackgroundImage VARCHAR(255),
     FOREIGN KEY (GenreId) REFERENCES Genre(GenreId)
 );

 -- GameBanned
 CREATE TABLE GameBanned (
     GameBanId INT PRIMARY KEY AUTO_INCREMENT,
     GameId INT,
     RegionId INT,
     CountryId INT,
     FOREIGN KEY (GameId) REFERENCES Game(GameId),
     FOREIGN KEY (RegionId) REFERENCES Region(RegionId),
     FOREIGN KEY (CountryId) REFERENCES Country(CountryId)
 );

 -- Achievement
 CREATE TABLE Achievement (
     AchievementId INT PRIMARY KEY AUTO_INCREMENT,
     Name VARCHAR(100),
     Description TEXT
 );

 -- PlayerAchievement
 CREATE TABLE PlayerAchievement (
     PlayerId INT,
     AchievementId INT,
     DateUnlocked DATE,
     PRIMARY KEY (PlayerId, AchievementId),
     FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId),
     FOREIGN KEY (AchievementId) REFERENCES Achievement(AchievementId)
 );

 -- SkillLevel
 CREATE TABLE SkillLevel (
     SkillId INT PRIMARY KEY AUTO_INCREMENT,
     SkillName VARCHAR(100)
 );

 -- PlayerStats
 CREATE TABLE PlayerStats (
     PlayerId INT PRIMARY KEY,
     TotalMatches INT,
     Wins INT,
     Losses INT,
     Ranking INT,
     SkillId INT,
     Points INT,
     Coins INT,
     LastUpdated DATETIME,
     FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId),
     FOREIGN KEY (SkillId) REFERENCES SkillLevel(SkillId)
 );

 -- PlayerSkillHistory
 CREATE TABLE PlayerSkillHistory (
     PlayerId INT,
     SkillReachedId INT,
     RecordedAt DATETIME,
     FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId),
     FOREIGN KEY (SkillReachedId) REFERENCES SkillLevel(SkillId)
 );

 -- GameStats
 CREATE TABLE GameStats (
     GameId INT,
     RegionId INT,
     TotalMatchesPlayed INT,
     PlayersPlayed INT,
     TournamentsCount INT,
     GameMode INT,
     PRIMARY KEY (GameId, RegionId),
     FOREIGN KEY (GameId) REFERENCES Game(GameId),
     FOREIGN KEY (RegionId) REFERENCES Region(RegionId)
 );

 -- PlayerRankingHistory
 CREATE TABLE PlayerRankingHistory (
     PlayerId INT,
     Ranking INT,
     RecordedAt DATETIME,
     FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId)
 );

 -- Tournament
 CREATE TABLE Tournament (
     TournamentId INT PRIMARY KEY AUTO_INCREMENT,
     GameId INT,
     GameModeId INT,
     MatchTypeId INT,
     Name VARCHAR(100),
     StartDate DATE,
     EndDate DATE,
     PrizePool DECIMAL(10,2),
     RegionId INT,
     Description TEXT,
     RegistrationStartDate DATETIME,
     RegistrationEndDate DATETIME,
     FOREIGN KEY (GameId) REFERENCES Game(GameId),
     FOREIGN KEY (GameModeId) REFERENCES GameMode(GameModeId),
     FOREIGN KEY (MatchTypeId) REFERENCES MatchType(MatchTypeId),
     FOREIGN KEY (RegionId) REFERENCES Region(RegionId)
 );

 -- TournamentRegistration
 CREATE TABLE TournamentRegistration (
     RegistrationId INT,
     TournamentId INT,
     IsTeamTournament BOOLEAN,
     PlayerId INT,
     TeamId INT,
     RegisteredAt DATETIME,
     PRIMARY KEY (RegistrationId, TournamentId),
     FOREIGN KEY (TournamentId) REFERENCES Tournament(TournamentId),
     FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId)
 );

 -- Bracket
 CREATE TABLE Bracket (
     BracketId INT,
     TournamentId INT,
     Round INT,
     Name VARCHAR(100),
     PRIMARY KEY (TournamentId, BracketId, Round),
     FOREIGN KEY (TournamentId) REFERENCES Tournament(TournamentId)
 );

 Match
 CREATE TABLE Matches (
     MatchId INT PRIMARY KEY AUTO_INCREMENT,
     GameId INT,
     GameModeId INT,
     MatchTypeId INT,
     RegionId INT,
     StartTime DATETIME,
     EndTime DATETIME,
     TournamentMatch BOOLEAN,
     TournamentId INT,
     BracketId INT,
     Round INT,
     FOREIGN KEY (GameId) REFERENCES Game(GameId),
     FOREIGN KEY (GameModeId) REFERENCES GameMode(GameModeId),
     FOREIGN KEY (MatchTypeId) REFERENCES MatchType(MatchTypeId),
     FOREIGN KEY (TournamentId, BracketId, Round) REFERENCES Bracket(TournamentId, BracketId, Round)
 );

 -- MatchParticipation
 CREATE TABLE MatchParticipation (
     MatchId INT,
     Position INT,
     PlayerId INT,
     TeamId INT,
     Score INT,
     PRIMARY KEY (MatchId, Position),
     FOREIGN KEY (MatchId) REFERENCES Matches(MatchId),
     FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId)
 );

 -- PriceDistribution
 CREATE TABLE PriceDistribution (
     TournamentId INT,
     Position INT,
     Price DECIMAL(10,2),
     PRIMARY KEY (TournamentId, Position),
     FOREIGN KEY (TournamentId) REFERENCES Tournament(TournamentId)
 );

 -- TournamentLeaderBoard
 CREATE TABLE TournamentLeaderBoard (
     TournamentId INT,
     BracketId INT,
     Round INT,
     TeamId INT,
     PlayerId INT,
     Position INT,
     PRIMARY KEY (TournamentId, BracketId, Round),
     FOREIGN KEY (TournamentId) REFERENCES Tournament(TournamentId)
 );

 -- CurrencyPacks
 CREATE TABLE CurrencyPacks (
     PackId INT PRIMARY KEY AUTO_INCREMENT,
     RealMoneyAmount DECIMAL(10,2),
     PackName VARCHAR(100),
     Quantity INT,
     Description TEXT
 );

 -- Item
 CREATE TABLE Item (
     ItemId INT PRIMARY KEY AUTO_INCREMENT,
     Name VARCHAR(100),
     GameId INT,
     Description TEXT,
     BaseValue DECIMAL(10,2),
     FOREIGN KEY (GameId) REFERENCES Game(GameId)
 );

 -- Inventory
 CREATE TABLE Inventory (
     PlayerId INT,
     ItemId INT,
     Quantity INT,
     LastUpdatedTime TIMESTAMP,
     PRIMARY KEY (PlayerId, ItemId),
     FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId),
     FOREIGN KEY (ItemId) REFERENCES Item(ItemId)
 );

 -- RealTransaction
 CREATE TABLE RealTransaction (
     TransactionId INT PRIMARY KEY AUTO_INCREMENT,
     PlayerId INT,
     CurrencyPackId INT,
     ModeOfPayment ENUM('UPI','Credit Card','Debit Card','Net Banking'),
     Timestamp DATETIME,
     FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId),
     FOREIGN KEY (CurrencyPackId) REFERENCES CurrencyPacks(PackId)
 );

 -- ItemsForSale
 CREATE TABLE ItemsForSale (
     ItemId INT,
     PlayerId INT,
     Quantity INT,
     ListedPricePerItem DECIMAL(10,2),
     PRIMARY KEY (PlayerId, ItemId),
     FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId),
     FOREIGN KEY (ItemId) REFERENCES Item(ItemId)
 );

 -- VirtualTransaction
 CREATE TABLE VirtualTransaction (
     VirtualTransactionId INT PRIMARY KEY AUTO_INCREMENT,
     PlayerId INT,
     Action ENUM('earn','store','tradeItem'),
     ItemBought INT,
     Quantity INT,
     Timestamp DATETIME,
     UNIQUE (PlayerId, VirtualTransactionId, ItemBought),
     FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId),
     FOREIGN KEY (ItemBought) REFERENCES Item(ItemId)
 );

 -- Friends
 CREATE TABLE Friends (
     Player1Id INT,
     Player2Id INT,
     PRIMARY KEY (Player1Id, Player2Id),
     FOREIGN KEY (Player1Id) REFERENCES Player(PlayerId),
     FOREIGN KEY (Player2Id) REFERENCES Player(PlayerId)
 );

 -- Friendship_log
 CREATE TABLE Friendship_log (
     RequesterId INT,
     AddresseeId INT,
     LastUpdatedStatus ENUM('Pending','Accepted','Decline','Removed'),
     LastUpdatedAt DATETIME,
     PRIMARY KEY (RequesterId, AddresseeId),
     FOREIGN KEY (RequesterId) REFERENCES Player(PlayerId),
     FOREIGN KEY (AddresseeId) REFERENCES Player(PlayerId)
 );

 -- SubscriptionPacks
 CREATE TABLE SubscriptionPacks (
     SubscriptionPackId INT PRIMARY KEY AUTO_INCREMENT,
     PackName VARCHAR(100),
     Duration INT,
     Amount DECIMAL(10,2)
 );

 -- Subscription
 CREATE TABLE Subscription (
     PurchaseId INT PRIMARY KEY AUTO_INCREMENT,
     PlayerId INT,
     SubscriptionPackId INT,
     PurchaseDate DATETIME,
     EndDate DATETIME,
     ModeOfPayment ENUM('UPI','Credit Card','Debit Card','Net Banking'),
     FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId),
     FOREIGN KEY (SubscriptionPackId) REFERENCES SubscriptionPacks(SubscriptionPackId)
 );

 -- Message
 CREATE TABLE Message (
     MessageId INT PRIMARY KEY AUTO_INCREMENT,
     SenderId INT,
     ReceiverId INT,
     Content TEXT,
     SentAt DATETIME,
     FOREIGN KEY (SenderId) REFERENCES Player(PlayerId),
     FOREIGN KEY (ReceiverId) REFERENCES Player(PlayerId)
 );

 -- Team
 CREATE TABLE Team (
     TeamId INT PRIMARY KEY AUTO_INCREMENT,
     Name VARCHAR(100),
     CreatedBy INT,
     CreatedAt DATETIME,
     FOREIGN KEY (CreatedBy) REFERENCES Player(PlayerId)
 );

 -- TeamMembership
 CREATE TABLE TeamMembership (
     TeamId INT,
     PlayerId INT,
     PRIMARY KEY (TeamId, PlayerId),
     FOREIGN KEY (TeamId) REFERENCES Team(TeamId),
     FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId)
 );

 -- Actions
 CREATE TABLE Actions (
     ActionId INT PRIMARY KEY AUTO_INCREMENT,
     ActionName VARCHAR(100),
     ActionTaken VARCHAR(255)
 );

 -- ModerationAction
 CREATE TABLE ModerationAction (
     Id INT PRIMARY KEY AUTO_INCREMENT,
     ReporterId INT,
     PlayerId INT,
     ActionId INT,
     Reason TEXT,
     Timestamp DATETIME,
     FOREIGN KEY (ReporterId) REFERENCES Player(PlayerId),
     FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId),
     FOREIGN KEY (ActionId) REFERENCES Actions(ActionId)
 );