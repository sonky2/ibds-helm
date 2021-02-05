# ibds-helm
## fabric on helm

### start

* cd /path/to/fabric-on-helm
* helm install myhelm ./helm

## attention

一、generateArtifacts_1.sh

	根据orderer、org、peer个数修改crypto-config.yaml、configtx.yaml，之后执行./generateArtifacts_1.sh。生成./crypto-config下的密钥证书，./channel-artifacts/genesis.block
	
二、generateChannel_2.sh   3   //参数为组织（org）个数

	生成trace1.tx、trace2.tx、trace3.tx通道配置文件，为每个通道中为每个组织生成一个锚节点配置文件${CHANNEL_NAME}${ORG_B_NO}MSPanchors.tx。参数为组织个数
	
三、modifyValues_3.sh    3     //参数为组织（org）个数

	根据values-template.yaml生成values.yaml文件，并自动化替换values.yaml文件中每个组织（org）的caFileName

四、helm install myhelm ./helm

	启动区块链底层网络
	
五、./scripts/channel_Anchors.sh	3   //参数为组织（org）个数

	进入cli容器中，执行./scripts/channel_Anchors.sh  3，创建trace1.tx、trace2.tx、trace3.tx三个通道，并加入通道，更新锚节点
	
六、 ./scripts/qc-trace-n-cunzheng.sh  $CHANNEL_NAME

	进入cli容器中，部署存证等链码
	
七、部署IBDS（mysql、redis、tomcat、nginx）
	
	1）chain_channel.sql为数据库替换文件
	2）应用后台修改application.yml、redis.properties
	3）应前端修改连接后台域名
	4）nginx配置文件及cors-include.conf