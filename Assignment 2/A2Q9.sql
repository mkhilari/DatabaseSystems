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