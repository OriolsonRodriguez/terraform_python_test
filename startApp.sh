sudo apt install docker.io
sudo systemctl enable --now docker

apt install git
git clone https://github.com/OriolsonRodriguez/terraform_python_test/tree/develop
cd terraform_python_test
git checkout develop

sudo docker build -t flugelChallenge 

sudo docker run -it --publish 4444:8888 --d flugelChallenge