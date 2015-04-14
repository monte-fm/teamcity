#!/bin/bash
service ssh start
service mysql start
cd /root/
./create_database.sh
cd /opt/TeamCity/bin/
./runAll.sh start
mv /root/start.sh /root/autostart.sh

