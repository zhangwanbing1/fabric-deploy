#!/bin/bash

# 172.16.2.59     orderer1.csxoa.cn
# 172.16.2.60     orderer2.csxoa.cn
# 172.16.2.61     orderer3.csxoa.cn
# 172.16.2.59     peer0.xwb.csxoa.cn
# 172.16.2.60     peer1.xwb.csxoa.cn
# 172.16.2.61     peer0.org2.csxoa.cn
# 192.168.14.95   peer1.org2.csxoa.cn

# copy channel-artifacts and crypto-config to all node
#orderer1
cp channel-artifacts crypto-config deployed/ordererOrg-orderer1/ -r
#orderer2
cp channel-artifacts crypto-config deployed/ordererOrg-orderer2/ -r
#orderer3
cp channel-artifacts crypto-config deployed/ordererOrg-orderer3/ -r
#xwb-peer0
cp channel-artifacts crypto-config deployed/xwb-peer0/ -r
#xwb-peer1
cp channel-artifacts crypto-config deployed/xwb-peer1/ -r
#org2-peer0
cp channel-artifacts crypto-config deployed/org2-peer0/ -r
#org2-peer1
cp channel-artifacts crypto-config deployed/org2-peer1/ -r
#client
cp channel-artifacts crypto-config deployed/client/ -r

# distribute the node to its running host
scp -r deployed/ordererOrg-orderer1 xxx@orderer1.csxoa.cn:/home/xxx/fabric-deploy/twoOrg
scp -r deployed/ordererOrg-orderer2 xxx@orderer2.csxoa.cn:/home/xxx/fabric-deploy/twoOrg
scp -r deployed/ordererOrg-orderer3 xxx@orderer3.csxoa.cn:/home/xxx/fabric-deploy/twoOrg

scp -r deployed/xwb-peer0 xxx@peer0.xwb.csxoa.cn:/home/xxx/fabric-deploy/twoOrg
scp -r deployed/xwb-peer1 xxx@peer1.xwb.csxoa.cn:/home/xxx/fabric-deploy/twoOrg
scp -r deployed/org2-peer0 xxx@peer0.org2.csxoa.cn:/home/xxx/fabric-deploy/twoOrg
#scp -r deployed/org2-peer2 xxx@peer1.org2.csxoa.cn:/home/xxx/fabric-deploy/twoOrg

cp deployed/org2-peer1 /home/xxx/fabric-deploy/twoOrg -r
cp deployed/client /home/xxx/fabric-deploy/twoOrg -r
cp deployed/chaincode /home/xxx/fabric-deploy/twoOrg -r