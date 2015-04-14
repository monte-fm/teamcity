FROM      ubuntu:14.04.2
MAINTAINER Olexander Kutsenko <olexander.kutsenko@gmail.com>

# SSH service
RUN sudo apt-get install -y openssh-server openssh-client
RUN sudo mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
#change 'pass' to your secret password
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

#install dependencies
RUN apt-get install -y default-jre default-jdk
RUN apt-get install -y wget nano vim nginx
RUN wget http://download.jetbrains.com/teamcity/TeamCity-9.0.3.tar.gz
RUN tar -xvzf TeamCity-9.0.3.tar.gz
RUN mv TeamCity /opt

#Copying configs
COPY configs/autostart.sh /root/autostart.sh
COPY configs/nginx/default /etc/nginx/sites-available/default
COPY configs/bash.bashrc /etc/bash.bashrc
RUN chmod +x /root/autostart.sh
RUN chmod +x /opt/TeamCity/bin/runAll.sh

#aliases
RUN alias ll='ls -la'

#open ports
EXPOSE 80 22 9090
