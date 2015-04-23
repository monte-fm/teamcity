#!/bin/bash
cp /opt/TeamCity/webapps/ROOT/login.jsp /opt/TeamCity/webapps/ROOT/login-old.jsp
mv /root/login.jsp /opt/TeamCity/webapps/ROOT/login.jsp
chown root:root /opt/TeamCity/webapps/ROOT/login.jsp
