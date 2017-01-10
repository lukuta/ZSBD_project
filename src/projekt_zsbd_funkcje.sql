IF OBJECT_ID('fun1') IS NOT NULL
DROP FUNCTION fun1
GO


--1. Funkcja wyœwietlaj¹ca podsumowanie dla schroniska
CREATE FUNCTION fun1() 
RETURNS VARCHAR(100)
AS 
BEGIN
	DECLARE @stats varchar(100)
	DECLARE @new_line AS CHAR(2) = CHAR(13) + CHAR(10)

	SET @stats = (SELECT TOP 1 'Psów: ' + CAST(COUNT(p.pies_id) as varchar(10)) + @new_line
				  FROM schronisko..Pies as p)
	SET @stats += (SELECT TOP 1 'Pracowników: ' + CAST(COUNT(pr.pracownik_id) as varchar(10)) + @new_line
				  FROM schronisko..Pracownik as pr)
	SET @stats += (SELECT TOP 1 + 'Pojemnoœæ schroniska: ' + CAST(SUM(k.pojemnosc) as varchar(10))
				  FROM schronisko..Klatka as k)				  	
							 
	RETURN @stats;
END
GO

print dbo.fun1()

