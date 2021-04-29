SELECT Player.id AS idPlayer, Player.username
FROM Player 
WHERE Player.id NOT IN 
	(SELECT Player.id
	FROM Purchase 
	INNER JOIN Player ON Purchase.player = Player.id
	INNER JOIN Item ON Purchase.item = Item.id
	WHERE Item.type = 'F')
;