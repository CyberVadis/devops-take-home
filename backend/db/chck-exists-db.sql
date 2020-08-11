IF EXISTS(SELECT * FROM master.sys.databases 
          WHERE name='devops-db')
    BEGIN
        PRINT '1'	
    END
ELSE
    BEGIN
        PRINT '0'	
    END
