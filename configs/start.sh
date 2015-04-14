#!/bin/bash
service ssh start
service mysql start
cd /opt/TeamCity/bin/
./runAll.sh start
