# transmission-vsftpd

Docker image for quick deployment of a seed-box based on Transmission and vsftpd.
Transmission on port 8080 and FTP-server on port 21 are accessible from VPN only.   
GitLab: https://gitlab.com/persoff68-docker/transmission-vsftpd  
Docker Hub: https://hub.docker.com/repository/docker/persoff68/transmission-vsftpd

**HOW-TO**  
1. Install Ubuntu distributive on your local or virtual server.
2. Set up SSH on port 22. https://help.ubuntu.ru/wiki/ssh
3. Install OpenVPN client and set up it. I advice to do it with the script written by a good guy from Spain. https://github.com/Nyr/openvpn-install
4. Copy _config/ports.sh_ to your server e.g. with scp util and run it with bash.
5. Do the same with _config/install-docker.sh_.
6. Run docker image with docker or docker-compose.

Build (that's a reminder for me):  
```
docker build -t persoff68/transmission-vsftpd .
```

Run (don't forget to use your own username and password):  
```
docker run -d --name transmission-vsftpd --restart always \
  -p 21:21 -p 21100-21110:21100-21110 -p 8080:8080 \
  --env USERNAME=username --env PASSWORD=password \
  persoff68/transmission-vsftpd 
```

Or run it with docker compose (don't forget to use your own username and password):
```
docker-compose up -d
```
