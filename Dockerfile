FROM      ubuntu:14.04.2
MAINTAINER Olexander Kutsenko <olexander.kutsenko@gmail.com>

# SSH service
RUN apt-get install -y openssh-server openssh-client
RUN apt-get update
RUN apt-get install -y python-software-properties
RUN sudo mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
#change 'pass' to your secret password
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

#MySQL install + password
RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
RUN sudo apt-get  install -y mysql-server mysql-client
RUN service mysql start
RUN mysqladmin -uroot -proot create teamcity

#install dependencies
RUN apt-get update
RUN apt-get install -y default-jre default-jdk
RUN apt-get install -y wget nano vim
#RUN apt-get install -y nginx
RUN wget http://download.jetbrains.com/teamcity/TeamCity-9.0.3.tar.gz
RUN tar -xvzf TeamCity-9.0.3.tar.gz
RUN mv TeamCity /opt

#Copying configs
COPY configs/autostart.sh /root/autostart.sh
#COPY configs/nginx/default /etc/nginx/sites-available/default
COPY configs/bash.bashrc /etc/bash.bashrc
RUN chmod +x /root/autostart.sh
RUN chmod +x /opt/TeamCity/bin/runAll.sh

#aliases
RUN alias ll='ls -la'

#MySQL driver
RUN mkdir -p /root/.BuildServer/lib/jdbc
COPY configs/mysql-connector-java-5.1.35-bin.jar /root/.BuildServer/lib/jdbc/
RUN chmod +x /root/.BuildServer/lib/jdbc/mysql-connector-java-5.1.35-bin.jar
#open ports
EXPOSE 8111 22
