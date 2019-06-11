#!/bin/bash

export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/localmsp/Admin@org1.csxoa.cn/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/localmsp/Admin@org1.csxoa.cn/msp
export CORE_PEER_ADDRESS=peer0.org1.csxoa.cn:7051

# Installing chaincode on peer0.org1...
peer chaincode install -n oacc -v 1.0 -l golang -p github.com/chaincode/oachaincode/go/


export CORE_PEER_ADDRESS=peer0.org1.csxoa.cn:7051

# Installing chaincode on peer1.org1...
peer chaincode install -n oacc -v 1.0 -l golang -p github.com/chaincode/oachaincode/go/

# Instantiating chaincode on peer1.org1...
peer chaincode instantiate -o orderer1.csxoa.cn:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/orgmsp/ordererOrganizations/msp/tlscacerts/tlsca.csxoa.cn-cert.pem -C oachannel -n oacc -l golang -v 1
.0 -c '{"Args":[""}' -P 'AND ('\''Org1MSP.peer'\'')'