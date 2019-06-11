#!/bin/bash

# 172.16.2.59     orderer1.csxoa.cn
# 172.16.2.60     orderer2.csxoa.cn
# 172.16.2.61     orderer3.csxoa.cn
# 172.16.2.59     peer0.org1.csxoa.cn
# 172.16.2.60     peer1.org1.csxoa.cn
# 172.16.2.61     peer0.org2.csxoa.cn
# 192.168.14.95   peer1.org2.csxoa.cn

# copy channel-artifacts and crypto-config to all node
#orderer1
rm deployed/ordererOrg-orderer1/channel-artifacts/* deployed/ordererOrg-orderer1/mymsp/localmsp/* -rf
cp channel-artifacts/* deployed/ordererOrg-orderer1/channel-artifacts/ -r
cp crypto-config/ordererOrganizations/csxoa.cn/orderers/orderer1.csxoa.cn/*  deployed/ordererOrg-orderer1/mymsp/localmsp/ -r
#orderer2
rm deployed/ordererOrg-orderer2/channel-artifacts/* deployed/ordererOrg-orderer2/mymsp/localmsp/* -rf
cp channel-artifacts/* deployed/ordererOrg-orderer2/channel-artifacts/ -r
cp crypto-config/ordererOrganizations/csxoa.cn/orderers/orderer2.csxoa.cn/*  deployed/ordererOrg-orderer2/mymsp/localmsp/ -r
#orderer3
rm deployed/ordererOrg-orderer3/channel-artifacts/* deployed/ordererOrg-orderer3/mymsp/localmsp/* -rf
cp channel-artifacts/* deployed/ordererOrg-orderer3/channel-artifacts/ -r
cp crypto-config/ordererOrganizations/csxoa.cn/orderers/orderer3.csxoa.cn/*  deployed/ordererOrg-orderer3/mymsp/localmsp/ -r

#org1-peer0
#rm deployed/org1-peer0/channel-artifacts/* -rf
#cp channel-artifacts/* deployed/org1-peer0/channel-artifacts/ -r
rm deployed/org1-peer0/mymsp/localmsp/* -rf
cp crypto-config/peerOrganizations/org1.csxoa.cn/peers/peer0.org1.csxoa.cn/* deployed/org1-peer0/mymsp/localmsp/ -r
#org1-peer1
#rm deployed/org1-peer1/channel-artifacts/* -rf
#cp channel-artifacts/* deployed/org1-peer1/channel-artifacts/ -r
rm deployed/org1-peer1/mymsp/localmsp/* -rf
cp crypto-config/peerOrganizations/org1.csxoa.cn/peers/peer1.org1.csxoa.cn/* deployed/org1-peer1/mymsp/localmsp/ -r

#org2-peer0
#rm deployed/org2-peer0/channel-artifacts/* -rf
#cp channel-artifacts/* deployed/org2-peer0/channel-artifacts/ -r
rm deployed/org2-peer0/mymsp/localmsp/* -rf
cp crypto-config/peerOrganizations/org2.csxoa.cn/peers/peer0.org2.csxoa.cn/* deployed/org2-peer0/mymsp/localmsp/ -r
#org2-peer1
#rm deployed/org2-peer1/channel-artifacts/* -rf
#cp channel-artifacts/* deployed/org2-peer1/channel-artifacts/ -r
rm deployed/org2-peer1/mymsp/localmsp/* -rf
cp crypto-config/peerOrganizations/org2.csxoa.cn/peers/peer1.org2.csxoa.cn/* deployed/org2-peer1/mymsp/localmsp/ -r

#client
rm deployed/client/mymsp/localmsp/* deployed/client/mymsp/orgmsp/* -rf
cp channel-artifacts/* deployed/client/channel-artifacts/ -r
cp crypto-config/peerOrganizations/org1.csxoa.cn/users/Admin@org1.csxoa.cn deployed/client/mymsp/localmsp/ -r
cp crypto-config/peerOrganizations/org2.csxoa.cn/users/Admin@org2.csxoa.cn deployed/client/mymsp/localmsp/ -r
mkdir -p deployed/client/mymsp/orgmsp/ordererOrganizations
cp crypto-config/ordererOrganizations/csxoa.cn/msp deployed/client/mymsp/orgmsp/ordererOrganizations/ -r
mkdir -p deployed/client/mymsp/orgmsp/org1.csxoa.cn
cp crypto-config/peerOrganizations/org1.csxoa.cn/msp deployed/client/mymsp/orgmsp/org1.csxoa.cn/ -r
mkdir -p deployed/client/mymsp/orgmsp/org2.csxoa.cn
cp crypto-config/peerOrganizations/org2.csxoa.cn/msp deployed/client/mymsp/orgmsp/org2.csxoa.cn/ -r


# distribute the node to its running host
scp -r deployed/ordererOrg-orderer1 xxx@orderer1.csxoa.cn:/home/xxx/fabric-deploy/twoOrg
scp -r deployed/ordererOrg-orderer2 xxx@orderer2.csxoa.cn:/home/xxx/fabric-deploy/twoOrg
scp -r deployed/ordererOrg-orderer3 xxx@orderer3.csxoa.cn:/home/xxx/fabric-deploy/twoOrg

scp -r deployed/org1-peer0 xxx@peer0.org1.csxoa.cn:/home/xxx/fabric-deploy/twoOrg
scp -r deployed/org1-peer1 xxx@peer1.org1.csxoa.cn:/home/xxx/fabric-deploy/twoOrg
scp -r deployed/org2-peer0 xxx@peer0.org2.csxoa.cn:/home/xxx/fabric-deploy/twoOrg
#scp -r deployed/org2-peer1 xxx@peer1.org2.csxoa.cn:/home/xxx/fabric-deploy/twoOrg

cp deployed/org2-peer1 /home/xxx/fabric-deploy/twoOrg -r
cp deployed/client /home/xxx/fabric-deploy/twoOrg -r
cp deployed/chaincode /home/xxx/fabric-deploy/twoOrg -r