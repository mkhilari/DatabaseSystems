SELECT Species.id AS idSpecies, Species.title, T1.title, T2.title
FROM Species 
LEFT JOIN Type AS T1 ON Species.type1 = T1.id
LEFT JOIN Type AS T2 ON Species.type2 = T2.id
WHERE T1.title = 'Grass' OR T2.title = 'Grass';