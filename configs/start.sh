#!/bin/bash

#Starting ssh and MySQL services
service ssh start
service mysql start


#Starting TeamCity Server
cd /opt/TeamCity/bin/
./runAll.sh start
