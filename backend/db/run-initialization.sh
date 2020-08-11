# Wait to be sure that SQL Server came up
sleep 30s

# Run the setup script to create the DB and the schema in the DB
# Note: make sure that your password matches what is in the Dockerfile

TEST=`/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 1Qaz2wsx! -d master -i chck-exists-db.sql`
if [ "$TEST" == "0" ] ; then
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 1Qaz2wsx! -d master -i initialize-db.sql
fi