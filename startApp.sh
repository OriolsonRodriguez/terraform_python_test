sudo apt install docker.io
sudo systemctl enable --now docker

sudo docker build -t flugel .

sudo docker run -it --publish 8000:4000 flugel
