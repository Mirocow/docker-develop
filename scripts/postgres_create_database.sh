#!/bin/bash
########################################################
# - create a test database if it does not exist.
# if necessary some variables may be passed
# with arguments; db password, path to psql,
# name of the database, db owner... anything else
#-----------------------------------------------------
 
# if we get the db password, we put it in our temp
# env., otherwise psql may pause and prompt for it.
export PGPASSWORD="postgres"

if [ "$2" ] ; then
   export PGPASSWORD="$2"
fi
 
# may check the args to see if dbname
# was provided
dbname=test

if [ "$1" ] ; then
   dbname="$1"
fi
 
# sql to check whether given database exist
sql1="select count(1) from pg_catalog.pg_database where datname = '$dbname'"
 
# sql to create database (add other params as needed)
sql2="create database $dbname"
 
# depending on how PATH is set psql may require a fully qualified path
cmd="psql -U postgres -tc \"$sql1\""
 
db_exists=`eval $cmd`
 
if [ $db_exists -eq 0 ] ; then
   # create the database, discard the output
   cmd="psql -U postgres -tc \"$sql2\" > /dev/null 2>&1"
   eval $cmd
fi
 
# exit with success status
exit 0
