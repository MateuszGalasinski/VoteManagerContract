docker build -t vote-manager .

docker run --name=vote-manager-container vote-manager

docker exec vote-manager-container /bin/sh -c "truffle migrate" 