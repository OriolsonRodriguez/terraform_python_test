sudo apt install docker.io
sudo systemctl enable --now docker

cd src/

sudo docker build -t flugel .

sudo docker run -it --publish 4000:4000 flugel
