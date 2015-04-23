#!/bin/bash
cp /opt/TeamCity/webapps/ROOT/login.jsp /root/login-off.jsp
mv /root/login-on.jsp /opt/TeamCity/webapps/ROOT/login.jsp
chown root:root /opt/TeamCity/webapps/ROOT/login.jsp
cp /root/registerUser.jsp /opt/TeamCity/webapps/ROOT/registerUser.jsp
