#!/bin/bash
#start services ssh and mysql
service ssh start
service mysql start

#creating database
mysqladmin -uroot -proot create teamcity

echo "
#!/bin/bash

#Starting SSH and MySQL services
service ssh start
service mysql start

#Starting TeamCity Server
service teamcity start
" > /root/autostart.sh