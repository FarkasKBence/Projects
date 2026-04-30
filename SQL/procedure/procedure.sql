SELECT rowid, dolgozo.* FROM dolgozo;

SELECT rowid,
dbms_rowid.rowid_object(rowid) adatobj,
dbms_rowid.rowid_relative_fno(rowid) fajl,
dbms_rowid.rowid_block_number(rowid) blokk,
dbms_rowid.rowid_row_number(rowid) sor,
dolgozo.*
FROM dolgozo;

SELECT * FROM dba_objects WHERE object_id = 78322;
SELECT * FROM dba_data_files;

SELECT * FROM dba_indexes WHERE owner = 'NIKOVITS' AND index_name = 'EMP2';

SELECT * FROM dba_ind_columns WHERE index_owner = 'NIKOVITS' AND index_name = 'EMP2';

SELECT * FROM dba_ind_expressions WHERE index_owner = 'NIKOVITS';

SELECT * FROM dba_part_tables;

SELECT * FROM dba_tab_partitions;

SELECT * FROM dba_part_indexes;

--azoknak a tábláknak a nevei, amelyeknek van csökkenő sorrendben indexelt oszlopa

SELECT table_owner, table_name, column_name
FROM dba_ind_columns WHERE descend = 'DESC'
GROUP BY table_owner, table_name, column_name;

--azoknak az indexeknek a nevei, amelyek legalabb 9 oszloposak

SELECT index_owner, index_name, COUNT(column_name)
FROM dba_ind_columns
GROUP BY index_owner, index_name, table_owner
HAVING COUNT(column_name) >= 9;

--parmeterul kapott tablara vonatkozoan kiirja a tabla indexeit es azok meretet bajtban. az indexek abc sorrendben, kulon sorokban legyenek
 
SELECT segment_name, bytes
FROM dba_segments
WHERE segment_type = 'INDEX' AND owner = 'NIKOVITS' AND segment_name IN (
    SELECT index_name
    FROM dba_indexes
    WHERE owner = 'NIKOVITS' AND table_name = 'EMP'
)
ORDER BY segment_name;

CREATE OR REPLACE PROCEDURE list_indexes(p_owner VARCHAR2, p_table VARCHAR2) IS
    CURSOR curs1 IS
        SELECT segment_name, bytes
        FROM dba_segments
        WHERE segment_type = 'INDEX' AND UPPER(owner) = UPPER(p_owner) AND segment_name IN (
            SELECT index_name
            FROM dba_indexes
            WHERE UPPER(owner) = UPPER(p_owner) AND UPPER(table_name) = UPPER(p_table)
        )
        ORDER BY segment_name;
    rec curs1%rowtype;
BEGIN
    FOR rec In curs1 LOOP
        dbms_output.put_line(rec.segment_name || ': ' || rec.bytes);
    END LOOP;
END;
/

SET SERVEROUTPUT ON;
EXECUTE list_indexes('nikovits', 'emp');

--hozzunk letre egy indexet a dolgozo tabla oazon oszlopara dolgozo_oazon neven

CREATE INDEX dolgozo_oazon ON dolgozo(oazon);

SELECT * FROM dba_indexes WHERE index_name = 'DOLGOZO_OAZON';