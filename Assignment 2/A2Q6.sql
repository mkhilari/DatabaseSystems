SELECT Player.level, SUM(Item.price * Purchase.quantity) AS totalAmountSpentByAllPlayersAtLevel
FROM Purchase
INNER JOIN Item ON Purchase.item = Item.id
INNER JOIN Player ON Purchase.player = Player.id
GROUP BY Player.level;