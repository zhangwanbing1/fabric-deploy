#!/bin/bash

cp channel-artifacts/ crypto-config ../orderer1-ordererOrg/ -r
scp -r channel-artifacts/ crypto-config xxx@172.16.2.60:/home/xxx/fabric-deploy
scp -r channel-artifacts/ crypto-config xxx@192.168.14.95:/home/xxx/fabric-deploy/orderer3-ordererOrg
scp -r channel-artifacts/ crypto-config xxx@192.168.14.95:/home/xxx/fabric-deploy/peer2-org1
scp -r channel-artifacts/ crypto-config kylin@192.168.14.150:/home/kylin/fabric-deploy/peer1-org1
