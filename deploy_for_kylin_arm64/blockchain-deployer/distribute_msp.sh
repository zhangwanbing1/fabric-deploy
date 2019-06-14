#!/bin/bash

##########################################################
# 172.16.2.59     orderer1.csxoa.cn
# 172.16.2.60     orderer2.csxoa.cn
# 172.16.2.61     orderer3.csxoa.cn
# 172.16.2.59     peer0.org1.csxoa.cn
# 172.16.2.60     peer1.org1.csxoa.cn
# 172.16.2.61     peer0.org2.csxoa.cn
# 192.168.14.95   peer1.org2.csxoa.cn
##########################################################

##########################################################
# copy channel-artifacts and crypto-config to all node
##########################################################
#orderer1
rm nodes/ordererOrg-orderer1/channel-artifacts/* nodes/ordererOrg-orderer1/mymsp/localmsp/* -rf
cp channel-artifacts/* nodes/ordererOrg-orderer1/channel-artifacts/ -r
cp crypto-config/ordererOrganizations/csxoa.cn/orderers/orderer1.csxoa.cn/*  nodes/ordererOrg-orderer1/mymsp/localmsp/ -r
cp nodecmd.sh nodes/ordererOrg-orderer1/nodecmd

#orderer2
rm nodes/ordererOrg-orderer2/channel-artifacts/* nodes/ordererOrg-orderer2/mymsp/localmsp/* -rf
cp channel-artifacts/* nodes/ordererOrg-orderer2/channel-artifacts/ -r
cp crypto-config/ordererOrganizations/csxoa.cn/orderers/orderer2.csxoa.cn/*  nodes/ordererOrg-orderer2/mymsp/localmsp/ -r
cp nodecmd.sh nodes/ordererOrg-orderer2/nodecmd

#orderer3
rm nodes/ordererOrg-orderer3/channel-artifacts/* nodes/ordererOrg-orderer3/mymsp/localmsp/* -rf
cp channel-artifacts/* nodes/ordererOrg-orderer3/channel-artifacts/ -r
cp crypto-config/ordererOrganizations/csxoa.cn/orderers/orderer3.csxoa.cn/*  nodes/ordererOrg-orderer3/mymsp/localmsp/ -r
cp nodecmd.sh nodes/ordererOrg-orderer3/nodecmd

#org1-peer0
#rm nodes/org1-peer0/channel-artifacts/* -rf
#cp channel-artifacts/* nodes/org1-peer0/channel-artifacts/ -r
rm nodes/org1-peer0/mymsp/localmsp/* -rf
cp crypto-config/peerOrganizations/org1.csxoa.cn/peers/peer0.org1.csxoa.cn/* nodes/org1-peer0/mymsp/localmsp/ -r
cp nodecmd.sh nodes/org1-peer0/nodecmd

#org1-peer1
#rm nodes/org1-peer1/channel-artifacts/* -rf
#cp channel-artifacts/* nodes/org1-peer1/channel-artifacts/ -r
rm nodes/org1-peer1/mymsp/localmsp/* -rf
cp crypto-config/peerOrganizations/org1.csxoa.cn/peers/peer1.org1.csxoa.cn/* nodes/org1-peer1/mymsp/localmsp/ -r
cp nodecmd.sh nodes/org1-peer1/nodecmd

#org2-peer0
#rm nodes/org2-peer0/channel-artifacts/* -rf
#cp channel-artifacts/* nodes/org2-peer0/channel-artifacts/ -r
rm nodes/org2-peer0/mymsp/localmsp/* -rf
cp crypto-config/peerOrganizations/org2.csxoa.cn/peers/peer0.org2.csxoa.cn/* nodes/org2-peer0/mymsp/localmsp/ -r
cp nodecmd.sh nodes/org2-peer0/nodecmd

#org2-peer1
#rm nodes/org2-peer1/channel-artifacts/* -rf
#cp channel-artifacts/* nodes/org2-peer1/channel-artifacts/ -r
rm nodes/org2-peer1/mymsp/localmsp/* -rf
cp crypto-config/peerOrganizations/org2.csxoa.cn/peers/peer1.org2.csxoa.cn/* nodes/org2-peer1/mymsp/localmsp/ -r
cp nodecmd.sh nodes/org2-peer1/nodecmd

#client
rm nodes/client/mymsp/localmsp/* nodes/client/mymsp/orgmsp/* -rf
cp channel-artifacts/* nodes/client/channel-artifacts/ -r
cp crypto-config/peerOrganizations/org1.csxoa.cn/users/Admin@org1.csxoa.cn nodes/client/mymsp/localmsp/ -r
cp crypto-config/peerOrganizations/org2.csxoa.cn/users/Admin@org2.csxoa.cn nodes/client/mymsp/localmsp/ -r
cp crypto-config/ordererOrganizations/csxoa.cn/users/Admin@csxoa.cn nodes/client/mymsp/localmsp/ -r
mkdir -p nodes/client/mymsp/orgmsp/ordererOrganizations
cp crypto-config/ordererOrganizations/csxoa.cn/msp nodes/client/mymsp/orgmsp/ordererOrganizations/ -r
mkdir -p nodes/client/mymsp/orgmsp/org1.csxoa.cn
cp crypto-config/peerOrganizations/org1.csxoa.cn/msp nodes/client/mymsp/orgmsp/org1.csxoa.cn/ -r
mkdir -p nodes/client/mymsp/orgmsp/org2.csxoa.cn
cp crypto-config/peerOrganizations/org2.csxoa.cn/msp nodes/client/mymsp/orgmsp/org2.csxoa.cn/ -r
cp nodecmd.sh nodes/client/nodecmd


##########################################################
# distribute the node to its running host
##########################################################
scp -r nodes/ordererOrg-orderer1 blockchain@orderer1.csxoa.cn:/home/blockchain/
scp -r nodes/ordererOrg-orderer2 blockchain@orderer2.csxoa.cn:/home/blockchain/
scp -r nodes/ordererOrg-orderer3 blockchain@orderer3.csxoa.cn:/home/blockchain/
scp -r nodes/org1-peer0 blockchain@peer0.org1.csxoa.cn:/home/blockchain/
scp -r nodes/org1-peer1 blockchain@peer1.org1.csxoa.cn:/home/blockchain/
scp -r nodes/org2-peer0 blockchain@peer0.org2.csxoa.cn:/home/blockchain/
scp -r nodes/org2-peer1 blockchain@peer1.org2.csxoa.cn:/home/blockchain/
cp nodes/client /home/blockchain-deployer/ -r
