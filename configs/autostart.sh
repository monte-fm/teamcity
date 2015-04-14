#!/bin/bash
service nginx start
service ssh start
cd /opt/TeamCity/bin/
./runAll.sh
