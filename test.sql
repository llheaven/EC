/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : ec3

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-09-23 18:02:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for r_ec_spu
-- ----------------------------
DROP TABLE IF EXISTS `r_ec_spu`;
CREATE TABLE `r_ec_spu` (
  `nSPUID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `sSPUBriefName` varchar(50) NOT NULL DEFAULT '' COMMENT ' 简称',
  `sSPUName` varchar(64) NOT NULL DEFAULT '' COMMENT '商品名称',
  `sMetaKeywords` varchar(255) NOT NULL DEFAULT '' COMMENT '商品关键字用于模糊检索',
  `nCategoryID` bigint(64) NOT NULL DEFAULT '0' COMMENT '商品种类ID,值为0表示未进行分类',
  `nBrandID` bigint(64) NOT NULL DEFAULT '0' COMMENT '品牌ID,值为0表示没有品牌',
  `nImageID` bigint(64) NOT NULL DEFAULT '0' COMMENT 'Image ID,,值为0表示没有展示图片',
  `sDescription` varchar(2000) NOT NULL DEFAULT '' COMMENT '描述信息',
  `sCode` varchar(20) NOT NULL DEFAULT '' COMMENT '商品编码',
  `sIsVirtual` char(1) NOT NULL DEFAULT '0' COMMENT '是否为虚拟商品: 0:实物商品;1:虚拟商品',
  `dCreateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `dUpdateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`nSPUID`),
  KEY `PRIMARY_nProductID` (`nSPUID`) USING BTREE COMMENT ' 使用产品id作为主键索引'
) ENGINE=InnoDB AUTO_INCREMENT=645 DEFAULT CHARSET=utf8 COMMENT='商品信息';

-- ----------------------------
-- Records of r_ec_spu
-- ----------------------------
INSERT INTO `r_ec_spu` VALUES ('544', '荣耀V9 play', '荣耀v9 play', '荣耀 v9 play', '70', '5', '0', '', '', '0', '2017-09-23 14:05:09', '2017-09-23 14:05:09');
INSERT INTO `r_ec_spu` VALUES ('545', '荣耀V8', '荣耀V8', '荣耀 V8', '70', '5', '0', '', '', '0', '2017-09-23 14:12:47', '2017-09-23 14:12:47');
INSERT INTO `r_ec_spu` VALUES ('546', '荣耀9', '荣耀9', '荣耀 9', '70', '5', '0', '', '', '0', '2017-09-23 14:12:47', '2017-09-23 14:12:47');
INSERT INTO `r_ec_spu` VALUES ('547', '荣耀9', '【广东电信赠费】荣耀9', '荣耀 9', '70', '5', '0', '', '', '0', '2017-09-23 14:12:47', '2017-09-23 14:12:47');
INSERT INTO `r_ec_spu` VALUES ('548', '荣耀8青春版', '荣耀8青春版', '荣耀 8 青春版', '70', '5', '0', '', '', '0', '2017-09-23 14:12:47', '2017-09-23 14:12:47');
INSERT INTO `r_ec_spu` VALUES ('549', '荣耀V9', '荣耀V9', '荣耀 V9', '70', '5', '0', '', '', '0', '2017-09-23 14:12:47', '2017-09-23 14:12:47');
INSERT INTO `r_ec_spu` VALUES ('550', '荣耀8', '荣耀8', '荣耀 8', '70', '5', '0', '', '', '0', '2017-09-23 14:12:47', '2017-09-23 14:12:47');
INSERT INTO `r_ec_spu` VALUES ('551', '荣耀Note8', '荣耀Note8', '荣耀 Note8', '70', '5', '0', '', '', '0', '2017-09-23 14:12:47', '2017-09-23 14:12:47');
INSERT INTO `r_ec_spu` VALUES ('559', 'HUAWEI P10', 'HUAWEI P10', 'HUAWEI P10', '71', '4', '0', '', '', '0', '2017-09-23 14:14:31', '2017-09-23 14:14:31');
INSERT INTO `r_ec_spu` VALUES ('560', 'HUAWEI P10 Plus', 'HUAWEI P10 Plus', 'HUAWEI P10 Plus', '71', '4', '0', '', '', '0', '2017-09-23 14:14:31', '2017-09-23 14:14:31');
INSERT INTO `r_ec_spu` VALUES ('561', '荣耀畅玩6', '荣耀畅玩6', '荣耀畅玩6', '72', '5', '0', '', '', '0', '2017-09-23 14:16:48', '2017-09-23 14:16:48');
INSERT INTO `r_ec_spu` VALUES ('562', '荣耀畅玩6X', '荣耀畅玩6X', '荣耀畅玩6X', '72', '5', '0', '', '', '0', '2017-09-23 14:16:48', '2017-09-23 14:16:48');
INSERT INTO `r_ec_spu` VALUES ('563', '荣耀畅玩6A', '荣耀畅玩6A', '荣耀畅玩6A', '72', '5', '0', '', '', '0', '2017-09-23 14:16:48', '2017-09-23 14:16:48');
INSERT INTO `r_ec_spu` VALUES ('564', 'HUAWEI Mate 9 保时捷设计', 'HUAWEI Mate 9 保时捷设计', 'HUAWEI Mate 9 保时捷设计', '73', '4', '0', '', '', '0', '2017-09-23 14:18:01', '2017-09-23 14:18:01');
INSERT INTO `r_ec_spu` VALUES ('565', 'HUAWEI Mate 9 Pro', 'HUAWEI Mate 9 Pro', 'HUAWEI Mate 9 Pro', '73', '4', '0', '', '', '0', '2017-09-23 14:18:01', '2017-09-23 14:18:01');
INSERT INTO `r_ec_spu` VALUES ('566', 'HUAWEI Mate 9', 'HUAWEI Mate 9', 'HUAWEI Mate 9', '73', '4', '0', '', '', '0', '2017-09-23 14:18:01', '2017-09-23 14:18:01');
INSERT INTO `r_ec_spu` VALUES ('567', 'HUAWEI nove 2 Plus', 'HUAWEI nove 2 Plus', 'HUAWEI nove 2 Plus', '74', '4', '0', '', '', '0', '2017-09-23 14:19:13', '2017-09-23 14:19:13');
INSERT INTO `r_ec_spu` VALUES ('568', 'HUAWEI nove 2', 'HUAWEI nove 2', 'HUAWEI nove 2', '74', '4', '0', '', '', '0', '2017-09-23 14:19:13', '2017-09-23 14:19:13');
INSERT INTO `r_ec_spu` VALUES ('569', 'HUAWEI nove 青春版', 'HUAWEI nove 青春版', 'HUAWEI nove 青春版', '74', '4', '0', '', '', '0', '2017-09-23 14:19:13', '2017-09-23 14:19:13');
INSERT INTO `r_ec_spu` VALUES ('570', 'HUAWEI nove', 'HUAWEI nove', 'HUAWEI nove', '74', '4', '0', '', '', '0', '2017-09-23 14:19:13', '2017-09-23 14:19:13');
INSERT INTO `r_ec_spu` VALUES ('571', '【99元定金】HUAWEI麦芒6', '【99元定金】HUAWEI麦芒6', '【99元定金】HUAWEI麦芒6', '75', '4', '0', '', '', '0', '2017-09-23 14:20:25', '2017-09-23 14:20:25');
INSERT INTO `r_ec_spu` VALUES ('572', 'HUAWEI麦芒5', 'HUAWEI麦芒5', 'HUAWEI麦芒5', '75', '4', '0', '', '', '0', '2017-09-23 14:20:25', '2017-09-23 14:20:25');
INSERT INTO `r_ec_spu` VALUES ('573', '华为畅享7', '华为畅享7', '华为畅享7', '76', '4', '0', '', '', '0', '2017-09-23 14:21:31', '2017-09-23 14:21:31');
INSERT INTO `r_ec_spu` VALUES ('574', '华为畅享7 Plus', '华为畅享7 Plus', '华为畅享7 Plus', '76', '4', '0', '', '', '0', '2017-09-23 14:21:31', '2017-09-23 14:21:31');
INSERT INTO `r_ec_spu` VALUES ('575', '华为畅享6s', '华为畅享6s', '华为畅享6s', '76', '4', '0', '', '', '0', '2017-09-23 14:21:31', '2017-09-23 14:21:31');
INSERT INTO `r_ec_spu` VALUES ('576', 'HUAWEI Mate 9 合约机', '【北京移动合约 流量套餐送话费】HUAWEI Mate 9', '【北京移动合约 流量套餐送话费】HUAWEI Mate 9', '77', '4', '0', '', '', '0', '2017-09-23 14:23:00', '2017-09-23 14:23:00');
INSERT INTO `r_ec_spu` VALUES ('577', '荣耀畅玩平板2', '荣耀畅玩平板2', '荣耀畅玩平板2', '78', '4', '0', '', '', '0', '2017-09-23 14:38:29', '2017-09-23 14:38:29');
INSERT INTO `r_ec_spu` VALUES ('578', '华为平板 M3 青春版', '华为平板 M3 青春版', '华为平板 M3 青春版', '78', '4', '0', '', '', '0', '2017-09-23 14:38:29', '2017-09-23 14:38:29');
INSERT INTO `r_ec_spu` VALUES ('579', '华为平板 M3', '华为平板 M3', '华为平板 M3', '78', '4', '0', '', '', '0', '2017-09-23 14:38:29', '2017-09-23 14:38:29');
INSERT INTO `r_ec_spu` VALUES ('580', '荣耀平板2', '荣耀平板2', '荣耀平板2', '78', '5', '0', '', '', '0', '2017-09-23 14:38:29', '2017-09-23 14:38:29');
INSERT INTO `r_ec_spu` VALUES ('581', '荣耀畅玩平板 LTE版', '荣耀畅玩平板 LTE版', '荣耀畅玩平板 LTE版', '78', '5', '0', '', '', '0', '2017-09-23 14:38:29', '2017-09-23 14:38:29');
INSERT INTO `r_ec_spu` VALUES ('582', 'HUAWEI MateBook X', 'HUAWEI MateBook X', 'HUAWEI MateBook X', '79', '4', '0', '', '', '0', '2017-09-23 14:41:30', '2017-09-23 14:41:30');
INSERT INTO `r_ec_spu` VALUES ('583', 'HUAWEI MateBook D', 'HUAWEI MateBook D', 'HUAWEI MateBook D', '79', '4', '0', '', '', '0', '2017-09-23 14:41:30', '2017-09-23 14:41:30');
INSERT INTO `r_ec_spu` VALUES ('584', 'HUAWEI MateBook E', 'HUAWEI MateBook E', 'HUAWEI MateBook E', '79', '4', '0', '', '', '0', '2017-09-23 14:41:30', '2017-09-23 14:41:30');
INSERT INTO `r_ec_spu` VALUES ('585', 'HUAWEI MateBook 12英寸平板二合一笔记本电脑 m3', 'HUAWEI MateBook 12英寸平板二合一笔记本电脑 m3', 'HUAWEI MateBook 12英寸平板二合一笔记本电脑 m3', '79', '4', '0', '', '', '0', '2017-09-23 14:41:30', '2017-09-23 14:41:30');
INSERT INTO `r_ec_spu` VALUES ('586', 'HUAWEI USB 3.0 A/M TO RJ45 转接线', 'HUAWEI USB 3.0 A/M TO RJ45 转接线', 'HUAWEI USB 3.0 A/M TO RJ45 转接线', '80', '4', '0', '', '', '0', '2017-09-23 14:45:56', '2017-09-23 14:45:56');
INSERT INTO `r_ec_spu` VALUES ('587', 'HUAWEI MateDock 2 扩展坞', 'HUAWEI MateDock 2 扩展坞', 'HUAWEI MateDock 2 扩展坞', '80', '4', '0', '', '', '0', '2017-09-23 14:45:56', '2017-09-23 14:45:56');

