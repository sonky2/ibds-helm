#!/bin/bash

#set -e

export FABRIC_ROOT=$PWD
export FABRIC_CFG_PATH=$PWD
orgs=$1
echo

OS_ARCH=$(echo "$(uname -s|tr '[:upper:]' '[:lower:]'|sed 's/mingw64_nt.*/windows/')-$(uname -m | sed 's/x86_64/amd64/g')" | awk '{print tolower($0)}')

CONFIGTXGEN=$FABRIC_ROOT/bin/configtxgen
if [ -f "$CONFIGTXGEN" ]; then
   echo "Using configtxgen -> $CONFIGTXGEN"
else
   echo "Building configtxgen"
   make -C $FABRIC_ROOT release
fi

function generateChannelArtifacts() {
        echo
        echo "#################################################################"
        echo "### Generating channel configuration transaction '$CHANNEL_NAME.tx' ###"
        echo "#################################################################"
        $CONFIGTXGEN -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/$CHANNEL_NAME.tx -channelID $CHANNEL_NAME

    for j in $(seq 1  ${orgs})
    do
        ORG_B_NO=Org${j};
        echo
        echo "#################################################################"
        echo "#######    Generating anchor peer update for Org1MSP   '${CHANNEL_NAME}${ORG_B_NO}MSPanchors.tx'  ##########"
        echo "#################################################################"
        $CONFIGTXGEN -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/${CHANNEL_NAME}${ORG_B_NO}MSPanchors.tx -channelID $CHANNEL_NAME -asOrg ${ORG_B_NO}MSP
    done

}

for k in $(seq 1 3)
do
  CHANNEL_NAME=trace${k}
  generateChannelArtifacts
done

