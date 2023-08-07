./network.sh down
./network.sh up -ca
./network.sh createChannel
./network.sh deployCC  -ccn basic -ccp ../asset-transfer-basic/chaincode-java/ -ccl java