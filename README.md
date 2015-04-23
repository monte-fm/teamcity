#Create container  (TeamCity 9.0.4)
```
docker run -i -t -d -p 8111:8111 -p 22:22 cristo/teamcity /bin/bash
```

#MySQL
```
DB_name: teamcity
user: root 
password: root

```
#SSH
```
ssh -p22 root@localhost
password: root
```
#NGINX server config file for communicate with docker

```
server {
        listen *:80;
        server_name localhost;
        proxy_set_header Host localhost;
        client_max_body_size 100M;

                location / {
                                proxy_set_header Host $host;
                                proxy_set_header X-Real_IP $remote_addr;
                                proxy_cache off;
                                proxy_pass http://localhost:8111;
                        }
}
```

#WARNING!
Agent connection error login TeamCity Server version 9.0.3

#[bug tracker] (https://youtrack.jetbrains.com/issue/TW-39784)
