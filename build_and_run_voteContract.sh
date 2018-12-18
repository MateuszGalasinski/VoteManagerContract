git pull

docker build -t vote-manager/vote-contracts .

docker rm -f vote_contracts

docker run -p 8545:8545 --name=vote_contracts vote-manager/vote-contracts