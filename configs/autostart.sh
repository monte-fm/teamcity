#!/bin/bash
#start services ssh and mysql
service ssh start
service mysql start

#creating database
cd /root/
./create_database.sh
rm /root/create_database.sh

#starting TeamCity Server
cd /opt/TeamCity/bin/
./runAll.sh start

#remove database_creation on container start
mv /root/start.sh /root/autostart.sh

