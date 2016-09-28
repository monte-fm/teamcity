# Create container  (TeamCity 10.0.2)
```
docker run -i -t -d -p 8111:8111 -p 1022:22 cristo/teamcity /bin/bash
```

#MySQL
```
DB_name: teamcity
user: root 
password: root

```
#SSH
```
ssh -p1022 root@localhost
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
                                proxy_set_header X-Real-IP $remote_addr;
                                proxy_cache off;
                                proxy_pass http://localhost:8111;
                        }
}
```

#TeamCity like service
Added service teamcity with 2 parameters ({start|stop}):
```
service teamcity start
```
```
service teamcity stop
```

#Origin
[Docker Hub] (https://registry.hub.docker.com/u/cristo/teamcity/)

[Git Hub] (https://github.com/monte-fm/teamcity)
