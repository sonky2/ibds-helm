#!/bin/bash +x
#
# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

#set -e

CURRENT_DIR=$PWD;
destDir=./compose-config;
if [ ! -d "$destDir" ]; then
  mkdir -p "$destDir"
fi
echo "当前执行名录是："${CURRENT_DIR};

## Create Orderer Config Files
for k in $(seq 0 `expr $1 - 1`)
do
  ORDERER_NO=orderer${k};
  cp  template-orderer.yaml  ${destDir}/docker-compose-${ORDERER_NO}.yaml;
  echo "##########################################################"
  echo "##### create  ${ORDERER_NO}.example.com  config  #########"
  echo "##########################################################"

  cd $CURRENT_DIR;
  sed -i "s/ORDERER_NO/${ORDERER_NO}/g" ${destDir}/docker-compose-${ORDERER_NO}.yaml;
done;


## Create Peer Config Files
for j in $(seq 1 $2)
do
  ORG_NO=org${j};
  ORG_B_NO=Org${j};
  PURE_NO=${j};

  cp  template-peer.yaml  ${destDir}/docker-compose-${ORG_NO}-peer0.yaml;
  echo "##########################################################"
  echo "##### replace ${ORG_NO}.example.com  *_sk  #########"
  echo "##########################################################"
  cd  ./crypto-config/peerOrganizations/${ORG_NO}.example.com/ca/;
  PRIV_KEY=$(ls *_sk)

  cd $CURRENT_DIR;
  sed -i "s/CA_PRIVATE_KEY/${PRIV_KEY}/g" ${destDir}/docker-compose-${ORG_NO}-peer0.yaml;
  sed -i "s/ORG_NO/${ORG_NO}/g"           ${destDir}/docker-compose-${ORG_NO}-peer0.yaml;
  sed -i "s/ORG_B_NO/${ORG_B_NO}/g"       ${destDir}/docker-compose-${ORG_NO}-peer0.yaml;
  sed -i "s/PURE_NO/${PURE_NO}/g"         ${destDir}/docker-compose-${ORG_NO}-peer0.yaml;
done;
