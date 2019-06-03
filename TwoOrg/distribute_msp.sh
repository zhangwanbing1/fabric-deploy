#!/bin/bash

# 172.16.2.59     orderer1.example.com
# 172.16.2.60     orderer2.example.com
# 172.16.2.61     orderer3.example.com
# 172.16.2.59     peer0.org1.example.com
# 172.16.2.60     peer1.org1.example.com
# 172.16.2.61     peer0.org2.example.com
# 192.168.14.95   peer1.org2.example.com

# copy channel-artifacts and crypto-config to all node
#orderer1
cp channel-artifacts/ crypto-config deployed/ordererOrg-orderer1/ -r
#orderer2
cp channel-artifacts/ crypto-config deployed/ordererOrg-orderer2/ -r
#orderer3
cp channel-artifacts/ crypto-config deployed/ordererOrg-orderer3/ -r
#org1-peer0
cp channel-artifacts/ crypto-config deployed/org1-peer0/ -r
#org1-peer1
cp channel-artifacts/ crypto-config deployed/org1-peer1/ -r
#org2-peer0
cp channel-artifacts/ crypto-config deployed/org2-peer0/ -r
#org2-peer1
cp channel-artifacts/ crypto-config deployed/org2-peer1/ -r
#client
cp channel-artifacts/ crypto-config deployed/client/ -r

# distribute the node to its running host
scp -r deployed/ordererOrg-orderer1 xxx@orderer1.example.com:/home/xxx/fabric-deploy/twoOrg
scp -r deployed/ordererOrg-orderer2 xxx@orderer2.example.com:/home/xxx/fabric-deploy/twoOrg
scp -r deployed/ordererOrg-orderer3 xxx@orderer3.example.com:/home/xxx/fabric-deploy/twoOrg

scp -r deployed/org1-peer0 xxx@peer0.org1.example.com:/home/xxx/fabric-deploy/twoOrg
scp -r deployed/org1-peer1 xxx@peer1.org1.example.com:/home/xxx/fabric-deploy/twoOrg
scp -r deployed/org2-peer0 xxx@peer0.org2.example.com:/home/xxx/fabric-deploy/twoOrg
#scp -r deployed/org2-peer2 xxx@peer1.org2.example.com:/home/xxx/fabric-deploy/twoOrg

cp deployed/org2-peer1 /home/xxx/fabric-deploy/twoOrg -r
cp deployed/client /home/xxx/fabric-deploy/twoOrg -r
cp deployed/chaincode /home/xxx/fabric-deploy/twoOrg -r