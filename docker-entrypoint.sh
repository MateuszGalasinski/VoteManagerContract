#!/bin/sh
(sleep 10s && truffle migrate) &
/app/ganache-core.docker.cli.js --account="0x59bb027fa0ea6e6a979f0f26d774f396d5b3e4704f052acaab1497666d5ed283,3000000000000000000000" -q -b 3 