FROM mhart/alpine-node:10 as builder

RUN apk add --no-cache git

#download contracts
WORKDIR /download
RUN git clone https://github.com/MateuszGalasinski/VoteManagerContract.git

FROM trufflesuite/ganache-cli:latest as runtime

WORKDIR /app

RUN apk add --no-cache

COPY --from=builder /download/VoteManagerContract/Contracts/ Contracts/
RUN npm install -g truffle 

ENV DOCKER true

EXPOSE 8545

COPY ./docker-entrypoint.sh /
WORKDIR /app/Contracts
ENTRYPOINT ["/docker-entrypoint.sh"]