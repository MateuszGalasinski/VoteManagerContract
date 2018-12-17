docker build -t vote-manager .

docker rm -f vote-manager-container

docker run -p 8545:8545 --name=vote-manager-container vote-manager