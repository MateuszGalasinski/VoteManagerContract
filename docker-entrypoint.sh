#!/bin/sh
(sleep 15s && truffle migrate) &
/app/ganache.core.cli.js --host 127.0.0.1 --networkId 4466 --account="0x59bb027fa0ea6e6a979f0f26d774f396d5b3e4704f052acaab1497666d5ed283,3000000000000000000000" -b 1