-- __/\\\\\\\\\\\__/\\\\\_____/\\\__/\\\\\\\\\\\\\\\_____/\\\\\_________/\\\\\\\\\_________/\\\\\\\________/\\\\\\\________/\\\\\\\________/\\\\\\\\\\________________/\\\\\\\\\_______/\\\\\\\\\_____        
--  _\/////\\\///__\/\\\\\\___\/\\\_\/\\\///////////____/\\\///\\\_____/\\\///////\\\_____/\\\/////\\\____/\\\/////\\\____/\\\/////\\\____/\\\///////\\\_____________/\\\\\\\\\\\\\___/\\\///////\\\___       
--   _____\/\\\_____\/\\\/\\\__\/\\\_\/\\\_____________/\\\/__\///\\\__\///______\//\\\___/\\\____\//\\\__/\\\____\//\\\__/\\\____\//\\\__\///______/\\\_____________/\\\/////////\\\_\///______\//\\\__      
--    _____\/\\\_____\/\\\//\\\_\/\\\_\/\\\\\\\\\\\____/\\\______\//\\\___________/\\\/___\/\\\_____\/\\\_\/\\\_____\/\\\_\/\\\_____\/\\\_________/\\\//_____________\/\\\_______\/\\\___________/\\\/___     
--     _____\/\\\_____\/\\\\//\\\\/\\\_\/\\\///////____\/\\\_______\/\\\________/\\\//_____\/\\\_____\/\\\_\/\\\_____\/\\\_\/\\\_____\/\\\________\////\\\____________\/\\\\\\\\\\\\\\\________/\\\//_____    
--      _____\/\\\_____\/\\\_\//\\\/\\\_\/\\\___________\//\\\______/\\\______/\\\//________\/\\\_____\/\\\_\/\\\_____\/\\\_\/\\\_____\/\\\___________\//\\\___________\/\\\/////////\\\_____/\\\//________   
--       _____\/\\\_____\/\\\__\//\\\\\\_\/\\\____________\///\\\__/\\\______/\\\/___________\//\\\____/\\\__\//\\\____/\\\__\//\\\____/\\\___/\\\______/\\\____________\/\\\_______\/\\\___/\\\/___________  
--        __/\\\\\\\\\\\_\/\\\___\//\\\\\_\/\\\______________\///\\\\\/______/\\\\\\\\\\\\\\\__\///\\\\\\\/____\///\\\\\\\/____\///\\\\\\\/___\///\\\\\\\\\/_____________\/\\\_______\/\\\__/\\\\\\\\\\\\\\\_ 
--         _\///////////__\///_____\/////__\///_________________\/////_______\///////////////_____\///////________\///////________\///////_______\/////////_______________\///________\///__\///////////////__

-- Your Name: Manish Khilari 
-- Your Student Number: 1173214 
-- By submitting, you declare that this work was completed entirely by yourself.

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q1

SELECT COUNT(*) AS speciesCount 
FROM Species 
WHERE Species.description LIKE '%this%' OR 'this%' OR '%this';

-- END Q1
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q2

SELECT Player.username, SUM(Phonemon.power) as totalPhonemonPower
FROM Phonemon
INNER JOIN Player ON Phonemon.player = Player.id
WHERE Player.username IN ('Cook', 'Hughes')
GROUP BY Player.id;

-- END Q2
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q3

SELECT Team.title, COUNT(*) AS numberOfPlayers
FROM Player
INNER JOIN Team ON Player.team = Team.id
GROUP BY Team.id;

-- END Q3
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q4

SELECT Species.id AS idSpecies, Species.title, T1.title, T2.title
FROM Species 
LEFT JOIN Type AS T1 ON Species.type1 = T1.id
LEFT JOIN Type AS T2 ON Species.type2 = T2.id
WHERE T1.title = 'Grass' OR T2.title = 'Grass';

-- END Q4
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q5

SELECT Player.id AS idPlayer, Player.username
FROM Player 
WHERE Player.id NOT IN 
	(SELECT Player.id
	FROM Purchase 
	INNER JOIN Player ON Purchase.player = Player.id
	INNER JOIN Item ON Purchase.item = Item.id
	WHERE Item.type = 'F')
;

-- END Q5
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q6

SELECT Player.level, SUM(Item.price * Purchase.quantity) AS totalAmountSpentByAllPlayersAtLevel
FROM Purchase
INNER JOIN Item ON Purchase.item = Item.id
INNER JOIN Player ON Purchase.player = Player.id
GROUP BY Player.level;

-- END Q6
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q7

SELECT *
FROM 
	(SELECT Purchase.item, Item.title, SUM(Purchase.quantity) AS numTimesPurchased
	FROM Purchase 
	INNER JOIN Item ON Purchase.item = Item.id
	GROUP BY Item.id) AS PurchaseQuantities
WHERE PurchaseQuantities.numTimesPurchased =
	(SELECT MAX(PurchaseQuantities.numTimesPurchased) FROM 
			(SELECT Purchase.item, Item.title, SUM(Purchase.quantity) AS numTimesPurchased
			FROM Purchase 
			INNER JOIN Item ON Purchase.item = Item.id
			GROUP BY Item.id) AS PurchaseQuantities
	)
;

-- END Q7
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q8

SELECT * 
FROM 
	(Select Player.id AS playerID, Player.username, COUNT(DISTINCT Item.id) AS numberDistinctFoodItemsPurchased
	FROM Purchase 
	INNER JOIN Player ON Purchase.player = Player.id
	INNER JOIN Item ON Purchase.item = Item.id
	INNER JOIN Food ON Item.id = Food.id
	GROUP BY Player.id) AS PlayerDistinctFoods
WHERE PlayerDistinctFoods.numberDistinctFoodItemsPurchased = 
	(SELECT DISTINCT Count(*)
	FROM Item
	INNER JOIN Food ON Item.id = Food.id)
;

-- END Q8
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q9

SELECT COUNT(*) AS numberOfPhonemonPairs, PairDistance.distanceX
FROM 
    (SELECT P1.id AS P1ID, P2.id AS P2ID, ROUND(SQRT(POWER(P2.latitude - P1.latitude, 2) + POWER(P2.longitude - P1.longitude, 2)) * 100, 2) AS distanceX
	FROM Phonemon AS P1, Phonemon AS P2
	WHERE P1.id < P2.id) AS PairDistance
WHERE PairDistance.distanceX <= 
	(SELECT MIN(ROUND(SQRT(POWER(P2.latitude - P1.latitude, 2) + POWER(P2.longitude - P1.longitude, 2)) * 100, 2)) AS distanceX
	FROM Phonemon AS P1, Phonemon AS P2
	WHERE P1.id != P2.id) 
GROUP BY PairDistance.distanceX
;

-- END Q9
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q10

SELECT P.username, T.title 
FROM Player AS P, Type AS T
WHERE 
	-- Returns number of distinct phonemon species owned by player P with type T in type1 
	(SELECT COUNT(DISTINCT Species.id)
    FROM Phonemon
    INNER JOIN Player ON Phonemon.player = Player.id
    INNER JOIN Species ON Phonemon.species = Species.id
    WHERE Phonemon.player = P.id
    AND Species.type1 = T.id)
    + 
    -- Returns number of distinct phonemon species owned by player P with type T in type2 
    (SELECT COUNT(DISTINCT Species.id)
    FROM Phonemon
    INNER JOIN Player ON Phonemon.player = Player.id
    INNER JOIN Species ON Phonemon.species = Species.id
    WHERE Phonemon.player = P.id
    AND Species.type2 = T.id)
	= 
    -- Returns number of phonemons of type T 
    (SELECT COUNT(*)
    FROM Species
    WHERE T.id IN (Species.type1, Species.type2))
;

-- END Q10
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- END OF ASSIGNMENT Do not write below this line