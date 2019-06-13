#!/bin/bash

#pull images
function pull_images() {
    sudo docker pull ulord/fabric-baseos:arm64-0.4.15
    sudo docker pull ulord/fabric-basejvm:arm64-0.4.15
    sudo docker pull ulord/fabric-baseimage:arm64-0.4.15
    sudo docker pull ulord/fabric-couchdb:arm64-0.4.15

    sudo docker pull ulord/fabric-buildenv:arm64-1.4.1
    sudo docker pull ulord/fabric-peer:arm64-1.4.1    
    sudo docker pull ulord/fabric-orderer:arm64-1.4.1
    sudo docker pull ulord/fabric-ca:arm64-1.4.1
    sudo docker pull ulord/fabric-ccenv:arm64-1.4.1
    sudo docker pull ulord/fabric-tools:arm64-1.4.1
}


#rename image tag
function rename_tagname() {
    sudo docker tag ulord/fabric-baseos:arm64-0.4.15 hyperledger/fabric-baseos:arm64-0.4.15
    sudo docker tag ulord/fabric-basejvm:arm64-0.4.15 hyperledger/fabric-basejvm:arm64-0.4.15
    sudo docker tag ulord/fabric-baseimage:arm64-0.4.15 hyperledger/fabric-baseimage:arm64-0.4.15
    sudo docker tag ulord/fabric-couchdb:arm64-0.4.15 hyperledger/fabric-couchdb:arm64-0.4.15
    sudo docker tag ulord/fabric-buildenv:arm64-1.4.1 hyperledger/fabric-buildenv:1.4.1
    sudo docker tag ulord/fabric-peer:arm64-1.4.1 hyperledger/fabric-peer:1.4.1
    sudo docker tag ulord/fabric-orderer:arm64-1.4.1 hyperledger/fabric-orderer:1.4.1
    sudo docker tag ulord/fabric-ca:arm64-1.4.1 hyperledger/fabric-ca:1.4.1
    sudo docker tag ulord/fabric-ccenv:arm64-1.4.1 hyperledger/fabric-ccenv:1.4.1
    sudo docker tag ulord/fabric-tools:arm64-1.4.1 hyperledger/fabric-tools:1.4.1
}

#pull_images
rename_tagname
