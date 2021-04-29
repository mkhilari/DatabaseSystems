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
