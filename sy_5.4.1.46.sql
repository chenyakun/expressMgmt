/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50527
 Source Host           : localhost
 Source Database       : sy

 Target Server Type    : MySQL
 Target Server Version : 50527
 File Encoding         : utf-8

 Date: 05/04/2013 01:46:32 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `AppJoin`
-- ----------------------------
DROP TABLE IF EXISTS `AppJoin`;
CREATE TABLE `AppJoin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expressCode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expressName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `headName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `imgCode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `networkName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `startPlace` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `startPlace_input` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `BRANCH`
-- ----------------------------
DROP TABLE IF EXISTS `BRANCH`;
CREATE TABLE `BRANCH` (
  `branchId` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `branchAddr` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `branchArea` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `branchName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `branchNoArrea` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `brancheTel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `empId` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`branchId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `Customer`
-- ----------------------------
DROP TABLE IF EXISTS `Customer`;
CREATE TABLE `Customer` (
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `userAddr` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `userName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `userSex` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `userTel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `userType` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `userZip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `Employee`
-- ----------------------------
DROP TABLE IF EXISTS `Employee`;
CREATE TABLE `Employee` (
  `empId` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `branchId` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `empAddr` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `empAge` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `empAuth` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `empName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `empPosi` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `empPwd` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `empSex` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `empTel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `idenNum` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`empId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `Goods`
-- ----------------------------
DROP TABLE IF EXISTS `Goods`;
CREATE TABLE `Goods` (
  `expNum` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `goodsBulk` double NOT NULL,
  `goodsFare` double NOT NULL,
  `goodsName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `goodsPnum` int(11) NOT NULL,
  `goodsType` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `goodsWeight` double NOT NULL,
  `goods_explation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`expNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `InterAera`
-- ----------------------------
DROP TABLE IF EXISTS `InterAera`;
CREATE TABLE `InterAera` (
  `braId` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `areaCode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `areaZip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `county` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isOpen` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`braId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `OrderPackInfo`
-- ----------------------------
DROP TABLE IF EXISTS `OrderPackInfo`;
CREATE TABLE `OrderPackInfo` (
  `orderid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cargo_desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cargo_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cargo_total_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `endPlace` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `orderSource` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pay_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `priceId` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `receive_address1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `receive_address2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `receive_company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `receive_mobile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `receive_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `receive_tel1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `receive_tel2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `receive_tel3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sender_address1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sender_address2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sender_company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sender_mobile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sender_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sender_tel1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sender_tel2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sender_tel3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `startPlace` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `volume` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `weight` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `OrderPackInfo`
-- ----------------------------
BEGIN;
INSERT INTO `OrderPackInfo` VALUES ('19143868-c54e-4659-992a-5eecf0f645e1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null), ('2ba8a420-47b0-4104-97f0-7f90deea5e30', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null), ('3b8cc3c9-428b-4fe8-9ece-654c7b643def', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null), ('3cac727f-60f1-4149-8b53-a1724353a803', '', '22222222222', '22222222222', '310113', 'orderIndex', 'PREPAID', '2233273', '22222222222', '22222222222', '22222222222', '22222222222', '22222222222', '', '', '', '22222222222', '22222222222', '22222222222', '22222222222', '22222222222', '', '', '', 'kuaidi', '110105', 'EXPRESS', '0.0', '2.0'), ('416cb8f8-8e1b-4dba-9b0f-19df84685c4c', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null), ('5aec0764-85b4-4811-8230-37893aa84481', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null), ('634f11ec-7c83-44c7-8782-87fe9711a199', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null), ('6acb04b4-7e46-49c2-9891-a23c22ef084a', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null), ('7c904c5a-4de8-4c14-88e2-c7f54dad94c3', '22222222222', '22222222222', '22222222222', '310113', 'orderIndex', 'PREPAID', '2233273', '22222222222', '22222222222', '22222222222', '22222222222', '22222222222', '', '', '', '2222222222222222222222', '22222222222', '22222222222', '22222222222', '22222222222', '', '', '', 'kuaidi', '110105', 'EXPRESS', '0.0', '2.0'), ('7f3df602-78f2-491d-819d-723bde06f472', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null), ('f650e25e-fd80-439f-8600-7f4539c7eaa9', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `TABOUT`
-- ----------------------------
DROP TABLE IF EXISTS `TABOUT`;
CREATE TABLE `TABOUT` (
  `ID` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `CREATEDATETIME` datetime DEFAULT NULL,
  `NAME` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `NOTE` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `TABOUT`
-- ----------------------------
BEGIN;
INSERT INTO `TABOUT` VALUES ('d63ab4eb-0094-45e7-8172-afc96f107f62', '2013-04-07 22:38:18', '萨芬大d发', '大师傅啊啊');
COMMIT;

-- ----------------------------
--  Table structure for `TBUG`
-- ----------------------------
DROP TABLE IF EXISTS `TBUG`;
CREATE TABLE `TBUG` (
  `ID` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `CREATEDATETIME` datetime DEFAULT NULL,
  `NAME` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `NOTE` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `TBUG`
-- ----------------------------
BEGIN;
INSERT INTO `TBUG` VALUES ('3971614e-2ad5-4fed-8c28-a2409ffb86fc', '2013-04-07 19:07:11', 'sss ', 's&nbsp;<table border=\"1\" width=\"200\" cellspacing=\"1\" cellpadding=\"1\"><tbody><tr><td>ss</td><td>ss</td></tr><tr><td>ff</td><td>f</td></tr><tr><td>f</td><td>f</td></tr></tbody></table>'), ('7f00f953-07c4-4669-a13e-850581750f37', '2013-04-07 18:58:29', '清明节后第一天上班', '乱糟糟的.'), ('a8a7c686-e6f1-4a89-9577-dfee35a09be1', '2013-04-07 19:00:00', '可好看', '<h1><img alt=\"微笑\" src=\"jslib/xheditor-1.1.14/xheditor_emot/default/smile.gif\" /><span style=\"font-size:32px;\">来咯&nbsp;</span><br /></h1>');
COMMIT;

-- ----------------------------
--  Table structure for `TBULLETIN`
-- ----------------------------
DROP TABLE IF EXISTS `TBULLETIN`;
CREATE TABLE `TBULLETIN` (
  `ID` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `CREATEDATETIME` datetime DEFAULT NULL,
  `NAME` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `NOTE` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `TBULLETIN`
-- ----------------------------
BEGIN;
INSERT INTO `TBULLETIN` VALUES ('b9240e47-6735-4110-a2d4-07a4e6f7b159', '2013-04-11 01:01:25', '撒的发生', '撒旦法撒旦法飒飒地方'), ('cab3a446-2614-48c2-a23b-ea932f348298', '2013-04-07 22:38:05', '高规格', '撒旦法');
COMMIT;

-- ----------------------------
--  Table structure for `TMENU`
-- ----------------------------
DROP TABLE IF EXISTS `TMENU`;
CREATE TABLE `TMENU` (
  `ID` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `ICONCLS` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SEQ` decimal(22,0) DEFAULT NULL,
  `TEXT` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `URL` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PID` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK4C3C3B370B9FEB1` (`PID`),
  CONSTRAINT `FK4C3C3B370B9FEB1` FOREIGN KEY (`PID`) REFERENCES `TMENU` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `TMENU`
-- ----------------------------
BEGIN;
INSERT INTO `TMENU` VALUES ('0', 'icon-tip', '1', '后台管理', '', null), ('1391971f-851d-4277-b701-f82447842bd6', '', '7', '公告管理', '/admin/gggl.jsp', 'b8a771b2-2fde-4403-844c-9b00140ff2c2'), ('1882561c-881f-4322-a871-572c1da97335', '', '9', '简介管理', '/admin/about.jsp', 'b8a771b2-2fde-4403-844c-9b00140ff2c2'), ('2ab850ac-668a-4d68-966b-c70b3687513e', '', '10', '快递管理', '', '0'), ('5fe522fc-817f-49c1-b63b-80a2a274df28', '', '8', '新闻管理', '/admin/news.jsp', 'b8a771b2-2fde-4403-844c-9b00140ff2c2'), ('95a97618-f2ba-413c-b5f2-574664bedde4', '', '11', '订单管理', '/admin/order.jsp', '2ab850ac-668a-4d68-966b-c70b3687513e'), ('b8a771b2-2fde-4403-844c-9b00140ff2c2', '', '6', '内容管理', '', '0'), ('buggl', null, '5', 'BUG管理', '/admin/buggl.jsp', 'xtgl'), ('cdgl', null, '4', '菜单管理', '/admin/cdgl.jsp', 'xtgl'), ('ea6ffd78-05eb-4141-9c1d-b7a601887f85', '', '13', '门店管理', '', '0'), ('eba0db9b-1e93-47f5-908f-77599c640018', 'icon-add', '10', '加盟申请', '/admin/site.jsp', 'ea6ffd78-05eb-4141-9c1d-b7a601887f85'), ('f24d3ef1-6803-4df7-8481-fa6ceb23b2af', 'icon-search', '14', '核查门店', '/admin/lookSite.jsp', 'ea6ffd78-05eb-4141-9c1d-b7a601887f85'), ('f82bc83c-167e-4df6-a588-e164e1453052', '', '12', '包裹管理', '/admin/packageMgmt.jsp', '2ab850ac-668a-4d68-966b-c70b3687513e'), ('jsgl', null, '2', '角色管理', '/admin/jsgl.jsp', 'xtgl'), ('xtgl', '', '1', '系统管理', '', '0'), ('yhgl', 'icon-back', '1', '用户管理', '/admin/yhgl.jsp', 'xtgl'), ('zygl', null, '3', '资源管理', '/admin/zygl.jsp', 'xtgl');
COMMIT;

-- ----------------------------
--  Table structure for `TNEWS`
-- ----------------------------
DROP TABLE IF EXISTS `TNEWS`;
CREATE TABLE `TNEWS` (
  `ID` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `CREATEDATETIME` datetime DEFAULT NULL,
  `NAME` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `NOTE` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `TNEWS`
-- ----------------------------
BEGIN;
INSERT INTO `TNEWS` VALUES ('5d2c452b-bf3e-4349-874d-68231a8304d5', '2013-04-07 22:37:48', '大师傅', '撒旦法');
COMMIT;

-- ----------------------------
--  Table structure for `TONLINE`
-- ----------------------------
DROP TABLE IF EXISTS `TONLINE`;
CREATE TABLE `TONLINE` (
  `ID` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `IP` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `LOGINDATETIME` datetime NOT NULL,
  `LOGINNAME` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `TRESOURCE`
-- ----------------------------
DROP TABLE IF EXISTS `TRESOURCE`;
CREATE TABLE `TRESOURCE` (
  `ID` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `SEQ` decimal(22,0) DEFAULT NULL,
  `TEXT` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `URL` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PID` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FKC0C62062A3B371E0` (`PID`),
  CONSTRAINT `FKC0C62062A3B371E0` FOREIGN KEY (`PID`) REFERENCES `TRESOURCE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `TRESOURCE`
-- ----------------------------
BEGIN;
INSERT INTO `TRESOURCE` VALUES ('0', '1', '首页', null, null), ('4be6f818-7d43-4501-bb6d-e467ec047712', '10', '公告通知', '', '9207cd27-61ea-47a5-900d-9718465916a2'), ('9207cd27-61ea-47a5-900d-9718465916a2', '10', '内容管理', '', null), ('buggl', '5', 'BUG管理', null, 'xtgl'), ('bugglAdd', '1', 'BUG添加', '/bugController/add.action', 'buggl'), ('bugglDatagrid', '4', 'BUG列表', '/bugController/datagrid.action', 'buggl'), ('bugglDel', '2', 'BUG删除', '/bugController/remove.action', 'buggl'), ('bugglEdit', '3', 'BUG修改', '/bugController/edit.action', 'buggl'), ('bugglUpdate', '5', 'BUG上传', '/bugController/upload.action', 'buggl'), ('cdgl', '4', '菜单管理', null, 'xtgl'), ('cdglAdd', '1', '菜单添加', '/menuController/add.action', 'cdgl'), ('cdglDel', '2', '菜单删除', '/menuController/remove.action', 'cdgl'), ('cdglEdit', '3', '菜单修改', '/menuController/edit.action', 'cdgl'), ('cdglTreegrid', '4', '菜单列表', '/menuController/treegrid.action', 'cdgl'), ('jsgl', '2', '角色管理', null, 'xtgl'), ('jsglAdd', '1', '角色添加', '/roleController/add.action', 'jsgl'), ('jsglDatagrid', '4', '角色列表', '/roleController/datagrid.action', 'jsgl'), ('jsglDel', '2', '角色删除', '/roleController/remove.action', 'jsgl'), ('jsglEdit', '3', '角色修改', '/roleController/edit.action', 'jsgl'), ('xtgl', '1', '系统管理', null, '0'), ('yhgl', '1', '用户管理', null, 'xtgl'), ('yhglAdd', '1', '用户添加', '/userController/add.action', 'yhgl'), ('yhglDatagrid', '4', '用户列表', '/userController/datagrid.action', 'yhgl'), ('yhglDel', '2', '用户删除', '/userController/remove.action', 'yhgl'), ('yhglEdit', '3', '用户修改', '/userController/edit.action', 'yhgl'), ('yhglModifyPwd', '5', '用户修改密码', '/userController/modifyPwd.action', 'yhgl'), ('yhglModifyRole', '6', '用户批量修改角色', '/userController/modifyRole.action', 'yhgl'), ('zygl', '3', '资源管理', null, 'xtgl'), ('zyglAdd', '1', '资源添加', '/resourceController/add.action', 'zygl'), ('zyglDel', '2', '资源删除', '/resourceController/remove.action', 'zygl'), ('zyglEdit', '3', '资源修改', '/resourceController/edit.action', 'zygl'), ('zyglTreegrid', '4', '资源列表', '/resourceController/treegrid.action', 'zygl');
COMMIT;

-- ----------------------------
--  Table structure for `TROLE`
-- ----------------------------
DROP TABLE IF EXISTS `TROLE`;
CREATE TABLE `TROLE` (
  `ID` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `TEXT` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `TROLE`
-- ----------------------------
BEGIN;
INSERT INTO `TROLE` VALUES ('0', '超管角色'), ('698bfa62-ad93-4084-b0dd-a022299f0cee', '申请中');
COMMIT;

-- ----------------------------
--  Table structure for `TROLE_TRESOURCE`
-- ----------------------------
DROP TABLE IF EXISTS `TROLE_TRESOURCE`;
CREATE TABLE `TROLE_TRESOURCE` (
  `ID` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `RESOURCE_ID` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `ROLE_ID` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK41E0D52DC2CC4DC1` (`ROLE_ID`),
  KEY `FK41E0D52DED474B41` (`RESOURCE_ID`),
  CONSTRAINT `FK41E0D52DC2CC4DC1` FOREIGN KEY (`ROLE_ID`) REFERENCES `TROLE` (`ID`),
  CONSTRAINT `FK41E0D52DED474B41` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `TRESOURCE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `TROLE_TRESOURCE`
-- ----------------------------
BEGIN;
INSERT INTO `TROLE_TRESOURCE` VALUES ('01d8b3d1-7781-47b9-8fc5-38fe0d6cd8ad', 'zyglAdd', '0'), ('0899af43-5780-4554-b6ef-bc01c6c0f855', 'cdglDel', '0'), ('0f870802-fbf6-463a-830b-ab395abfde37', 'bugglUpdate', '0'), ('1c3085d9-d80f-419c-a0a1-791359b5157b', 'cdglAdd', '0'), ('26227187-cf0e-444b-ba5d-9c63d408d74f', 'yhglDel', '0'), ('294d2d9c-ce6a-4263-9930-ac9e096a7d16', 'bugglUpdate', '698bfa62-ad93-4084-b0dd-a022299f0cee'), ('3805e737-caf0-4749-b4ba-4e8d2b4fb40a', '0', '0'), ('39ecb020-1f5f-4511-bf42-90863fdd9a11', 'zyglTreegrid', '0'), ('48ad27b6-c0a0-4aa9-91e2-a07e40dd066c', 'cdglTreegrid', '0'), ('49bdae85-a6ba-47e0-82c0-08012fc82c6b', 'bugglAdd', '0'), ('4ab3dff8-1d4d-4844-b93c-bdbd75e8ef25', 'bugglAdd', '698bfa62-ad93-4084-b0dd-a022299f0cee'), ('54058958-b0f5-4448-bf05-b15178421753', 'jsglDatagrid', '0'), ('5c8750f4-3dd3-4137-a87a-9d3bc8c9094a', 'yhglModifyPwd', '0'), ('5f32e391-b536-4d44-b716-0cf32587ed26', 'yhglDatagrid', '0'), ('61db5c82-b276-490a-af5c-7be6dc9795f3', 'bugglEdit', '0'), ('6e1f2ec5-5668-4805-825b-52f4382f137f', 'zyglEdit', '0'), ('6e780e9e-8b49-42b4-b6ab-ab821d38cf40', 'yhglEdit', '0'), ('71e36c37-9e56-4eca-b328-e9faaede964c', 'yhglAdd', '0'), ('77b3c567-f536-444e-bff0-f13389e7bd58', 'cdglEdit', '0'), ('80430938-b578-4064-a4ed-e6598e3967d4', 'bugglDatagrid', '698bfa62-ad93-4084-b0dd-a022299f0cee'), ('8a55370b-9023-47c4-abbb-eb5edf1258a9', 'bugglDel', '698bfa62-ad93-4084-b0dd-a022299f0cee'), ('8d6ac4c0-c238-44e9-8b9c-1d731e2810d5', 'jsglEdit', '0'), ('8f2b4a69-384c-4b52-8819-7db10ab01958', 'yhglModifyRole', '0'), ('96984db6-3b5a-414f-b550-7c346a0d608b', 'xtgl', '0'), ('99c20bb6-1a91-4850-9d1b-cbd9f7caff69', 'buggl', '0'), ('9cd3c8b7-cfb6-49ee-8816-713ab34ebb7a', 'zygl', '0'), ('a5aa713f-4f14-4f84-ac78-b487286fd85e', 'bugglDatagrid', '0'), ('a9442047-0bcd-4246-b2eb-7a1d3ccd91d2', 'jsgl', '0'), ('b8213e32-d601-4e4f-969c-75873f4e5310', 'cdgl', '0'), ('b8e5acbf-e660-4475-83ef-e998c5ae769f', 'zyglDel', '0'), ('d02b590d-790f-4c30-90c8-548e9e3e18b7', 'buggl', '698bfa62-ad93-4084-b0dd-a022299f0cee'), ('d551052d-039f-45c8-b428-6edf88fe33a8', 'jsglDel', '0'), ('eb56ad14-949d-4a0b-9d42-68447ec6a1dc', 'bugglDel', '0'), ('eeb7da19-5dbb-4f66-aaeb-edacb9196e22', 'jsglAdd', '0'), ('f21d7a6e-7f00-4145-a5f0-f50be18b619e', 'bugglEdit', '698bfa62-ad93-4084-b0dd-a022299f0cee'), ('fd047fc2-1e5c-452c-826c-b9b283ea71de', 'yhgl', '0');
COMMIT;

-- ----------------------------
--  Table structure for `TSITE`
-- ----------------------------
DROP TABLE IF EXISTS `TSITE`;
CREATE TABLE `TSITE` (
  `siteId` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `storeAddress` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `storeAddtionInfo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `storeBoss` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `storeOpenDate` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `storePosition` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `storeTel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `storeWebUrl` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `storename` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`siteId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `TSITE`
-- ----------------------------
BEGIN;
INSERT INTO `TSITE` VALUES ('1', 'tang feng road', 'no more', 'who', '2013', 'he 北', '13022119890801', 'http://www.baidu.com', 'xinxin', '0'), ('36f5dd90-7886-439d-8797-22a94ac8f3f0', 'tang feng road', 'no more', 'who', '2013', 'he 北', '13022119890801', 'http://www.baidu.com', 'xinxin', '0'), ('4b05f3c5-95bb-49eb-9418-09362285fa62', 'tang feng road', 'no more', 'who', '2013', 'he 北', '13022119890801', 'http://www.baidu.com', 'xinxin', '0'), ('68c7dfa4-ea5f-4db4-b2f5-7e40a768a5c6', 'tang feng road', 'no more', 'who', '2013', 'he 北', '13022119890801', 'http://www.baidu.com', 'xinxin', '0'), ('774351e8-e54b-4793-ae47-baf04f0c00f5', 'tang feng road', 'no more', 'who', '2013', 'he 北', '13022119890801', 'http://www.baidu.com', 'xinxin', '0'), ('8e0a1e90-b06b-4e70-9cc2-10723d598528', 'tang feng road', 'no more', 'who', '2013', 'he 北', '13022119890801', 'http://www.baidu.com', 'xinxin', '0'), ('d5eec92e-088b-4eac-b38c-d048acebaa45', 'tang feng road', 'no more', 'who', '2013', 'he 北', '13022119890801', 'http://www.baidu.com', 'xinxin', '0'), ('ffb0e75c-f3a5-4979-b670-584a9166d964', 'tang feng road', 'no more', 'who', '2013', 'he 北', '13022119890801', 'http://www.baidu.com', 'xinxin', '0');
COMMIT;

-- ----------------------------
--  Table structure for `TUSER`
-- ----------------------------
DROP TABLE IF EXISTS `TUSER`;
CREATE TABLE `TUSER` (
  `ID` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `CREATEDATETIME` datetime DEFAULT NULL,
  `MODIFYDATETIME` datetime DEFAULT NULL,
  `NAME` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `PWD` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `NAME` (`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `TUSER`
-- ----------------------------
BEGIN;
INSERT INTO `TUSER` VALUES ('0', null, '2013-04-06 20:58:01', 'admin ', '21232f297a57a5a743894a0e4a801fc3'), ('71e3d9cc-6750-4fa2-8206-d639fccbb586', '2013-04-06 21:24:17', null, 'abc', '900150983cd24fb0d6963f7d28e17f72'), ('93b27305-0aea-46df-b4df-126d705ef9b3', '2013-04-06 19:55:03', '2013-04-06 21:07:26', 'guest', 'e10adc3949ba59abbe56e057f20f883e'), ('e9665e3e-1c7b-477d-b676-76c4bcefa249', '2013-04-08 23:13:42', null, 'hello', '5d41402abc4b2a76b9719d911017c592');
COMMIT;

-- ----------------------------
--  Table structure for `TUSER_TROLE`
-- ----------------------------
DROP TABLE IF EXISTS `TUSER_TROLE`;
CREATE TABLE `TUSER_TROLE` (
  `ID` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `ROLE_ID` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `USER_ID` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FKA1EFD8AAC2CC4DC1` (`ROLE_ID`),
  KEY `FKA1EFD8AA67F711A1` (`USER_ID`),
  CONSTRAINT `FKA1EFD8AA67F711A1` FOREIGN KEY (`USER_ID`) REFERENCES `TUSER` (`ID`),
  CONSTRAINT `FKA1EFD8AAC2CC4DC1` FOREIGN KEY (`ROLE_ID`) REFERENCES `TROLE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `TUSER_TROLE`
-- ----------------------------
BEGIN;
INSERT INTO `TUSER_TROLE` VALUES ('acafe5d4-c78a-4d3a-aef4-ed76e27cb7d9', '698bfa62-ad93-4084-b0dd-a022299f0cee', '71e3d9cc-6750-4fa2-8206-d639fccbb586'), ('e3fab16c-7167-4804-99e6-e89eb22ac929', '0', '0'), ('f4107d4d-bb3d-4179-9e62-07f673020361', '698bfa62-ad93-4084-b0dd-a022299f0cee', '93b27305-0aea-46df-b4df-126d705ef9b3');
COMMIT;

-- ----------------------------
--  Table structure for `county`
-- ----------------------------
DROP TABLE IF EXISTS `county`;
CREATE TABLE `county` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cityid` varchar(10) DEFAULT NULL,
  `county` longtext,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `county`
-- ----------------------------
BEGIN;
INSERT INTO `county` VALUES ('1', '130100', '[{\"name\":\"灵寿县\",\"number\":\"130126\"},{\"name\":\"平山县\",\"number\":\"130131\"},{\"name\":\"桥东区\",\"number\":\"130103\"},{\"name\":\"桥西区\",\"number\":\"130104\"},{\"name\":\"深泽县\",\"number\":\"130128\"},{\"name\":\"无极县\",\"number\":\"130130\"},{\"name\":\"新华区\",\"number\":\"130105\"},{\"name\":\"辛集市\",\"number\":\"130181\"},{\"name\":\"裕华区\",\"number\":\"130108\"},{\"name\":\"长安区\",\"number\":\"130102\"},{\"name\":\"正定县\",\"number\":\"130123\"},{\"name\":\"赵县\",\"number\":\"130133\"}]\n', null), ('2', '130200', '[{\"name\":\"丰南区\",\"number\":\"130207\"},{\"name\":\"丰润区\",\"number\":\"130208\"},{\"name\":\"古冶区\",\"number\":\"130204\"},{\"name\":\"开平区\",\"number\":\"130205\"},{\"name\":\"路北区\",\"number\":\"130203\"},{\"name\":\"路南区\",\"number\":\"130202\"},{\"name\":\"滦南县\",\"number\":\"130224\"},{\"name\":\"滦县\",\"number\":\"130223\"},{\"name\":\"迁安市\",\"number\":\"130283\"},{\"name\":\"迁西县\",\"number\":\"130227\"},{\"name\":\"唐海县\",\"number\":\"130230\"},{\"name\":\"玉田县\",\"number\":\"130229\"},{\"name\":\"乐亭县\",\"number\":\"130225\"},{\"name\":\"遵化市\",\"number\":\"130281\"}]', null);
COMMIT;

-- ----------------------------
--  Table structure for `expUserEmp`
-- ----------------------------
DROP TABLE IF EXISTS `expUserEmp`;
CREATE TABLE `expUserEmp` (
  `empId` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expNum` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `userId` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`empId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
