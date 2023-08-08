#!/bin/bash

. scripts/envVar.sh

export CORE_PEER_TLS_ENABLED=true
export FABRIC_CFG_PATH=../config

fetchBlock() {
  setGlobals 1
  peer channel fetch $1 block$1.pb -c mychannel --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"
  configtxlator proto_decode --input=block$1.pb --output=blocks/block$1.json --type=common.Block
  rm block$1.pb
}

fetchBlock config