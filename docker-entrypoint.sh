#!/bin/sh
(sleep 10s && truffle migrate; echo '---> Vote manager contract should now be ready. You can check previous message from deployment in ganache output. <---') &
/app/ganache.core.cli.js --networkId 4466 --gasLimit 20000000000 --gasPrice 20000 --account="0x59bb027fa0ea6e6a979f0f26d774f396d5b3e4704f052acaab1497666d5ed283,3000000000000000000000" -b 1