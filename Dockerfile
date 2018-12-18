FROM trufflesuite/ganache-cli:latest as runtime

RUN npm install -g truffle 

WORKDIR /app
COPY Contracts/ Contracts/

ENV DOCKER true
EXPOSE 8545

COPY ./docker-entrypoint.sh /
WORKDIR /app/Contracts
ENTRYPOINT ["/docker-entrypoint.sh"]