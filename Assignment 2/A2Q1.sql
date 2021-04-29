SELECT COUNT(*) AS speciesCount 
FROM Species 
WHERE Species.description LIKE '%this%' OR 'this%' OR '%this';