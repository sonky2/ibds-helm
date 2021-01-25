#!/bin/bash +x
#
# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

#set -e

export FABRIC_ROOT=$PWD
export FABRIC_CFG_PATH=$PWD
echo  $FABRIC_ROOT

OS_ARCH=$(echo "$(uname -s|tr '[:upper:]' '[:lower:]'|sed 's/mingw64_nt.*/windows/')-$(uname -m | sed 's/x86_64/amd64/g')" | awk '{print tolower($0)}')

## Using docker-compose template replace private key file names with constants
function replacePrivateKey () {
        ARCH=`uname -s | grep Darwin`
        if [ "$ARCH" == "Darwin" ]; then
                OPTS="-it"
        else
                OPTS="-i"
        fi

        cp docker-compose-template.yaml docker-compose.yaml

        CURRENT_DIR=$PWD
        cd crypto-config/peerOrganizations/org1.chains.cloudchain.cn/ca/
        PRIV_KEY=$(ls *_sk)
        cd $CURRENT_DIR
        sed $OPTS "s/CA1_PRIVATE_KEY/${PRIV_KEY}/g" docker-compose.yaml
		
        cd crypto-config/peerOrganizations/org2.chains.cloudchain.cn/ca/
        PRIV_KEY=$(ls *_sk)
        cd $CURRENT_DIR
        sed $OPTS "s/CA2_PRIVATE_KEY/${PRIV_KEY}/g" docker-compose.yaml

        cd crypto-config/peerOrganizations/org3.chains.cloudchain.cn/ca/
        PRIV_KEY=$(ls *_sk)
        cd $CURRENT_DIR
        sed $OPTS "s/CA3_PRIVATE_KEY/${PRIV_KEY}/g" docker-compose.yaml

}

## Generates Org certs using cryptogen tool
function generateCerts (){
        CRYPTOGEN=$FABRIC_ROOT/bin/cryptogen

        if [ -f "$CRYPTOGEN" ]; then
            echo "Using cryptogen -> $CRYPTOGEN"
        else
            echo "Building cryptogen"
            make -C $FABRIC_ROOT release
        fi

        echo
        echo "##########################################################"
        echo "##### Generate certificates using cryptogen tool #########"
        echo "##########################################################"
        $CRYPTOGEN generate --config=./crypto-config.yaml
        echo
}

## Generate orderer genesis block , channel configuration transaction and anchor peer update transactions
function generateChannelArtifacts() {
        destDir=./channel-artifacts;
        if [ ! -d "$destDir" ]; then
          mkdir -p "$destDir"
        fi

        CONFIGTXGEN=$FABRIC_ROOT/bin/configtxgen
        if [ -f "$CONFIGTXGEN" ]; then
            echo "Using configtxgen -> $CONFIGTXGEN"
        else
            echo "Building configtxgen"
            make -C $FABRIC_ROOT release
        fi

        echo "##########################################################"
        echo "#########  Generating Orderer Genesis block ##############"
        echo "##########################################################"
        # Note: For some unknown reason (at least for now) the block file can't be
        # named orderer.genesis.block or the orderer will fail to launch!
        $CONFIGTXGEN -profile TwoOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block

}


generateCerts
#replacePrivateKey
generateChannelArtifacts
