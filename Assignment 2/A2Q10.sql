SELECT COUNT(*)
FROM Phonemon
INNER JOIN Player ON Phonemon.player = Player.id
INNER JOIN Species ON Phonemon.species = Species.id
INNER JOIN Type AS T1 ON Species.type1 = T1.id
LEFT JOIN Type AS T2 ON Species.type2 = T2.id