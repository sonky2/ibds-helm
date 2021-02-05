#!/bin/bash +x
#
# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

#set -e

CURRENT_DIR=$PWD;
destDir=./helm;
if [ ! -d "$destDir" ]; then
  mkdir -p "$destDir"
fi
echo "当前执行名录是："${CURRENT_DIR};

## Create Peer Config Files

cp  ${destDir}/values-template.yaml  ${destDir}/values.yaml;
for k in $(seq 1 $1)
do
  ORG_NO=org${k};

  echo "#############################################################"
  echo "##### replace ${ORG_NO}.example.com  *_sk  in values.yaml#########"
  echo "#############################################################"
  cd  ./crypto-config/peerOrganizations/${ORG_NO}-example-com/ca/;
  PRIV_KEY=$(ls *_sk)

  cd $CURRENT_DIR;
  sed -i "s/CA_FILE_NAME${k}/${PRIV_KEY}/g" ${destDir}/values.yaml;
  
done;
