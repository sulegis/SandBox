#!/bin/bash
# wait-for-mysql.sh

set -e

host="$1"
user="$2"
password="$3"
db="$4"
shift 4 
cmd="$@"
until mysql -P3306 -h"$host" -u"$user" -p"$password" $db -e "show tables;"; do
  >&2 echo "MySQL is unavailable - sleeping"
  sleep 1
done

>&2 echo "MySQL is up - executing command"
sleep 2
echo "##Current SHOW TABLES is:##"
mysql -P3306 -h"$host" -u"$user" -p"$password" $db -e "show tables;"

echo cmd=$cmd
exec $cmd
