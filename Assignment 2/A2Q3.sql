SELECT Team.title, COUNT(*) AS numberOfPlayers
FROM Player
INNER JOIN Team ON Player.team = Team.id
GROUP BY Team.id;