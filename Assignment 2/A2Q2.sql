SELECT Player.username, SUM(Phonemon.power) as totalPhonemonPower
FROM Phonemon
INNER JOIN Player ON Phonemon.player = Player.id
WHERE Player.username IN ('Cook', 'Hughes')
GROUP BY Player.id;