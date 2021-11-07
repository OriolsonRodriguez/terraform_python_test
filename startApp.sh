sudo apt install docker.io
sudo systemctl enable --now docker

apt update
apt install git
git clone https://github.com/OriolsonRodriguez/terraform_python_test
cd terraform_python_test
git checkout develop

cd src/

sudo docker build -t flugel .

sudo docker run -it --publish 4000:4000 flugel
