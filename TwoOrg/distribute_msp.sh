#!/bin/bash

# copy channel-artifacts and crypto-config to all node
#orderer1
cp channel-artifacts/ crypto-config deployed/ordererOrg-orderer1/ -r
#orderer2
cp channel-artifacts/ crypto-config deployed/ordererOrg-orderer2/ -r
#orderer3
cp channel-artifacts/ crypto-config deployed/ordererOrg-orderer3/ -r
#org1-peer1
cp channel-artifacts/ crypto-config deployed/org1-peer1/ -r
#org1-peer2
cp channel-artifacts/ crypto-config deployed/org1-peer2/ -r
#org2-peer1
cp channel-artifacts/ crypto-config deployed/org2-peer1/ -r
#org2-peer2
cp channel-artifacts/ crypto-config deployed/org2-peer2/ -r
#client
cp channel-artifacts/ crypto-config deployed/client/ -r

# distribute the node to its running host
scp -r deployed/ordererOrg-orderer1 xxx@172.16.2.59:/home/xxx/fabric-deploy/twoOrg
scp -r deployed/ordererOrg-orderer2 xxx@172.16.2.60:/home/xxx/fabric-deploy/twoOrg
scp -r deployed/ordererOrg-orderer3 xxx@172.16.2.61:/home/xxx/fabric-deploy/twoOrg

scp -r deployed/org1-peer1 xxx@172.16.2.59:/home/xxx/fabric-deploy/twoOrg
scp -r deployed/org1-peer2 xxx@172.16.2.60:/home/xxx/fabric-deploy/twoOrg
scp -r deployed/org2-peer1 xxx@172.16.2.61:/home/xxx/fabric-deploy/twoOrg
#scp -r deployed/org2-peer2 xxx@172.16.2.95:/home/xxx/fabric-deploy/twoOrg

cp deployed/org2-peer2 /home/xxx/fabric-deploy/twoOrg -r
cp deployed/client /home/xxx/fabric-deploy/twoOrg -r
cp deployed/chaincode /home/xxx/fabric-deploy/twoOrg -r