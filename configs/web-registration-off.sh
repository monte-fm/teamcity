#!/bin/bash
cp /opt/TeamCity/webapps/ROOT/login.jsp /root/login-on.jsp
mv /root/login-off.jsp /opt/TeamCity/webapps/ROOT/login.jsp
chown root:root /opt/TeamCity/webapps/ROOT/login.jsp
mv  /opt/TeamCity/webapps/ROOT/registerUser.jsp /root/registerUser.jsp
