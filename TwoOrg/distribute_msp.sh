#!/bin/bash

# copy channel-artifacts and crypto-config to all node
#orderer1
cp channel-artifacts/ crypto-config deploy/ordererOrg-orderer1/ -r
#orderer2
cp channel-artifacts/ crypto-config deploy/ordererOrg-orderer2/ -r
#orderer3
cp channel-artifacts/ crypto-config deploy/ordererOrg-orderer3/ -r
#org1-peer1
cp channel-artifacts/ crypto-config deploy/org1-peer1/ -r
#org1-peer2
cp channel-artifacts/ crypto-config deploy/org1-peer2/ -r
#org2-peer1
cp channel-artifacts/ crypto-config deploy/org2-peer1/ -r
#org2-peer2
cp channel-artifacts/ crypto-config deploy/org2-peer2/ -r
#client
cp channel-artifacts/ crypto-config deploy/client/ -r

# distribute the node to its running host
scp -r deploy/ordererOrg-orderer1 xxx@172.16.2.59:/home/xxx/fabric-deploy/twoOrg
scp -r deploy/ordererOrg-orderer2 xxx@172.16.2.60:/home/xxx/fabric-deploy/twoOrg
scp -r deploy/ordererOrg-orderer3 xxx@172.16.2.61:/home/xxx/fabric-deploy/twoOrg

scp -r deploy/org1-peer1 xxx@172.16.2.59:/home/xxx/fabric-deploy/twoOrg
scp -r deploy/org1-peer2 xxx@172.16.2.60:/home/xxx/fabric-deploy/twoOrg
scp -r deploy/org2-peer1 xxx@172.16.2.61:/home/xxx/fabric-deploy/twoOrg
scp -r deploy/org2-peer2 xxx@172.16.2.95:/home/xxx/fabric-deploy/twoOrg

cp -r deploy/client /home/xxx/fabric-deploy/twoOrg