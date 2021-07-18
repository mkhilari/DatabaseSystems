SELECT Da.Quarter, SUM(TP.UnitCost) AS sumOfUnitCost 
FROM TreatmentPlan AS TP 
INNER JOIN Date AS Da ON TP.DateID = Da.DateID 
INNER JOIN Drug AS Dr ON TP.DrugID = Dr.DrugID
WHERE Dr.Duration > 8
GROUP BY Da.Quarter 
;
