FROM      ubuntu
MAINTAINER Olexander Kutsenko <olexander.kutsenko@gmail.com>

# SSH service
RUN apt-get update
RUN apt-get install -y openssh-server openssh-client
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

#Install Java 8
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
# Accept license non-iteractive
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer
RUN apt-get install -y oracle-java8-set-default
RUN echo "JAVA_HOME=/usr/lib/jvm/java-8-oracle" | sudo tee -a /etc/environment
RUN export JAVA_HOME=/usr/lib/jvm/java-8-oracle

#install dependencies
RUN apt-get update
RUN apt-get install -y wget nano vim mc
#RUN apt-get install -y nginx
RUN wget https://download.jetbrains.com/teamcity/TeamCity-9.1.6.tar.gz
RUN tar -xvzf TeamCity-*
RUN mv TeamCity /opt

#Copying configs
COPY configs/autostart.sh /root/autostart.sh
COPY configs/bash.bashrc /etc/bash.bashrc
COPY configs/teamcity /etc/init.d/teamcity
RUN chmod +x /root/*.sh /etc/init.d/teamcity
RUN chmod +x /opt/TeamCity/bin/*.sh

#MySQL driver
RUN mkdir -p /root/.BuildServer/lib/jdbc
COPY configs/mysql-connector-java-5.1.35-bin.jar /root/.BuildServer/lib/jdbc/
RUN chmod +x /root/.BuildServer/lib/jdbc/mysql-connector-java-5.1.35-bin.jar

#Add colorful command line
RUN echo "force_color_prompt=yes" >> .bashrc
RUN echo "export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h \[\033[01;33m\]\w \[\033[01;35m\]\$ \[\033[00m\]'" >> .bashrc

#etcKeeper
RUN mkdir -p /root/etckeeper
COPY configs/etckeeper.sh /root/etckeeper.sh
COPY configs/files/etckeeper-hook.sh /root/etckeeper/etckeeper-hook.sh
RUN chmod +x /root/etckeeper/*.sh
RUN chmod +x /root/*.sh
RUN /root/etckeeper.sh

#open ports
EXPOSE 8111 22 80
