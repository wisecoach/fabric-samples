. scripts/utils.sh
# 断点级别
# 0：不停顿
# 1：仅大步骤停顿，如./network up
# 2：大步骤下的大的停顿，如./network up下最重要的createOrgs
# 3：更细的步骤
# 4：最细的停顿
export CHECKPOINT_LEVEL=0
echo '
# 关闭网络，清空产生的文件
'
checkpoint 1
./network.sh down
echo '
# 启动网络，我们采用ca的方式创建证书，并启动couchdb作为状态数据库。它的大致流程为：
# 1. 启动各个组织的fabric-ca的docker节点
# 2. 向各个组织的fabric-ca节点注册CA证书，包括一个peer证书、admin证书、client证书，特别要注意期间产生了哪些文件，这里会出现了文件夹级别的MSP
# 3. 启动orderer、peer节点，挂载上对应的MSP文件夹
'
checkpoint 1
./network.sh up -ca -s couchdb
echo '
# 创建通道。它的大致流程为：
# 1. 创建创世区块
# 2. 根据创世区块创建通道
# 3. peer节点加入到通道
# 4. 修改通道配置，将各个组织的锚节点配置到组织配置中
'
checkpoint 1
./network.sh createChannel
echo '
# 部署链码。它的大致流程为：
# 1. 安装依赖，go用go mod vendor，javascript用npm install，java用gradlew installDist
'
checkpoint 1
./network.sh deployCC  -ccn basic -ccp "../asset-transfer-basic/chaincode-java/" -ccl java