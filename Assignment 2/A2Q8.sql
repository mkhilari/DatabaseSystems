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
