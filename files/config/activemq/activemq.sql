/*
Navicat MySQL Data Transfer

Source Server         : liuzd0505.mysql.rds.aliyuncs.com
Source Server Version : 50518
Source Host           : liuzd0505.mysql.rds.aliyuncs.com:3306
Source Database       : oms

Target Server Type    : MYSQL
Target Server Version : 50518
File Encoding         : 65001

Date: 2015-06-29 09:42:55
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for activemq_acks
-- ----------------------------
DROP TABLE IF EXISTS `activemq_acks`;
CREATE TABLE `activemq_acks` (
  `CONTAINER` varchar(250) NOT NULL,
  `SUB_DEST` varchar(250) DEFAULT NULL,
  `CLIENT_ID` varchar(250) NOT NULL,
  `SUB_NAME` varchar(250) NOT NULL,
  `SELECTOR` varchar(250) DEFAULT NULL,
  `LAST_ACKED_ID` bigint(20) DEFAULT NULL,
  `PRIORITY` bigint(20) NOT NULL DEFAULT '5',
  `XID` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`CONTAINER`,`CLIENT_ID`,`SUB_NAME`,`PRIORITY`),
  KEY `ACTIVEMQ_ACKS_XIDX` (`XID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for activemq_lock
-- ----------------------------
DROP TABLE IF EXISTS `activemq_lock`;
CREATE TABLE `activemq_lock` (
  `ID` bigint(20) NOT NULL,
  `TIME` bigint(20) DEFAULT NULL,
  `BROKER_NAME` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for activemq_msgs
-- ----------------------------
DROP TABLE IF EXISTS `activemq_msgs`;
CREATE TABLE `activemq_msgs` (
  `ID` bigint(20) NOT NULL COMMENT '消息ID',
  `CONTAINER` varchar(250) DEFAULT NULL COMMENT '消息容器',
  `MSGID_PROD` varchar(250) DEFAULT NULL  COMMENT '消息生产者信息',
  `MSGID_SEQ` bigint(20) DEFAULT NULL COMMENT '消息顺序',
  `EXPIRATION` bigint(20) DEFAULT NULL COMMENT '消息超时时长',
  `MSG` longblob COMMENT '消息体',
  `PRIORITY` bigint(20) DEFAULT NULL COMMENT '优先级',
  `XID` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ACTIVEMQ_MSGS_MIDX` (`MSGID_PROD`,`MSGID_SEQ`),
  KEY `ACTIVEMQ_MSGS_CIDX` (`CONTAINER`),
  KEY `ACTIVEMQ_MSGS_EIDX` (`EXPIRATION`),
  KEY `ACTIVEMQ_MSGS_PIDX` (`PRIORITY`),
  KEY `ACTIVEMQ_MSGS_XIDX` (`XID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

