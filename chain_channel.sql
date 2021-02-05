
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for chain_channel
-- ----------------------------
DROP TABLE IF EXISTS `chain_channel`;
CREATE TABLE `chain_channel`  (
  `CHANNEL_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '链ID',
  `CHANNEL_NAME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '链名称',
  `CHANNEL_DESC` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '链描述',
  `UPDATE_TIME` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CHANNEL_STATUS` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '链状态（0不可用，1可用，2弃用）',
  `ENDORSERS` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`CHANNEL_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chain_channel
-- ----------------------------
INSERT INTO `chain_channel` VALUES ('channel_id_trace1', 'trace1', '基础链', '2018-01-30 03:11:28', '1', 'peerOrg1,peerOrg2,peerOrg3,peerOrg4');
INSERT INTO `chain_channel` VALUES ('channel_id_trace2', 'trace2', '检测链', '2018-07-17 03:11:28', '1', 'peerOrg1,peerOrg2,peerOrg3,peerOrg4');
INSERT INTO `chain_channel` VALUES ('channel_id_trace3', 'trace3', '鉴真链', '2018-07-17 03:11:28', '1', 'peerOrg1,peerOrg2,peerOrg3,peerOrg4');

-- ----------------------------
-- Table structure for chain_channel_peer
-- ----------------------------
DROP TABLE IF EXISTS `chain_channel_peer`;
CREATE TABLE `chain_channel_peer`  (
  `CHANNEL_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `PEER_ID` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`CHANNEL_ID`, `PEER_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chain_channel_peer
-- ----------------------------
INSERT INTO `chain_channel_peer` VALUES ('channel_id_trace1', 'peer_id_peer0-org1-example-com');
INSERT INTO `chain_channel_peer` VALUES ('channel_id_trace1', 'peer_id_peer0-org2-example-com');
INSERT INTO `chain_channel_peer` VALUES ('channel_id_trace1', 'peer_id_peer0-org3-example-com');
INSERT INTO `chain_channel_peer` VALUES ('channel_id_trace2', 'peer_id_peer0-org1-example-com');
INSERT INTO `chain_channel_peer` VALUES ('channel_id_trace2', 'peer_id_peer0-org2-example-com');
INSERT INTO `chain_channel_peer` VALUES ('channel_id_trace2', 'peer_id_peer0-org3-example-com');
INSERT INTO `chain_channel_peer` VALUES ('channel_id_trace3', 'peer_id_peer0-org1-example-com');
INSERT INTO `chain_channel_peer` VALUES ('channel_id_trace3', 'peer_id_peer0-org2-example-com');
INSERT INTO `chain_channel_peer` VALUES ('channel_id_trace3', 'peer_id_peer0-org3-example-com');

-- ----------------------------
-- Table structure for chain_organ
-- ----------------------------
DROP TABLE IF EXISTS `chain_organ`;
CREATE TABLE `chain_organ`  (
  `ORGAN_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '组织ID',
  `ORGAN_NAME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '组织名称',
  `ORGAN_DESC` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '组织描述',
  `ORGAN_DOMAIN` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '组织域名',
  `MSP_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '成员服务提供商ID',
  `CA_LOCATION` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'CA地址',
  `ORDERER_LOCATIONS` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'ORDER节点地址',
  `UPDATE_TIME` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`ORGAN_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chain_organ
-- ----------------------------
INSERT INTO `chain_organ` VALUES ('organ_id_peerOrg1', 'peerOrg1', '浪潮', 'org1-example-com', 'Org1MSP', 'http://ca-org1-example-com:7054', 'orderer0-example-com@grpc://orderer0-example-com:7050', '2018-07-17 02:48:13');
INSERT INTO `chain_organ` VALUES ('organ_id_peerOrg2', 'peerOrg2', '学会', 'org2-example-com', 'Org2MSP', 'http://ca-org2-example-com:7054', 'orderer0-example-com@grpc://orderer0-example-com:7050', '2018-07-17 02:48:13');
INSERT INTO `chain_organ` VALUES ('organ_id_peerOrg3', 'peerOrg3', '企业', 'org3-example-com', 'Org3MSP', 'http://ca-org3-example-com:7054', 'orderer0-example-com@grpc://orderer0-example-com:7050', '2018-07-17 02:48:13');

-- ----------------------------
-- Table structure for chain_peer
-- ----------------------------
DROP TABLE IF EXISTS `chain_peer`;
CREATE TABLE `chain_peer`  (
  `PEER_ID` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'PEER节点ID',
  `PEER_NAME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'PEER节点名称',
  `PEER_IP` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'PEER节点IP',
  `ORGAN_NAME` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '所属组织',
  `CHANNEL_NAME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '所属链',
  `PEER_LOCATION` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'PEER地址',
  `EVENTHUB_LOCATION` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '事件总线地址',
  `UPDATE_TIME` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`PEER_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chain_peer
-- ----------------------------
INSERT INTO `chain_peer` VALUES ('peer_id_peer0-org1-example-com', 'peer0-org1-example-com', 'peer0-org1-example-com', 'peerOrg1', NULL, 'peer0-org1-example-com@grpc://peer0-org1-example-com:7051', 'peer0-org1-example-com@grpc://peer0-org1-example-com:7053', '2018-07-17 02:33:25');
INSERT INTO `chain_peer` VALUES ('peer_id_peer0-org2-example-com', 'peer0-org2-example-com', 'peer0-org2-example-com', 'peerOrg2', NULL, 'peer0-org2-example-com@grpc://peer0-org2-example-com:7051', 'peer0-org2-example-com@grpc://peer0-org2-example-com:7053', '2018-07-17 02:33:25');
INSERT INTO `chain_peer` VALUES ('peer_id_peer0-org3-example-com', 'peer0-org3-example-com', 'peer0-org3-example-com', 'peerOrg3', NULL, 'peer0-org3-example-com@grpc://peer0-org3-example-com:7051', 'peer0-org3-example-com@grpc://peer0-org3-example-com:7053', '2018-07-17 02:33:25');

SET FOREIGN_KEY_CHECKS = 1;
