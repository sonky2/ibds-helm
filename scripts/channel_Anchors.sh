#!/bin/bash

#set -e

orgs=$1

function joinChannel_updateAnchors() {
        echo
        echo "#################################################################"
        echo "### Create channel  '$CHANNEL_NAME' ###"
        echo "#################################################################"
		cd /opt/gopath/src/github.com/hyperledger/fabric/peer
        peer channel create -o orderer0-example-com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/$CHANNEL_NAME.tx  --tls true --cafile $ORDER_TLS_CA

    for j in $(seq 1  ${orgs})
    do
        ORG_B_NO=Org${j};

		export CORE_PEER_LOCALMSPID="Org${j}MSP"
		export CORE_PEER_ADDRESS=peer0-org${j}-example-com:7051
		export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org${j}-example-com/peers/peer0-org${j}-example-com/tls/ca.crt
		export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org${j}-example-com/users/Admin@org${j}-example-com/msp
		export ORDER_TLS_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example-com/orderers/orderer0-example-com/msp/tlscacerts/tlsca.example-com-cert.pem
		
        echo
        echo "#################################################################"
        echo "#######   peer0-Org${j} join  '${CHANNEL_NAME}'  and   update ${CHANNEL_NAME}${CORE_PEER_LOCALMSPID}anchors.tx ##########"
        echo "#################################################################"				
		peer channel join -b $CHANNEL_NAME.block
		peer channel update -o orderer0-example-com:7050 -c ${CHANNEL_NAME} -f ./channel-artifacts/${CHANNEL_NAME}${CORE_PEER_LOCALMSPID}anchors.tx --tls true --cafile $ORDER_TLS_CA
    done

}

for k in $(seq 1 3)
do
  CHANNEL_NAME=trace${k}
  joinChannel_updateAnchors
done

