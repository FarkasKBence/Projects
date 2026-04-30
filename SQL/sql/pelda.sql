-- 1. feladat

    --SELECT DISTINCT oazon FROM osztaly;

	SELECT oazon FROM osztaly
    MINUS
    SELECT oazon FROM dolgozo NATURAL JOIN osztaly GROUP BY oazon;
    
-- 2. feladat

	SELECT osztaly.telephely
    FROM dolgozo worker, dolgozo boss, osztaly
    WHERE worker.fonoke = boss.dkod
    AND worker.oazon = osztaly.oazon
    AND worker.oazon != boss.oazon
    ORDER BY osztaly.telephely ASC;
	
-- 3. feladat

	SELECT CONCAT(SUBSTR(worker.dnev,0,1),SUBSTR(boss.dnev,0,1)) AS kezdobetuk
    FROM dolgozo worker, dolgozo boss, fiz_kategoria worker_money, fiz_kategoria boss_money
    WHERE worker.fizetes BETWEEN worker_money.also AND worker_money.felso
    AND boss.fizetes BETWEEN boss_money.also AND boss_money.felso
    AND worker.fonoke = boss.dkod
    AND worker_money.kategoria + 1 = boss_money.kategoria;
	
-- 4. feladat

	--SELECT * FROM dolgozo NATURAL JOIN osztaly;
    
	SELECT oazon, telephely, AVG(fizetes) AS atlag_fizetes, MAX(fizetes) AS max_fizetes
    FROM dolgozo NATURAL JOIN osztaly GROUP BY oazon, telephely
    ORDER BY atlag_fizetes DESC;
	
-- 5. feladat
    SELECT onev
    FROM dolgozo NATURAL JOIN osztaly
    GROUP BY onev
    HAVING AVG(fizetes) = 
        (
        SELECT MIN(avg) AS min
        FROM
            (
            SELECT onev, AVG(fizetes) AS avg
            FROM dolgozo NATURAL JOIN osztaly
            GROUP BY onev
            )
    );
	
-- 6. feladat

    --SELECT jutalek + 1000, NVL(jutalek,0) + 1000 AS steve
    --FROM dolgozo2 NATURAL JOIN osztaly
    --WHERE onev = 'RESEARCH';
    
    --SELECT * FROM dolgozo2 WHERE oazon = (SELECT oazon FROM osztaly WHERE onev = 'RESEARCH');
    
    UPDATE dolgozo2
    SET jutalek = NVL(jutalek,0) + 1000
    WHERE oazon =
        (
        SELECT oazon
        FROM osztaly
        WHERE onev = 'RESEARCH'
        );
    
    COMMIT;
	--ROLLBACK;
	
-- 7. feladat

    --SELECT * FROM dolgozo2 JOIN fiz_kategoria ON fizetes BETWEEN also AND felso; --nincs 1.es csoport
    --SELECT * FROM dolgozo2
    --WHERE fizetes >= (SELECT also FROM fiz_kategoria WHERE kategoria = 1)
    --AND fizetes <= (SELECT felso FROM fiz_kategoria WHERE kategoria = 1);
    
    DELETE FROM dolgozo2
    WHERE fizetes >= (SELECT also FROM fiz_kategoria WHERE kategoria = 1)
    AND fizetes <= (SELECT felso FROM fiz_kategoria WHERE kategoria = 1);
    
    ROLLBACK;