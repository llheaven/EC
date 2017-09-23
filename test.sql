/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : ec3

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-09-23 18:02:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for r_ec_category
-- ----------------------------
DROP TABLE IF EXISTS `r_ec_category`;
CREATE TABLE `r_ec_category` (
  `nCategoryID` int(64) NOT NULL AUTO_INCREMENT COMMENT '商品种类ID',
  `nLevel` int(64) DEFAULT '1' COMMENT '几级类目，从一级类目开始',
  `nParentCategoryID` int(64) DEFAULT NULL COMMENT '当前商品类目所在的父类目，如果为0表示当前为一级类目。',
  `sCategoryName` varchar(64) DEFAULT NULL COMMENT '商品种类',
  `sCode` varchar(32) DEFAULT '' COMMENT '商品分类编码',
  `IsLeaf` char(1) DEFAULT '0' COMMENT '是否叶子节点: 0:否 ;1:是',
  `dCreateTime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `dUpdateTime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`nCategoryID`),
  KEY `PRIMARY_nCategoryID` (`nCategoryID`) USING BTREE COMMENT '使用分类id作为主键索引'
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8 COMMENT='商品分类';

-- ----------------------------
-- Records of r_ec_category
-- ----------------------------
INSERT INTO `r_ec_category` VALUES ('64', '1', '0', '手机', '', '0', '2017-09-23 11:20:07', '2017-09-23 11:20:07');
INSERT INTO `r_ec_category` VALUES ('65', '1', '0', '笔记本&平板', null, '0', '2017-09-23 11:25:37', '2017-09-23 11:25:37');
INSERT INTO `r_ec_category` VALUES ('66', '1', '0', '穿戴', null, '0', '2017-09-23 11:25:37', '2017-09-23 11:25:37');
INSERT INTO `r_ec_category` VALUES ('67', '1', '0', '智能家居', null, '0', '2017-09-23 11:25:37', '2017-09-23 11:25:37');
INSERT INTO `r_ec_category` VALUES ('68', '1', '0', '通用配件', null, '0', '2017-09-23 11:25:37', '2017-09-23 11:25:37');
INSERT INTO `r_ec_category` VALUES ('69', '1', '0', '专属配件', null, '0', '2017-09-23 11:25:37', '2017-09-23 11:25:37');
INSERT INTO `r_ec_category` VALUES ('70', '2', '64', '荣耀', null, '0', '2017-09-23 13:42:29', '2017-09-23 13:42:29');
INSERT INTO `r_ec_category` VALUES ('71', '2', '64', 'HUAWEI P系列', null, '0', '2017-09-23 13:42:29', '2017-09-23 13:42:29');
INSERT INTO `r_ec_category` VALUES ('72', '2', '64', '荣耀畅玩系列', null, '0', '2017-09-23 13:42:29', '2017-09-23 13:42:29');
INSERT INTO `r_ec_category` VALUES ('73', '2', '64', 'HUAWEI Mate系列', null, '0', '2017-09-23 13:42:29', '2017-09-23 13:42:29');
INSERT INTO `r_ec_category` VALUES ('74', '2', '64', 'HUAWEI nova系列', null, '0', '2017-09-23 13:42:29', '2017-09-23 13:42:29');
INSERT INTO `r_ec_category` VALUES ('75', '2', '64', 'HUAWEI 麦芒系列', null, '0', '2017-09-23 13:42:29', '2017-09-23 13:42:29');
INSERT INTO `r_ec_category` VALUES ('76', '2', '64', '华为畅享系列', null, '0', '2017-09-23 13:42:29', '2017-09-23 13:42:29');
INSERT INTO `r_ec_category` VALUES ('77', '2', '64', '合约机', null, '0', '2017-09-23 13:42:29', '2017-09-23 13:42:29');
INSERT INTO `r_ec_category` VALUES ('78', '2', '65', '平板电脑', null, '0', '2017-09-23 13:44:50', '2017-09-23 13:44:50');
INSERT INTO `r_ec_category` VALUES ('79', '2', '65', '笔记本电脑', null, '0', '2017-09-23 13:44:50', '2017-09-23 13:44:50');
INSERT INTO `r_ec_category` VALUES ('80', '2', '65', '笔记本配件', null, '0', '2017-09-23 13:44:50', '2017-09-23 13:44:50');
INSERT INTO `r_ec_category` VALUES ('81', '2', '66', '手环', null, '0', '2017-09-23 13:46:31', '2017-09-23 13:46:31');
INSERT INTO `r_ec_category` VALUES ('82', '2', '66', '手表', null, '0', '2017-09-23 13:46:31', '2017-09-23 13:46:31');
INSERT INTO `r_ec_category` VALUES ('83', '2', '67', '字母路由', null, '0', '2017-09-23 13:48:08', '2017-09-23 13:48:08');
INSERT INTO `r_ec_category` VALUES ('84', '2', '67', '电视盒子', null, '0', '2017-09-23 13:48:08', '2017-09-23 13:48:08');
INSERT INTO `r_ec_category` VALUES ('85', '2', '67', '路由器', null, '0', '2017-09-23 13:48:08', '2017-09-23 13:48:08');
INSERT INTO `r_ec_category` VALUES ('86', '2', '67', '电力猫', null, '0', '2017-09-23 13:48:08', '2017-09-23 13:48:08');
INSERT INTO `r_ec_category` VALUES ('87', '2', '67', '随行wifi', null, '0', '2017-09-23 13:48:08', '2017-09-23 13:48:08');
INSERT INTO `r_ec_category` VALUES ('88', '2', '67', 'HUAWEI HILink生态产品', null, '0', '2017-09-23 13:48:08', '2017-09-23 13:48:08');
INSERT INTO `r_ec_category` VALUES ('89', '2', '68', '移动电源', null, '0', '2017-09-23 13:51:19', '2017-09-23 13:51:19');
INSERT INTO `r_ec_category` VALUES ('90', '2', '68', '耳机', null, '0', '2017-09-23 13:51:19', '2017-09-23 13:51:19');
INSERT INTO `r_ec_category` VALUES ('91', '2', '68', '充电器/线材', null, '0', '2017-09-23 13:51:19', '2017-09-23 13:51:19');
INSERT INTO `r_ec_category` VALUES ('92', '2', '68', '自拍杆/支架', null, '0', '2017-09-23 13:51:19', '2017-09-23 13:51:19');
INSERT INTO `r_ec_category` VALUES ('93', '2', '68', '音箱', null, '0', '2017-09-23 13:51:19', '2017-09-23 13:51:19');
INSERT INTO `r_ec_category` VALUES ('94', '2', '68', 'U盘/存储卡', null, '0', '2017-09-23 13:51:19', '2017-09-23 13:51:19');
INSERT INTO `r_ec_category` VALUES ('95', '2', '68', '插排', null, '0', '2017-09-23 13:51:19', '2017-09-23 13:51:19');
INSERT INTO `r_ec_category` VALUES ('96', '2', '68', '摄像机/镜头', null, '0', '2017-09-23 13:51:19', '2017-09-23 13:51:19');
INSERT INTO `r_ec_category` VALUES ('97', '2', '68', '智能硬件', null, '0', '2017-09-23 13:51:19', '2017-09-23 13:51:19');
INSERT INTO `r_ec_category` VALUES ('98', '2', '68', '生活周边', null, '0', '2017-09-23 13:51:19', '2017-09-23 13:51:19');
INSERT INTO `r_ec_category` VALUES ('99', '2', '69', '保护壳', null, '0', '2017-09-23 13:52:51', '2017-09-23 13:52:51');
INSERT INTO `r_ec_category` VALUES ('100', '2', '69', '保护套', null, '0', '2017-09-23 13:52:51', '2017-09-23 13:52:51');
INSERT INTO `r_ec_category` VALUES ('101', '2', '69', '贴膜', null, '0', '2017-09-23 13:52:51', '2017-09-23 13:52:51');
INSERT INTO `r_ec_category` VALUES ('102', '2', '69', '盒子专属配件', null, '0', '2017-09-23 13:52:51', '2017-09-23 13:52:51');
INSERT INTO `r_ec_category` VALUES ('103', '2', '69', '表带', null, '0', '2017-09-23 13:52:51', '2017-09-23 13:52:51');
