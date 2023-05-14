/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : aggregation

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 26/04/2023 22:47:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for currency
-- ----------------------------
DROP TABLE IF EXISTS `currency`;
CREATE TABLE `currency`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '币种ID',
  `currency_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '币种名称',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `pic_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片',
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '币种全称',
  `exchange_rate` decimal(20, 8) NULL DEFAULT NULL COMMENT '对USD汇率',
  `seq_num` bigint NULL DEFAULT NULL COMMENT '排序值',
  `is_recharge` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '充值开启',
  `is_cash` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '开启提现',
  `is_exchange` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '兑换开启',
  `max_bet_money` decimal(30, 8) NULL DEFAULT NULL COMMENT '最高投注金额',
  `max_profit` decimal(30, 8) NULL DEFAULT NULL COMMENT '最高利润',
  `min_bet_money` decimal(30, 8) NULL DEFAULT NULL COMMENT '最低投注额',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_name`(`currency_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '平台币种表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of currency
-- ----------------------------
INSERT INTO `currency` VALUES (1, 'BTC', NULL, NULL, NULL, NULL, 'b7fac132da5bb891db0e9a7cb227f10f.png', 'bitcoin', 27680.00000000, 1, '1', '1', '1', NULL, NULL, NULL);
INSERT INTO `currency` VALUES (2, 'ETH', NULL, NULL, NULL, NULL, '0bbca7be219f8f05808ca15d655a4f3e.png', 'ethereum', 1754.31000000, 2, '1', '1', '1', NULL, NULL, NULL);
INSERT INTO `currency` VALUES (3, 'USDT', NULL, NULL, NULL, NULL, '0bbca7be219f8f05808ca15d655a4f3e.png', 'tether', 1.00800000, 3, '1', '1', '1', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for currency_network
-- ----------------------------
DROP TABLE IF EXISTS `currency_network`;
CREATE TABLE `currency_network`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `parent_id` bigint NULL DEFAULT NULL COMMENT '关联币种ID',
  `network_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '充值网络',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '钱包地址',
  `qrcode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '钱包二维码地址',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `seq_num` bigint NULL DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '1：充值网络，2：提现网络',
  `service_charge` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '提现网络的手续费，*代表从链上获取',
  `min_withdrawal` decimal(20, 8) NULL DEFAULT NULL COMMENT '最低提款',
  `alias_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '别名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '币种充值网络表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of currency_network
-- ----------------------------
INSERT INTO `currency_network` VALUES (1, 1, 'BTC', 'sss12312312451241', NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, NULL, 'BTC');
INSERT INTO `currency_network` VALUES (2, 2, 'ETH', NULL, NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, NULL, 'ETH');
INSERT INTO `currency_network` VALUES (3, 3, 'USDT(TRC20)', '31231231', NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, NULL, 'TRC20');
INSERT INTO `currency_network` VALUES (4, 3, 'USDT(ERC20)', '0x2C05015cfEfB42A706d115a355F9CB2cC195e770', NULL, NULL, NULL, NULL, NULL, 2, '1', NULL, NULL, 'ERC20');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表描述',
  `class_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `options` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 250 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------

-- ----------------------------
-- Table structure for platform_domain
-- ----------------------------
DROP TABLE IF EXISTS `platform_domain`;
CREATE TABLE `platform_domain`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `domain_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '前端域名',
  `type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型，1：谷歌，2：FB',
  `client_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'clientId',
  `client_secret` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'clientSecret',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 78 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '平台第三方域名管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of platform_domain
-- ----------------------------
INSERT INTO `platform_domain` VALUES (76, 'localhost', '2', '846475066588510', '0aa429dad3061a05df5254fe74571281', '', '2022-12-31 04:40:15', '', '2023-01-01 17:52:17', NULL);
INSERT INTO `platform_domain` VALUES (77, 'localhost', '1', '1088398210350-6fu12oephj2s8ta387ttmmcqftr152es.apps.googleusercontent.com', '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', '', '2022-12-31 23:07:24', '', '2022-12-31 23:38:12', NULL);

-- ----------------------------
-- Table structure for platform_nft_products
-- ----------------------------
DROP TABLE IF EXISTS `platform_nft_products`;
CREATE TABLE `platform_nft_products`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '数据ID',
  `nft_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'NFT名称',
  `price` decimal(20, 2) NOT NULL COMMENT '价格',
  `pic_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图片地址',
  `over_time` datetime NULL DEFAULT NULL COMMENT '售卖结束时间',
  `index_data` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否推荐',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `wallet_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '钱包地址',
  `chain` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属链',
  `is_used` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否使用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'NFT产品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of platform_nft_products
-- ----------------------------
INSERT INTO `platform_nft_products` VALUES (12, '#92837', 30.20, '41c5e2f6568df4152104a4f3646221d1.png', '2026-03-28 08:00:00', '0', '', '2023-03-23 16:45:58', '', '2023-03-29 19:00:23', '0x1f90676c326', 'Ethereum', '1');
INSERT INTO `platform_nft_products` VALUES (13, '#92634', 0.25, '36a130eedaa774252aca16f2c40ac206.png', '2025-03-08 08:00:00', '0', '', '2023-03-23 16:46:30', '', '2023-03-29 19:00:26', '0x1f90676c326', 'Ethereum', '1');
INSERT INTO `platform_nft_products` VALUES (14, '#52735', 1.70, '3688ac91a81a9b8c0adc7271ee228377.png', '2025-03-14 08:00:00', '0', '', '2023-03-23 16:46:56', '', '2023-03-29 19:00:30', '0x1f90676c326', 'Ethereum', '1');
INSERT INTO `platform_nft_products` VALUES (15, '#64723', 2.20, '3471dada02d8ec55d34480f49e28f514.png', '2025-03-22 08:00:00', '1', '', '2023-03-23 16:47:16', '', '2023-03-23 16:57:05', '0x1f90676c326', 'Ethereum', '1');
INSERT INTO `platform_nft_products` VALUES (16, '#56283', 73.50, 'e9f0a9631243683029e534bffa911509.png', '2025-03-22 08:00:00', '0', '', '2023-03-23 16:47:58', '', '2023-03-29 19:00:33', '0x1f90676c326', 'Ethereum', '1');
INSERT INTO `platform_nft_products` VALUES (17, '#74629', 6.20, '540832da27bc6217a7f97410cab64977.png', '2025-03-08 08:00:00', '1', '', '2023-03-23 16:51:32', '', '2023-03-23 16:52:47', '0x1f90676c326', 'Ethereum', '1');
INSERT INTO `platform_nft_products` VALUES (18, '#25733', 0.35, 'a94d478948fbf3d3c09aeaadb205ad03.png', '2025-03-15 08:00:00', '1', '', '2023-03-23 16:53:36', '', NULL, '0x1f90676c326', 'Ethereum', '1');
INSERT INTO `platform_nft_products` VALUES (19, '#38743', 2.90, 'b4cff1f11c9e4c5c4e7d1e768920d1c7.png', '2025-03-22 08:00:00', '1', '', '2023-03-23 16:56:30', '', NULL, '0x1f90676c326', 'Ethereum', '1');
INSERT INTO `platform_nft_products` VALUES (22, '#24374', 0.10, '93096acf5de34e9dfe7795bc343c2227.png', '2024-03-01 08:00:00', '1', '', '2023-03-23 16:59:14', '', '2023-03-23 22:41:01', '0x1f90676c326', 'Ethereum', '1');
INSERT INTO `platform_nft_products` VALUES (23, '#22834', 89.20, 'd92a687f2484ac880697a98f3240bd5c.png', '2025-03-22 08:00:00', '0', '', '2023-03-23 16:59:49', '', '2023-03-29 19:00:38', '0x1f90676c326', 'Ethereum', '0');
INSERT INTO `platform_nft_products` VALUES (24, '#19364', 2.35, 'f45e851ab2d0d67bb62daf170d6519c8.png', '2025-03-14 08:00:00', '0', '', '2023-03-23 17:01:08', '', '2023-03-23 17:02:03', '0x1f90676c326', 'Ethereum', '1');
INSERT INTO `platform_nft_products` VALUES (25, '#93746', 42.48, 'e3ae7cbc9b4b35aacf0db62e96a69bb4.png', '2023-03-04 08:00:00', '1', '', '2023-03-23 17:01:47', '', '2023-03-29 18:58:36', '0x1f90676c326', 'Ethereum', '0');
INSERT INTO `platform_nft_products` VALUES (26, '#53682', 32.60, '3e933a9ec66a3382eb8026e1f56f4d7b.png', '2025-03-29 08:00:00', '1', '', '2023-03-23 17:02:59', '', NULL, '0x1f90676c326', 'Ethereum', '1');
INSERT INTO `platform_nft_products` VALUES (27, '#32062', 23.25, 'a57859295f52a9ceb4610d29ff64dc40.png', '2025-03-29 08:00:00', '0', '', '2023-03-23 17:04:46', '', '2023-03-29 19:03:10', '0x1f90676c326', 'Ethereum', '1');
INSERT INTO `platform_nft_products` VALUES (28, '#84753', 3.82, '0f458b81a1be7c52070c4965872f2a08.png', '2025-03-22 08:00:00', '0', '', '2023-03-23 17:05:28', '', '2023-03-29 19:02:41', '0x1f90676c326', 'Ethereum', '1');
INSERT INTO `platform_nft_products` VALUES (29, '#68364', 22.60, '9494fa4e38eae7a92bba72c62096105f.png', '2025-03-22 08:00:00', '0', '', '2023-03-23 17:06:03', '', '2023-03-29 19:02:44', '0x1f90676c326', 'Ethereum', '1');
INSERT INTO `platform_nft_products` VALUES (30, '#37492', 85.60, 'd43fac3709f38a4861e554dea0a55449.png', '2026-03-14 08:00:00', '1', '', '2023-03-29 19:08:41', '', NULL, '0x1f90676c326', 'Ethereum', '0');
INSERT INTO `platform_nft_products` VALUES (31, '#82637', 63.20, 'b181813b0b9a110da9e41c9f0ec0886f.png', '2026-03-14 08:00:00', '1', '', '2023-03-29 19:09:14', '', NULL, '0x1f90676c326', 'Ethereum', '0');
INSERT INTO `platform_nft_products` VALUES (32, '#23746', 82.30, 'ac15c515c81dc123ac6cd55dfc4d08d6.png', '2024-03-02 08:00:00', '1', '', '2023-03-29 19:09:39', '', NULL, '0x1f90676c326', 'Ethereum', '0');
INSERT INTO `platform_nft_products` VALUES (33, '#85732', 58.32, '5b318c8d2538076bb62ef25e3f6081a2.png', '2024-03-02 08:00:00', '1', '', '2023-03-29 19:10:04', '', NULL, '0x1f90676c326', 'Ethereum', '0');
INSERT INTO `platform_nft_products` VALUES (34, '#84723', 92.30, '651aa391ba69fdbeee6ddaab8fe5c424.png', '2024-03-02 08:00:00', '1', '', '2023-03-29 19:10:28', '', NULL, '0x1f90676c326', 'Ethereum', '0');

-- ----------------------------
-- Table structure for platform_open_time
-- ----------------------------
DROP TABLE IF EXISTS `platform_open_time`;
CREATE TABLE `platform_open_time`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '开市时间ID',
  `pid` bigint NULL DEFAULT NULL COMMENT '产品ID',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '开市时间对应的周几',
  `open_time` varchar(888) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开市时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_1`(`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 806 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品开市时间表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of platform_open_time
-- ----------------------------
INSERT INTO `platform_open_time` VALUES (78, 601, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (79, 601, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (80, 601, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (81, 601, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (82, 601, '5', '00:00~20:00');
INSERT INTO `platform_open_time` VALUES (83, 601, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (84, 601, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (85, 602, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (86, 602, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (87, 602, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (88, 602, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (89, 602, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (90, 602, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (91, 602, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (92, 603, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (93, 603, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (94, 603, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (95, 603, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (96, 603, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (97, 603, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (98, 603, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (99, 604, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (100, 604, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (101, 604, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (102, 604, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (103, 604, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (104, 604, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (105, 604, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (106, 605, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (107, 605, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (108, 605, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (109, 605, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (110, 605, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (111, 605, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (112, 605, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (113, 606, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (114, 606, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (115, 606, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (116, 606, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (117, 606, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (118, 606, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (119, 606, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (120, 607, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (121, 607, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (122, 607, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (123, 607, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (124, 607, '5', '00:00~20:00');
INSERT INTO `platform_open_time` VALUES (125, 607, '6', NULL);
INSERT INTO `platform_open_time` VALUES (126, 607, '7', '21:01~24:00');
INSERT INTO `platform_open_time` VALUES (127, 608, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (128, 608, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (129, 608, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (130, 608, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (131, 608, '5', '00:00~20:00');
INSERT INTO `platform_open_time` VALUES (132, 608, '6', NULL);
INSERT INTO `platform_open_time` VALUES (133, 608, '7', '21:01~24:00');
INSERT INTO `platform_open_time` VALUES (134, 609, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (135, 609, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (136, 609, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (137, 609, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (138, 609, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (139, 609, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (140, 609, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (141, 610, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (142, 610, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (143, 610, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (144, 610, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (145, 610, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (146, 610, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (147, 610, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (148, 611, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (149, 611, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (150, 611, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (151, 611, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (152, 611, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (153, 611, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (154, 611, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (155, 612, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (156, 612, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (157, 612, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (158, 612, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (159, 612, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (160, 612, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (161, 612, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (162, 613, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (163, 613, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (164, 613, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (165, 613, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (166, 613, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (167, 613, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (168, 613, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (169, 614, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (170, 614, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (171, 614, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (172, 614, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (173, 614, '5', '00:00~20:00');
INSERT INTO `platform_open_time` VALUES (174, 614, '6', NULL);
INSERT INTO `platform_open_time` VALUES (175, 614, '7', '21:01~24:00');
INSERT INTO `platform_open_time` VALUES (176, 615, '1', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (177, 615, '2', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (178, 615, '3', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (179, 615, '4', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (180, 615, '5', '08:00~20:00');
INSERT INTO `platform_open_time` VALUES (181, 615, '6', NULL);
INSERT INTO `platform_open_time` VALUES (182, 615, '7', '21:01~24:00');
INSERT INTO `platform_open_time` VALUES (183, 616, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (184, 616, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (185, 616, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (186, 616, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (187, 616, '5', '00:00~20:00');
INSERT INTO `platform_open_time` VALUES (188, 616, '6', NULL);
INSERT INTO `platform_open_time` VALUES (189, 616, '7', '21:01~24:00');
INSERT INTO `platform_open_time` VALUES (190, 617, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (191, 617, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (192, 617, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (193, 617, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (194, 617, '5', '00:00~20:00');
INSERT INTO `platform_open_time` VALUES (195, 617, '6', NULL);
INSERT INTO `platform_open_time` VALUES (196, 617, '7', '21:01~24:00');
INSERT INTO `platform_open_time` VALUES (197, 618, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (198, 618, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (199, 618, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (200, 618, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (201, 618, '5', '00:00~20:00');
INSERT INTO `platform_open_time` VALUES (202, 618, '6', NULL);
INSERT INTO `platform_open_time` VALUES (203, 618, '7', '21:01~24:00');
INSERT INTO `platform_open_time` VALUES (204, 619, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (205, 619, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (206, 619, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (207, 619, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (208, 619, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (209, 619, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (210, 619, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (211, 620, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (212, 620, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (213, 620, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (214, 620, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (215, 620, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (216, 620, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (217, 620, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (218, 621, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (219, 621, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (220, 621, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (221, 621, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (222, 621, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (223, 621, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (224, 621, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (225, 622, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (226, 622, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (227, 622, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (228, 622, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (229, 622, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (230, 622, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (231, 622, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (232, 623, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (233, 623, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (234, 623, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (235, 623, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (236, 623, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (237, 623, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (238, 623, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (239, 624, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (240, 624, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (241, 624, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (242, 624, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (243, 624, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (244, 624, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (245, 624, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (246, 625, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (247, 625, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (248, 625, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (249, 625, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (250, 625, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (251, 625, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (252, 625, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (253, 626, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (254, 626, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (255, 626, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (256, 626, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (257, 626, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (258, 626, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (259, 626, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (260, 627, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (261, 627, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (262, 627, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (263, 627, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (264, 627, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (265, 627, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (266, 627, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (267, 628, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (268, 628, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (269, 628, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (270, 628, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (271, 628, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (272, 628, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (273, 628, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (274, 629, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (275, 629, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (276, 629, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (277, 629, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (278, 629, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (279, 629, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (280, 629, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (281, 630, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (282, 630, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (283, 630, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (284, 630, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (285, 630, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (286, 630, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (287, 630, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (288, 631, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (289, 631, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (290, 631, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (291, 631, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (292, 631, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (293, 631, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (294, 631, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (295, 632, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (296, 632, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (297, 632, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (298, 632, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (299, 632, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (300, 632, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (301, 632, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (302, 633, '1', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (303, 633, '2', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (304, 633, '3', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (305, 633, '4', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (306, 633, '5', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (307, 633, '6', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (308, 633, '7', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (309, 634, '1', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (310, 634, '2', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (311, 634, '3', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (312, 634, '4', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (313, 634, '5', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (314, 634, '6', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (315, 634, '7', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (316, 635, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (317, 635, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (318, 635, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (319, 635, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (320, 635, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (321, 635, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (322, 635, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (323, 636, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (324, 636, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (325, 636, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (326, 636, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (327, 636, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (328, 636, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (329, 636, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (330, 637, '1', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (331, 637, '2', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (332, 637, '3', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (333, 637, '4', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (334, 637, '5', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (335, 637, '6', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (336, 637, '7', '08:00~24:00');
INSERT INTO `platform_open_time` VALUES (337, 638, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (338, 638, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (339, 638, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (340, 638, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (341, 638, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (342, 638, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (343, 638, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (344, 639, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (345, 639, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (346, 639, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (347, 639, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (348, 639, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (349, 639, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (350, 639, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (351, 639, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (352, 639, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (353, 639, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (354, 639, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (355, 639, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (356, 639, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (357, 639, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (358, 640, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (359, 640, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (360, 640, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (361, 640, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (362, 640, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (363, 640, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (364, 640, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (365, 641, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (366, 641, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (367, 641, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (368, 641, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (369, 641, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (370, 641, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (371, 641, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (372, 642, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (373, 642, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (374, 642, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (375, 642, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (376, 642, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (377, 642, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (378, 642, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (379, 643, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (380, 643, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (381, 643, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (382, 643, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (383, 643, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (384, 643, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (385, 643, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (386, 644, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (387, 644, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (388, 644, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (389, 644, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (390, 644, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (391, 644, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (392, 644, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (393, 645, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (394, 645, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (395, 645, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (396, 645, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (397, 645, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (398, 645, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (399, 645, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (400, 646, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (401, 646, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (402, 646, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (403, 646, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (404, 646, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (405, 646, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (406, 646, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (407, 647, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (408, 647, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (409, 647, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (410, 647, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (411, 647, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (412, 647, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (413, 647, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (414, 648, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (415, 648, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (416, 648, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (417, 648, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (418, 648, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (419, 648, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (420, 648, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (421, 649, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (422, 649, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (423, 649, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (424, 649, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (425, 649, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (426, 649, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (427, 649, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (428, 650, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (429, 650, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (430, 650, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (431, 650, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (432, 650, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (433, 650, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (434, 650, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (435, 651, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (436, 651, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (437, 651, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (438, 651, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (439, 651, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (440, 651, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (441, 651, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (442, 652, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (443, 652, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (444, 652, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (445, 652, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (446, 652, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (447, 652, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (448, 652, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (449, 653, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (450, 653, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (451, 653, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (452, 653, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (453, 653, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (454, 653, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (455, 653, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (456, 654, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (457, 654, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (458, 654, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (459, 654, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (460, 654, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (461, 654, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (462, 654, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (463, 655, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (464, 655, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (465, 655, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (466, 655, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (467, 655, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (468, 655, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (469, 655, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (470, 656, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (471, 656, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (472, 656, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (473, 656, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (474, 656, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (475, 656, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (476, 656, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (477, 657, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (478, 657, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (479, 657, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (480, 657, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (481, 657, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (482, 657, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (483, 657, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (484, 658, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (485, 658, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (486, 658, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (487, 658, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (488, 658, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (489, 658, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (490, 658, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (491, 659, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (492, 659, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (493, 659, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (494, 659, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (495, 659, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (496, 659, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (497, 659, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (498, 660, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (499, 660, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (500, 660, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (501, 660, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (502, 660, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (503, 660, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (504, 660, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (505, 661, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (506, 661, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (507, 661, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (508, 661, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (509, 661, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (510, 661, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (511, 661, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (512, 662, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (513, 662, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (514, 662, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (515, 662, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (516, 662, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (517, 662, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (518, 662, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (519, 663, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (520, 663, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (521, 663, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (522, 663, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (523, 663, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (524, 663, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (525, 663, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (526, 664, '1', '00:00~24:0');
INSERT INTO `platform_open_time` VALUES (527, 664, '2', '00:00~24:0');
INSERT INTO `platform_open_time` VALUES (528, 664, '3', '00:00~24:0');
INSERT INTO `platform_open_time` VALUES (529, 664, '4', '00:00~24:0');
INSERT INTO `platform_open_time` VALUES (530, 664, '5', '00:00~24:0');
INSERT INTO `platform_open_time` VALUES (531, 664, '6', '00:00~24:0');
INSERT INTO `platform_open_time` VALUES (532, 664, '7', '00:00~24:0');
INSERT INTO `platform_open_time` VALUES (533, 665, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (534, 665, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (535, 665, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (536, 665, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (537, 665, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (538, 665, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (539, 665, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (540, 666, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (541, 666, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (542, 666, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (543, 666, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (544, 666, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (545, 666, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (546, 666, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (547, 667, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (548, 667, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (549, 667, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (550, 667, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (551, 667, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (552, 667, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (553, 667, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (554, 668, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (555, 668, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (556, 668, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (557, 668, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (558, 668, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (559, 668, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (560, 668, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (561, 669, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (562, 669, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (563, 669, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (564, 669, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (565, 669, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (566, 669, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (567, 669, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (568, 670, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (569, 670, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (570, 670, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (571, 670, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (572, 670, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (573, 670, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (574, 670, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (575, 671, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (576, 671, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (577, 671, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (578, 671, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (579, 671, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (580, 671, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (581, 671, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (582, 672, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (583, 672, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (584, 672, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (585, 672, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (586, 672, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (587, 672, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (588, 672, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (589, 673, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (590, 673, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (591, 673, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (592, 673, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (593, 673, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (594, 673, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (595, 673, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (596, 674, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (597, 674, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (598, 674, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (599, 674, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (600, 674, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (601, 674, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (602, 674, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (603, 675, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (604, 675, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (605, 675, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (606, 675, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (607, 675, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (608, 675, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (609, 675, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (610, 676, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (611, 676, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (612, 676, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (613, 676, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (614, 676, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (615, 676, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (616, 676, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (617, 677, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (618, 677, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (619, 677, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (620, 677, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (621, 677, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (622, 677, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (623, 677, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (624, 678, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (625, 678, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (626, 678, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (627, 678, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (628, 678, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (629, 678, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (630, 678, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (631, 679, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (632, 679, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (633, 679, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (634, 679, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (635, 679, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (636, 679, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (637, 679, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (638, 680, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (639, 680, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (640, 680, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (641, 680, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (642, 680, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (643, 680, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (644, 680, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (645, 681, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (646, 681, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (647, 681, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (648, 681, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (649, 681, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (650, 681, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (651, 681, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (652, 682, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (653, 682, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (654, 682, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (655, 682, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (656, 682, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (657, 682, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (658, 682, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (659, 683, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (660, 683, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (661, 683, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (662, 683, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (663, 683, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (664, 683, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (665, 683, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (666, 684, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (667, 684, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (668, 684, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (669, 684, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (670, 684, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (671, 684, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (672, 684, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (673, 685, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (674, 685, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (675, 685, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (676, 685, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (677, 685, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (678, 685, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (679, 685, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (680, 686, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (681, 686, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (682, 686, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (683, 686, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (684, 686, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (685, 686, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (686, 686, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (687, 687, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (688, 687, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (689, 687, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (690, 687, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (691, 687, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (692, 687, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (693, 687, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (694, 688, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (695, 688, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (696, 688, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (697, 688, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (698, 688, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (699, 688, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (700, 688, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (701, 689, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (702, 689, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (703, 689, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (704, 689, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (705, 689, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (706, 689, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (707, 689, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (708, 690, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (709, 690, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (710, 690, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (711, 690, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (712, 690, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (713, 690, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (714, 690, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (715, 691, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (716, 691, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (717, 691, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (718, 691, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (719, 691, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (720, 691, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (721, 691, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (722, 692, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (723, 692, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (724, 692, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (725, 692, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (726, 692, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (727, 692, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (728, 692, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (729, 693, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (730, 693, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (731, 693, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (732, 693, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (733, 693, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (734, 693, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (735, 693, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (736, 694, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (737, 694, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (738, 694, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (739, 694, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (740, 694, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (741, 694, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (742, 694, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (743, 695, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (744, 695, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (745, 695, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (746, 695, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (747, 695, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (748, 695, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (749, 695, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (750, 696, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (751, 696, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (752, 696, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (753, 696, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (754, 696, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (755, 696, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (756, 696, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (757, 697, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (758, 697, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (759, 697, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (760, 697, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (761, 697, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (762, 697, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (763, 697, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (764, 698, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (765, 698, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (766, 698, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (767, 698, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (768, 698, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (769, 698, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (770, 698, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (771, 699, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (772, 699, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (773, 699, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (774, 699, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (775, 699, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (776, 699, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (777, 699, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (778, 700, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (779, 700, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (780, 700, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (781, 700, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (782, 700, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (783, 700, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (784, 700, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (785, 701, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (786, 701, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (787, 701, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (788, 701, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (789, 701, '5', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (790, 701, '6', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (791, 701, '7', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (792, 702, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (793, 702, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (794, 702, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (795, 702, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (796, 702, '5', '00:00~20:00');
INSERT INTO `platform_open_time` VALUES (797, 702, '6', NULL);
INSERT INTO `platform_open_time` VALUES (798, 702, '7', '21:01~24:00');
INSERT INTO `platform_open_time` VALUES (799, 703, '1', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (800, 703, '2', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (801, 703, '3', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (802, 703, '4', '00:00~24:00');
INSERT INTO `platform_open_time` VALUES (803, 703, '5', '00:00~20:00');
INSERT INTO `platform_open_time` VALUES (804, 703, '6', NULL);
INSERT INTO `platform_open_time` VALUES (805, 703, '7', '21:01~24:00');

-- ----------------------------
-- Table structure for platform_product_data
-- ----------------------------
DROP TABLE IF EXISTS `platform_product_data`;
CREATE TABLE `platform_product_data`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '数据ID',
  `pid` bigint NOT NULL COMMENT '产品ID',
  `name` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品名称',
  `price` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '当前市价',
  `open` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开盘价',
  `close` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '本阶段收盘价-即市价',
  `high` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最高市价',
  `low` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最低市价',
  `diff` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易笔数',
  `diffrate` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '波幅',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `rands` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '涨跌幅',
  `point` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '以基础币种计量的交易量（以滚动24小时计）',
  `isdelete` int NULL DEFAULT 0 COMMENT '是否删除',
  `bid_price` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '买入价',
  `ask_price` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '卖出价',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index`(`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 186 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品相关数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of platform_product_data
-- ----------------------------
INSERT INTO `platform_product_data` VALUES (82, 601, 'USD/CNY', '6.90647', '6.89421', '6.8951', '6.89725', '6.89220', NULL, NULL, '2023-02-26 19:22:41', NULL, '2023-04-24 22:23:08', '0.18', NULL, '6.89421', 0, '6.89502200', '6.89526500');
INSERT INTO `platform_product_data` VALUES (83, 602, 'BTC/USD', '27486.83', '27816.85000000', '27562.17', '27816.85000000', '27415.56000000', NULL, NULL, '2023-02-26 20:15:49', NULL, '2023-04-24 08:24:03', '-1.1900000000000002', NULL, '27816.85000000', 0, '27562.17000000', '27562.18000000');
INSERT INTO `platform_product_data` VALUES (84, 603, 'ETH/USDT', '1856.34', '1874.17000000', '1861.24', '1874.17000000', '1846.45000000', NULL, NULL, '2023-02-26 20:17:25', NULL, '2023-04-24 08:24:03', '-0.95', NULL, '1874.17000000', 0, '1861.23000000', '1861.24000000');
INSERT INTO `platform_product_data` VALUES (85, 604, 'FIL/USDT', '5.237', '5.32900000', '5.25', '5.32900000', '5.21000000', NULL, NULL, '2023-02-26 20:18:42', NULL, '2023-04-24 08:24:08', '-1.73', NULL, '5.32900000', 0, '5.24900000', '5.25000000');
INSERT INTO `platform_product_data` VALUES (86, 605, 'LTC/USDT', '86.48', '87.00000000', '86.6', '87.02000000', '85.43000000', NULL, NULL, '2023-02-26 20:23:18', NULL, '2023-04-24 08:24:05', '-0.6', NULL, '87.00000000', 0, '86.61000000', '86.62000000');
INSERT INTO `platform_product_data` VALUES (87, 606, 'DOT/USDT', '5.883', '5.94900000', '5.904', '5.94900000', '5.85100000', NULL, NULL, '2023-02-26 20:24:32', NULL, '2023-04-24 08:24:07', '-1.11', NULL, '5.94900000', 0, '5.90400000', '5.90500000');
INSERT INTO `platform_product_data` VALUES (88, 607, 'USD/JPY', '134.603', '133.96400', '133.924', '134.00800', '133.89000', NULL, NULL, '2023-02-26 20:27:23', NULL, '2023-04-24 22:23:08', '0.48', NULL, '133.96400', 0, '133.92030000', '133.93030000');
INSERT INTO `platform_product_data` VALUES (89, 608, 'EUR/USD', '1.1026', '1.10000', '1.0995', '1.10000', '1.09902', NULL, NULL, '2023-02-26 20:34:45', NULL, '2023-04-24 22:23:09', '0.24', NULL, '1.10000', 0, '1.09947084', '1.09953411');
INSERT INTO `platform_product_data` VALUES (90, 609, 'SOHU', '13.7855', '13.7500', '13.84', '13.9500', '13.6700', NULL, NULL, '2023-02-26 20:41:26', NULL, '2023-04-24 22:23:12', '0.26', NULL, '13.7500', 0, '13.84', '13.84');
INSERT INTO `platform_product_data` VALUES (91, 610, 'GOOG', '105.64', '105.4700', '105.41', '106.0000', '104.7800', NULL, NULL, '2023-02-26 20:42:51', NULL, '2023-04-24 22:23:14', '0.16', NULL, '105.4700', 0, '105.41', '105.41');
INSERT INTO `platform_product_data` VALUES (92, 611, 'MSFT', '285.34', '285.0100', '285.76', '286.2700', '283.0608', NULL, NULL, '2023-02-26 20:44:43', NULL, '2023-04-24 22:23:14', '0.12', NULL, '285.0100', 0, '285.76', '285.76');
INSERT INTO `platform_product_data` VALUES (93, 612, 'AAPL', '164.92', '165.0500', '165.02', '166.4521', '164.4900', NULL, NULL, '2023-02-26 20:47:21', NULL, '2023-04-24 22:23:15', '-0.08', NULL, '165.0500', 0, '165.02', '165.02');
INSERT INTO `platform_product_data` VALUES (94, 613, 'NTES', '90.2', '90.2200', '90.2', '91.1200', '89.9150', NULL, NULL, '2023-02-26 20:49:36', NULL, '2023-04-24 22:23:16', '-0.02', NULL, '90.2200', 0, '90.2', '90.2');
INSERT INTO `platform_product_data` VALUES (95, 614, 'USD/CHF', '0.88869', '0.89180', '0.8922', '0.89241', '0.89170', NULL, NULL, '2023-03-13 20:24:05', NULL, '2023-04-24 22:23:09', '-0.35000000000000003', NULL, '0.89180', 0, '0.89221700', '0.89225700');
INSERT INTO `platform_product_data` VALUES (96, 615, 'USD/HKD', '7.849', '7.84710', '7.8476', '7.84800', '7.84650', NULL, NULL, '2023-03-13 20:27:13', NULL, '2023-04-24 22:23:10', '0.02', NULL, '7.84710', 0, '7.84740200', '7.84777400');
INSERT INTO `platform_product_data` VALUES (97, 616, 'USD/SGD', '1.33409', '1.33344', '1.3339', '1.33440', '1.33344', NULL, NULL, '2023-03-13 20:28:19', NULL, '2023-04-24 22:23:10', '0.05', NULL, '1.33344', 0, '1.33388400', '1.33394800');
INSERT INTO `platform_product_data` VALUES (98, 617, 'GBP/USD', '1.24554', '1.24494', '1.2441', '1.24496', '1.24400', NULL, NULL, '2023-03-13 20:29:47', NULL, '2023-04-24 22:23:10', '0.05', NULL, '1.24494', 0, '1.24404062', '1.24409088');
INSERT INTO `platform_product_data` VALUES (99, 618, 'HKD/CNY', '0.8778', '0.87570', '0.8777', '0.88000', '0.87560', NULL, NULL, '2023-03-13 20:31:40', NULL, '2023-04-24 22:23:11', '0.24', NULL, '0.87570', 0, '0.87768000', '0.87772000');
INSERT INTO `platform_product_data` VALUES (100, 619, 'DOGE/USD', '0.07857', '0.08029000', '0.0788', '0.08030000', '0.07908000', NULL, NULL, '2023-03-13 20:34:27', NULL, '2023-04-24 08:24:11', '-2.1399999999999997', NULL, '0.08029000', 0, '0.07879000', '0.07880000');
INSERT INTO `platform_product_data` VALUES (101, 620, 'MATIC/USD', '0.4644', '0.47200000', '0.4641', '0.47200000', '0.46120000', NULL, NULL, '2023-03-13 20:36:09', NULL, '2023-04-24 08:24:14', '-1.6099999999999999', NULL, '0.47200000', 0, '0.46410000', '0.46420000');
INSERT INTO `platform_product_data` VALUES (102, 621, 'TM', '134.74', '134.4200', '134.67', '134.7900', '133.3900', NULL, NULL, '2023-03-18 09:06:15', NULL, '2023-04-24 22:23:16', '0.24', NULL, '134.4200', 0, '134.67', '134.67');
INSERT INTO `platform_product_data` VALUES (103, 622, 'KYCCF', '107.3', '106.1000', '106.96', '108.1500', '105.0800', NULL, NULL, '2023-03-18 09:10:42', NULL, '2023-04-24 22:23:17', '1.13', NULL, '106.1000', 0, '106.96', '106.96');
INSERT INTO `platform_product_data` VALUES (104, 623, 'BRK-A', '497149.5', '495307.0000', '496404.98', '499078.9988', '492891.4300', NULL, NULL, '2023-03-18 09:30:41', NULL, '2023-04-24 22:23:17', '0.37', NULL, '495307.0000', 0, '496404.98', '496404.98');
INSERT INTO `platform_product_data` VALUES (105, 624, 'NVDA', '271.4001', '269.5200', '271.19', '271.8300', '267.2200', NULL, NULL, '2023-03-18 09:33:44', NULL, '2023-04-24 22:23:17', '0.7000000000000001', NULL, '269.5200', 0, '271.19', '271.19');
INSERT INTO `platform_product_data` VALUES (106, 625, 'TSLA', '165.1', '164.8000', '165.08', '166.0000', '161.3208', NULL, NULL, '2023-03-18 09:36:35', NULL, '2023-04-24 22:23:18', '0.18', NULL, '164.8000', 0, '165.08', '165.08');
INSERT INTO `platform_product_data` VALUES (107, 626, 'META', '213.14', '210.2100', '212.89', '213.4100', '209.5800', NULL, NULL, '2023-03-18 09:39:01', NULL, '2023-04-24 22:23:18', '1.39', NULL, '210.2100', 0, '212.89', '212.89');
INSERT INTO `platform_product_data` VALUES (108, 627, 'V', '234.05', '235.0000', '234.05', '235.5680', '233.3800', NULL, NULL, '2023-03-18 09:42:25', NULL, '2023-04-24 22:23:18', '-0.4', NULL, '235.0000', 0, '234.05', '234.05');
INSERT INTO `platform_product_data` VALUES (109, 628, 'UNH', '483.5', '490.0400', '483.82', '490.7300', '482.1400', NULL, NULL, '2023-03-18 09:46:55', NULL, '2023-04-24 22:23:19', '-1.3299999999999998', NULL, '490.0400', 0, '483.82', '483.82');
INSERT INTO `platform_product_data` VALUES (110, 629, 'TRX/USD', '0.06669', '0.06610000', '0.0667', '0.06616000', '0.06552000', NULL, NULL, '2023-03-18 09:54:12', NULL, '2023-04-24 08:24:14', '0.89', NULL, '0.06610000', 0, '0.06664000', '0.06665000');
INSERT INTO `platform_product_data` VALUES (111, 630, 'EOS/USD', '1.052', '1.07300000', '1.055', '1.07300000', '1.04500000', NULL, NULL, '2023-03-18 09:55:31', NULL, '2023-04-24 08:24:15', '-1.96', NULL, '1.07300000', 0, '1.05400000', '1.05500000');
INSERT INTO `platform_product_data` VALUES (112, 631, 'MATIC/USD', '0.9973', '1.02480000', '1.0023', '1.02480000', '1.01050000', NULL, NULL, '2023-03-18 09:57:05', NULL, '2023-04-24 08:24:15', '-2.68', NULL, '1.02480000', 0, '1.00230000', '1.00240000');
INSERT INTO `platform_product_data` VALUES (113, 632, 'ADA/USD', '0.3868', '0.39560000', '0.3891', '0.39560000', '0.38850000', NULL, NULL, '2023-03-18 10:00:59', NULL, '2023-04-24 08:24:15', '-2.22', NULL, '0.39560000', 0, '0.38910000', '0.38920000');
INSERT INTO `platform_product_data` VALUES (115, 634, 'SHIB/USD', '1.0E-5', '0.00001044', '1.084E-5', '0.00001056', '0.00001040', NULL, NULL, '2023-03-18 10:21:07', NULL, '2023-03-21 22:08:36', '-4.21', NULL, '0.00001044', 0, '0.00001083', '0.00001084');
INSERT INTO `platform_product_data` VALUES (116, 635, 'LINK/USD', '7.084', '7.17400000', '6.978', '7.17400000', '7.00000000', NULL, NULL, '2023-03-18 10:22:34', NULL, '2023-04-24 08:24:15', '-1.25', NULL, '7.17400000', 0, '6.97700000', '6.97800000');
INSERT INTO `platform_product_data` VALUES (117, 636, 'ATOM/USD', '10.772', '11.03500000', '10.777', '11.04500000', '10.83100000', NULL, NULL, '2023-03-18 10:24:00', NULL, '2023-04-24 08:24:16', '-2.3800000000000003', NULL, '11.03500000', 0, '10.77700000', '10.77800000');
INSERT INTO `platform_product_data` VALUES (119, 638, 'EOS/USD', '1.052', '1.07300000', '1.066', '1.07300000', '1.04500000', NULL, NULL, '2023-03-21 22:13:54', NULL, '2023-04-24 08:24:16', '-1.96', NULL, '1.07300000', 0, '1.06600000', '1.06700000');
INSERT INTO `platform_product_data` VALUES (121, 639, 'VPU', '151.405', '151.55', '151.32', '152.36', '150.5', NULL, NULL, '2023-03-27 16:16:02', NULL, '2023-04-24 08:24:20', '-0.1', NULL, '150.87', 0, '151.32', '151.32');
INSERT INTO `platform_product_data` VALUES (122, 640, 'RYU', '116.41', '116', '116.41', '116.41', '115.9458', NULL, NULL, '2023-03-27 16:35:51', NULL, '2023-04-24 08:24:21', '0.35000000000000003', NULL, '115.97', 0, '116.41', '116.41');
INSERT INTO `platform_product_data` VALUES (123, 641, 'XLU', '69.52', '69.87', '69.62', '70.11', '69.21', NULL, NULL, '2023-03-27 16:38:14', NULL, '2023-04-24 08:24:22', '-0.5', NULL, '69.42', 0, '69.62', '69.62');
INSERT INTO `platform_product_data` VALUES (124, 642, 'FUTY', '44.99', '45.11', '44.97', '45.205', '44.73', NULL, NULL, '2023-03-27 16:40:55', NULL, '2023-04-24 08:24:22', '-0.27', NULL, '44.82', 0, '44.97', '44.97');
INSERT INTO `platform_product_data` VALUES (125, 643, 'ICF', '55.01', '55.06', '55.0', '55.2311', '54.54', NULL, NULL, '2023-03-27 16:42:03', NULL, '2023-04-24 08:24:23', '-0.09', NULL, '54.92', 0, '55.0', '55.0');
INSERT INTO `platform_product_data` VALUES (126, 644, 'UTES', '44.02', '43.76', '44.02', '44.02', '43.76', NULL, NULL, '2023-03-27 16:43:10', NULL, '2023-03-27 17:16:29', '0.59', NULL, '43.118', 0, '44.02', '44.02');
INSERT INTO `platform_product_data` VALUES (127, 645, 'QLD', '48.0', '47.81', '48.02', '48.27', '47.27', NULL, NULL, '2023-04-01 13:13:25', NULL, '2023-04-24 08:24:24', '0.4', NULL, '47.96', 0, '48.02', '48.02');
INSERT INTO `platform_product_data` VALUES (128, 646, 'ITB', '73.66', '74.26', '73.92', '74.58', '73.44', NULL, NULL, '2023-04-01 13:16:10', NULL, '2023-04-24 08:24:25', '-0.8099999999999999', NULL, '74.18', 0, '73.92', '73.92');
INSERT INTO `platform_product_data` VALUES (129, 647, 'RZV', '88.85', '88.71', '88.85', '89.13', '88.38', NULL, NULL, '2023-04-01 13:18:45', NULL, '2023-04-24 08:24:25', '0.16', NULL, '89.3925', 0, '88.85', '88.85');
INSERT INTO `platform_product_data` VALUES (130, 648, 'FDIS', '64.81', '64.65', '64.82', '65', '64.15', NULL, NULL, '2023-04-01 13:20:55', NULL, '2023-04-24 08:24:26', '0.25', NULL, '64.18', 0, '64.82', '64.82');
INSERT INTO `platform_product_data` VALUES (131, 649, 'NURE', '29.85', '29.76', '29.85', '29.93', '29.59', NULL, NULL, '2023-04-01 13:22:47', NULL, '2023-04-24 08:24:27', '0.3', NULL, '29.78', 0, '29.85', '29.85');
INSERT INTO `platform_product_data` VALUES (132, 650, 'PSCD', '87.82', '87.82', '87.85', '87.85', '87.85', NULL, NULL, '2023-04-01 13:24:18', NULL, '2023-04-24 08:24:27', '0.0', NULL, '87.85', 0, '87.85', '87.85');
INSERT INTO `platform_product_data` VALUES (133, 651, 'VCR', '250.265', '249.37', '250.2', '251.1824', '247.6087', NULL, NULL, '2023-04-01 13:26:14', NULL, '2023-04-24 08:24:28', '0.36', NULL, '247.87', 0, '250.2', '250.2');
INSERT INTO `platform_product_data` VALUES (134, 652, 'XHB', '69.41', '69.77', '69.4', '69.9684', '68.945', NULL, NULL, '2023-04-01 13:28:15', NULL, '2023-04-24 08:24:29', '-0.52', NULL, '69.65', 0, '69.4', '69.4');
INSERT INTO `platform_product_data` VALUES (135, 653, 'BLOK', '19.3', '19.56', '19.3', '19.58', '19.29', NULL, NULL, '2023-04-01 13:30:03', NULL, '2023-04-24 08:24:29', '-1.3299999999999998', NULL, '19.61', 0, '19.3', '19.3');
INSERT INTO `platform_product_data` VALUES (136, 654, 'EWRE', '30.5999', '30.61', '30.62', '30.72', '30.42', NULL, NULL, '2023-04-01 13:32:39', NULL, '2023-04-24 08:24:30', '-0.03', NULL, '30.531', 0, '30.62', '30.62');
INSERT INTO `platform_product_data` VALUES (137, 655, 'RWJ', '110.19', '110.78', '110.19', '110.78', '109.4325', NULL, NULL, '2023-04-01 13:34:49', NULL, '2023-04-24 08:24:30', '-0.53', NULL, '110.46', 0, '110.19', '110.19');
INSERT INTO `platform_product_data` VALUES (138, 656, 'PFFA', '18.975', '18.98', '18.95', '19.07', '18.93', NULL, NULL, '2023-04-01 13:36:18', NULL, '2023-04-24 08:24:31', '-0.03', NULL, '18.96', 0, '18.95', '18.95');
INSERT INTO `platform_product_data` VALUES (139, 657, 'XTL', '75.14', '74.5', '75.14', '75.1619', '74.49', NULL, NULL, '2023-04-01 13:37:43', NULL, '2023-04-24 08:24:31', '0.86', NULL, '74.508', 0, '75.14', '75.14');
INSERT INTO `platform_product_data` VALUES (140, 658, 'FYT', '44.83', '45.09', '44.83', '45.09', '44.566', NULL, NULL, '2023-04-01 13:39:00', NULL, '2023-04-24 08:24:32', '-0.58', NULL, '45.02', 0, '44.83', '44.83');
INSERT INTO `platform_product_data` VALUES (141, 659, 'XLRE', '37.19', '37.23', '37.19', '37.34', '36.88', NULL, NULL, '2023-04-01 13:40:28', NULL, '2023-04-24 08:24:33', '-0.11', NULL, '37.14', 0, '37.19', '37.19');
INSERT INTO `platform_product_data` VALUES (142, 660, 'CIBR', '41.57', '41.4', '41.6', '41.66', '41.33', NULL, NULL, '2023-04-01 13:45:57', NULL, '2023-04-24 08:24:34', '0.41000000000000003', NULL, '41.37', 0, '41.6', '41.6');
INSERT INTO `platform_product_data` VALUES (143, 661, 'PSCT', '123.3798', '123.81', '123.3798', '123.81', '122.81', NULL, NULL, '2023-04-01 13:47:27', NULL, '2023-04-24 08:24:34', '-0.35000000000000003', NULL, '123.7', 0, '123.3798', '123.3798');
INSERT INTO `platform_product_data` VALUES (144, 662, 'AI', '20.17', '20.8000', '20.06', '21.0500', '19.5500', NULL, NULL, '2023-04-01 14:09:53', NULL, '2023-04-24 22:23:19', '-3.0300000000000002', NULL, '20.8000', 0, '20.06', '20.06');
INSERT INTO `platform_product_data` VALUES (145, 663, 'KPELY', '32.97', '33.0100', '33.01', '33.2000', '32.5650', NULL, NULL, '2023-04-01 14:12:03', NULL, '2023-04-24 22:23:19', '-0.12', NULL, '33.0100', 0, '33.01', '33.01');
INSERT INTO `platform_product_data` VALUES (146, 664, 'SYRVF', '20.08', '20.3800', '20.13', '20.4700', '19.7750', NULL, NULL, '2023-04-01 14:13:34', NULL, '2023-04-24 22:23:20', '-1.47', NULL, '20.3800', 0, '20.13', '20.13');
INSERT INTO `platform_product_data` VALUES (147, 665, 'MGPUF', '144.88', '144.0700', '145.19', '146.8000', '143.5200', NULL, NULL, '2023-04-01 14:15:28', NULL, '2023-04-24 22:23:20', '0.5599999999999999', NULL, '144.0700', 0, '145.19', '145.19');
INSERT INTO `platform_product_data` VALUES (148, 666, 'BB', '4.19', '4.2200', '4.23', '4.2500', '4.1800', NULL, NULL, '2023-04-01 14:18:13', NULL, '2023-04-24 22:23:20', '-0.7100000000000001', NULL, '4.2200', 0, '4.23', '4.23');
INSERT INTO `platform_product_data` VALUES (149, 667, 'EVGO', '6.15', '6.0550', '6.21', '6.2700', '6.0000', NULL, NULL, '2023-04-01 14:20:10', NULL, '2023-04-24 22:23:21', '1.5699999999999998', NULL, '6.0550', 0, '6.21', '6.21');
INSERT INTO `platform_product_data` VALUES (150, 668, 'RPD', '4.28', '4.1800', '4.28', '4.2900', '4.1500', NULL, NULL, '2023-04-01 14:21:49', NULL, '2023-04-24 22:23:21', '2.39', NULL, '4.1800', 0, '4.28', '4.28');
INSERT INTO `platform_product_data` VALUES (151, 669, 'CL', '77.6', '77.970', '77.61', '77.980', '77.600', NULL, NULL, '2023-04-14 21:44:51', NULL, '2023-04-24 08:24:19', '-0.47000000000000003', NULL, '77.870', 0, '77.600', '77.610');
INSERT INTO `platform_product_data` VALUES (152, 670, 'OIL', '81.199', '81.670', '81.21', '81.670', '81.200', NULL, NULL, '2023-04-14 22:02:44', NULL, '2023-04-24 08:24:19', '-0.58', NULL, '81.460', 0, '81.200', '81.220');
INSERT INTO `platform_product_data` VALUES (153, 671, 'NG', '2.411', '2.395', '2.41', '2.417', '2.388', NULL, NULL, '2023-04-14 22:04:22', NULL, '2023-04-24 08:24:19', '0.67', NULL, '2.408', 0, '2.412', '2.414');
INSERT INTO `platform_product_data` VALUES (154, 672, 'HO', '2.475', '2.491', '2.48', '2.491', '2.475', NULL, NULL, '2023-04-14 22:05:27', NULL, '2023-04-24 08:24:19', '-0.64', NULL, '2.479', 0, '2.476', '2.477');
INSERT INTO `platform_product_data` VALUES (155, 673, 'GASO', '2.565', '2.584', '2.56', '2.584', '2.563', NULL, NULL, '2023-04-14 22:06:38', NULL, '2023-04-24 08:24:19', '-0.74', NULL, '2.575', 0, '2.563', '2.564');
INSERT INTO `platform_product_data` VALUES (156, 674, 'GC', '1993.27', '1992.000', '1993.91', '1995.800', '1991.200', NULL, NULL, '2023-04-14 22:17:32', NULL, '2023-04-24 08:24:19', '0.06', NULL, '1990.500', 0, '1993.600', '1993.800');
INSERT INTO `platform_product_data` VALUES (157, 675, 'SI', '25.133', '25.155', '25.15', '25.205', '25.110', NULL, NULL, '2023-04-14 22:18:47', NULL, '2023-04-24 08:24:19', '-0.09', NULL, '25.058', 0, '25.150', '25.160');
INSERT INTO `platform_product_data` VALUES (158, 676, 'HG', '398.225', '398.350', '398.32', '399.100', '398.000', NULL, NULL, '2023-04-14 22:20:07', NULL, '2023-04-24 08:24:19', '-0.03', NULL, '398.000', 0, '398.350', '398.400');
INSERT INTO `platform_product_data` VALUES (159, 677, 'LHC', '86.195', '85.025', '86.22', '86.825', '84.625', NULL, NULL, '2023-04-14 22:21:03', NULL, '2023-04-24 08:24:19', '1.38', NULL, '85.075', 0, '86.125', '86.175');
INSERT INTO `platform_product_data` VALUES (160, 678, 'C', '614.25', '615.500', '617.1', '618.000', '615.250', NULL, NULL, '2023-04-14 22:22:33', NULL, '2023-04-24 08:24:19', '-0.2', NULL, '615.250', 0, '616.750', '617.250');
INSERT INTO `platform_product_data` VALUES (161, 679, 'S', '1448.7', '1450.250', '1450.65', '1452.000', '1448.250', NULL, NULL, '2023-04-14 22:24:22', NULL, '2023-04-24 08:24:20', '-0.11', NULL, '1449.000', 0, '1450.250', '1450.750');
INSERT INTO `platform_product_data` VALUES (162, 680, 'BO', '53.328', '53.570', '53.35', '53.600', '53.310', NULL, NULL, '2023-04-14 22:25:26', NULL, '2023-04-24 08:24:20', '-0.44999999999999996', NULL, '53.570', 0, '53.340', '53.370');
INSERT INTO `platform_product_data` VALUES (163, 681, 'SM', '444.18', '444.100', '444.71', '444.800', '443.000', NULL, NULL, '2023-04-14 22:26:41', NULL, '2023-04-24 08:24:20', '0.02', NULL, '443.600', 0, '444.600', '444.700');
INSERT INTO `platform_product_data` VALUES (164, 682, 'W', '678.275', '679.000', '679.75', '682.000', '676.250', NULL, NULL, '2023-04-14 22:27:48', NULL, '2023-04-24 08:24:20', '-0.11', NULL, '673.000', 0, '679.250', '679.750');
INSERT INTO `platform_product_data` VALUES (165, 683, 'CT', '80.114', '80.190', '80.15', '81.050', '79.700', NULL, NULL, '2023-04-14 22:29:28', NULL, '2023-04-24 08:24:20', '-0.09', NULL, '80.090', 0, '80.190', '80.230');
INSERT INTO `platform_product_data` VALUES (166, 684, 'RS', '24.378', '25.010', '24.31', '25.090', '24.180', NULL, NULL, '2023-04-14 22:30:33', NULL, '2023-04-24 08:24:20', '-2.53', NULL, '24.740', 0, '24.320', '24.340');
INSERT INTO `platform_product_data` VALUES (167, 685, 'KC', '191.36', '193.000', '191.41', '194.800', '190.100', NULL, NULL, '2023-04-14 22:31:28', NULL, '2023-04-24 08:24:20', '-0.8500000000000001', NULL, '193.900', 0, '191.450', '191.550');
INSERT INTO `platform_product_data` VALUES (168, 686, 'XAU', '1983.47', '1980.61', '1983.49', '1985.27', '1980.39', NULL, NULL, '2023-04-14 22:37:04', NULL, '2023-04-24 08:24:20', '0.13999999999999999', NULL, '1982.52', 0, '1983.49', '1983.80');
INSERT INTO `platform_product_data` VALUES (169, 687, 'XAG', '25.051', '25.06', '25.06', '25.11', '25.02', NULL, NULL, '2023-04-14 22:38:17', NULL, '2023-04-24 08:24:20', '-0.04', NULL, '25.06', 0, '25.06', '25.11');
INSERT INTO `platform_product_data` VALUES (170, 688, 'CAD', '8784.55', '8787.00', '8786.8', '8789.50', '8777.50', NULL, NULL, '2023-04-14 22:39:26', NULL, '2023-04-24 08:24:20', '-0.03', NULL, '8794.50', 0, '8784.50', '8787.00');
INSERT INTO `platform_product_data` VALUES (171, 689, 'AHD', '2396.45', '2399.000', '2399.55', '2400.000', '2396.000', NULL, NULL, '2023-04-14 22:41:10', NULL, '2023-04-24 08:24:20', '-0.11', NULL, '2396.500', 0, '2399.000', '2400.000');
INSERT INTO `platform_product_data` VALUES (172, 690, 'ZSD', '2718.95', '2722.50', '2722.5', '2724.00', '2722.50', NULL, NULL, '2023-04-14 22:42:01', NULL, '2023-04-24 08:24:20', '-0.13', NULL, '2719.00', 0, '2721.50', '2724.00');
INSERT INTO `platform_product_data` VALUES (173, 691, 'NID', '24865.5', '25125.00', '24650.0', '25190.00', '24280.00', NULL, NULL, '2023-04-14 22:43:01', NULL, '2023-04-24 08:24:20', '-1.03', NULL, '25090.00', 0, '0.00', '0.00');
INSERT INTO `platform_product_data` VALUES (174, 692, 'PBD', '2154.9', '2154.00', '2156.65', '2158.00', '2154.00', NULL, NULL, '2023-04-14 22:43:56', NULL, '2023-04-24 08:24:20', '0.04', NULL, '2161.00', 0, '2155.50', '2157.50');
INSERT INTO `platform_product_data` VALUES (175, 693, 'SND', '26167.0', '26205.00', '26205.0', '26205.00', '26205.00', NULL, NULL, '2023-04-14 22:46:06', NULL, '2023-04-24 08:24:21', '-0.15', NULL, '26150.00', 0, '0.00', '0.00');
INSERT INTO `platform_product_data` VALUES (176, 694, 'XPT', '1133.61', '1142.500', '1133.43', '1142.500', '1132.800', NULL, NULL, '2023-04-14 22:47:55', NULL, '2023-04-24 08:24:21', '-0.7799999999999999', NULL, '1138.700', 0, '1133.400', '1134.200');
INSERT INTO `platform_product_data` VALUES (177, 695, 'XPD', '1601.35', '1604.500', '1601.35', '1609.000', '1600.000', NULL, NULL, '2023-04-14 22:48:54', NULL, '2023-04-24 08:24:21', '-0.2', NULL, '1607.400', 0, '1600.000', '1605.500');
INSERT INTO `platform_product_data` VALUES (178, 696, 'FCPO', '3701.4', '3741.000', '3701.4', '3773.000', '3669.000', NULL, NULL, '2023-04-14 22:49:54', NULL, '2023-04-24 08:24:21', '-1.06', NULL, '3735.000', 0, '3705.000', '3712.000');
INSERT INTO `platform_product_data` VALUES (179, 697, 'GAS', '719.7', '722.500', '719.48', '722.500', '719.250', NULL, NULL, '2023-04-14 22:51:23', NULL, '2023-04-24 08:24:21', '-0.38999999999999996', NULL, '721.750', 0, '719.250', '719.750');
INSERT INTO `platform_product_data` VALUES (180, 698, 'RSS3', '206.68', '209.300', '206.59', '209.700', '206.500', NULL, NULL, '2023-04-14 22:52:27', NULL, '2023-04-24 08:24:21', '-1.25', NULL, '210.100', 0, '206.600', '206.800');
INSERT INTO `platform_product_data` VALUES (181, 699, 'FEF', '105.135', '108.500', '105.18', '108.750', '105.000', NULL, NULL, '2023-04-14 22:53:39', NULL, '2023-04-24 08:24:21', '-3.1', NULL, '108.080', 0, '105.150', '105.500');
INSERT INTO `platform_product_data` VALUES (182, 700, 'GLS', '921.475', '722.500', '719.48', '722.500', '719.250', NULL, NULL, '2023-04-14 22:54:31', NULL, '2023-04-24 08:24:21', '27.54', NULL, '721.750', 0, '719.250', '719.750');
INSERT INTO `platform_product_data` VALUES (183, 701, 'LE', '164.508', '164.400', '164.42', '164.575', '163.550', NULL, NULL, '2023-04-14 22:56:22', NULL, '2023-04-24 08:24:21', '0.06999999999999999', NULL, '164.350', 0, '164.350', '164.400');
INSERT INTO `platform_product_data` VALUES (184, 702, 'AUD/USD', '0.66889', '0.67000', '0.6688', '0.67000', '0.66848', NULL, NULL, '2023-04-15 20:43:45', NULL, '2023-04-24 22:23:11', '-0.16999999999999998', NULL, '0.67000', 0, '0.66875633', '0.66881168');
INSERT INTO `platform_product_data` VALUES (185, 703, 'CAD/USD', '0.73908', '0.73859', '0.7384', '0.73859', '0.73770', NULL, NULL, '2023-04-15 20:45:46', NULL, '2023-04-24 22:23:12', '0.06999999999999999', NULL, '0.73859', 0, '0.73842774', '0.73845905');

-- ----------------------------
-- Table structure for platform_product_info
-- ----------------------------
DROP TABLE IF EXISTS `platform_product_info`;
CREATE TABLE `platform_product_info`  (
  `pid` bigint NOT NULL AUTO_INCREMENT,
  `ptitle` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品名称',
  `full_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品全称',
  `commission` double(18, 4) NULL DEFAULT NULL COMMENT '手续费',
  `otid` int NULL DEFAULT NULL COMMENT '开市方案id',
  `isopen` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '是否开市',
  `type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品类型',
  `point_low` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0.00000' COMMENT '波动最小值',
  `point_top` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0.00000' COMMENT '波动最大值',
  `rands` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0.00000' COMMENT '随机波动范围',
  `money_list` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '快捷下单金额',
  `isdelete` int NULL DEFAULT NULL COMMENT '是否删除',
  `procode` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT ' 产品代码',
  `gearing` double(18, 2) NULL DEFAULT NULL COMMENT '杠杆倍数',
  `hand_money` double(18, 2) NULL DEFAULT NULL COMMENT '一手（x）元',
  `add_data` double(18, 4) NULL DEFAULT 0.0000 COMMENT '除汇率以外的算法',
  `protime` varchar(288) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间玩法间隔',
  `propoint` varchar(288) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '点位玩法间隔',
  `proscale` varchar(288) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '盈亏比例',
  `top_or_not` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否置顶推荐',
  `is_index` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否推荐至首页',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `min_order` double(18, 2) NULL DEFAULT NULL COMMENT '最低下单',
  `max_order` double(18, 2) NULL DEFAULT NULL COMMENT '最高下单',
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注',
  `pic_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品logo',
  `point_money` double(18, 4) NULL DEFAULT NULL COMMENT '合约产品每点x钱',
  `decimal_places` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '小数点位数',
  `seq` bigint NULL DEFAULT 1 COMMENT '排序值',
  `pc_index` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否展示到PC引导页',
  PRIMARY KEY (`pid`) USING BTREE,
  INDEX `index`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 704 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of platform_product_info
-- ----------------------------
INSERT INTO `platform_product_info` VALUES (601, 'USD/CNH', 'China', 0.0100, NULL, '0', '1', '1', '10000000', '0.0008', NULL, NULL, 'USD/CNH', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-02-26 19:22:41', 100.00, 5000000.00, NULL, '975a2bc3b8c1eeb2723a14101c7da73a.png', 1.0000, '4', 1, '1');
INSERT INTO `platform_product_info` VALUES (602, 'BTC/USD', 'Bitcoin', 0.0100, NULL, '0', '2', '0', '0', '0.0008', NULL, NULL, 'BTC/USD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-02-26 20:15:48', 100.00, 5000000.00, NULL, 'b7fac132da5bb891db0e9a7cb227f10f.png', 1.0000, '4', 1, '1');
INSERT INTO `platform_product_info` VALUES (603, 'ETH/USD', 'Ethereum', 0.0100, NULL, '0', '2', '0', '0', '0.0008', NULL, NULL, 'ETH/USD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-02-26 20:17:25', 100.00, 5000000.00, NULL, '51169f78d8967ac00870a71139ddb010.png', 1.0000, '4', 2, '1');
INSERT INTO `platform_product_info` VALUES (604, 'FIL/USD', 'Filcoin', 0.0100, NULL, '0', '2', '0', '0', '0.0008', NULL, NULL, 'FIL/USD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-02-26 20:18:42', 100.00, 5000000.00, NULL, 'ce12a242dbd5cd616f7139935d6d2914.png', 1.0000, '4', 5, NULL);
INSERT INTO `platform_product_info` VALUES (605, 'LTC/USD', 'Litecoin', 0.0100, NULL, '0', '2', '0', '0', '0.0008', NULL, NULL, 'LTC/USD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '0', '2023-02-26 20:23:18', 100.00, 5000000.00, NULL, '530193ad79049f8f28322523fb2e48e9.png', 1.0000, '4', 3, NULL);
INSERT INTO `platform_product_info` VALUES (606, 'DOT/USD', 'Polkadot', 0.0100, NULL, '0', '2', '0', '0', '0.0008', NULL, NULL, 'DOT/USD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-02-26 20:24:31', 100.00, 5000000.00, NULL, 'ba8bb604262f7a045d8d1af5bbaa7e1f.png', 1.0000, '4', 4, NULL);
INSERT INTO `platform_product_info` VALUES (607, 'USD/JPY', 'Japan', 0.0100, NULL, '0', '1', '0', '0', '0.0008', NULL, NULL, 'USD/JPY', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-02-26 20:27:23', 100.00, 5000000.00, NULL, 'b3cb3795b56ec852fcdf79b42e717da7.png', 1.0000, '4', 2, '1');
INSERT INTO `platform_product_info` VALUES (608, 'EUR/USD', 'Us Dollar', 0.0100, NULL, '0', '1', '0', '0', '0.0008', NULL, NULL, 'EUR/USD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-02-26 20:34:44', 100.00, 5000000.00, NULL, '1a940a21a95d408603e7f768d95f9843.png', 1.0000, '4', 3, NULL);
INSERT INTO `platform_product_info` VALUES (609, 'Sohu.com Ltd', 'Sohu.com Ltd', 0.0100, NULL, '0', '3', '0', '0', '0.0008', NULL, NULL, 'SOHU', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '0', '2023-02-26 20:41:24', 100.00, 5000000.00, NULL, 'dd2f66b107b1f943331c8d107250e640.png', 1.0000, '4', 1, NULL);
INSERT INTO `platform_product_info` VALUES (610, 'Alphabet', 'GOOGL', 0.0100, NULL, '0', '3', '0', '0', '0.0008', NULL, NULL, 'GOOGL', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-02-26 20:42:49', 100.00, 5000000.00, NULL, '1068123f0a6bc16585e5bdc5c40ec205.png', 1.0000, '4', 2, NULL);
INSERT INTO `platform_product_info` VALUES (611, 'Microsoft', 'MSFT', 0.0100, NULL, '0', '3', '0', '0', '0.0008', NULL, NULL, 'MSFT', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-02-26 20:44:41', 100.00, 5000000.00, NULL, '338ecc06384ae9ad0c0fdac90fd23a8b.png', 1.0000, '4', 3, NULL);
INSERT INTO `platform_product_info` VALUES (612, 'Apple Inc', 'AAPL', 0.0100, NULL, '0', '3', '0', '0', '0.0008', NULL, NULL, 'AAPL', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-02-26 20:47:19', 100.00, 5000000.00, NULL, 'a1af7fed02f7f6d65526b7208aaab0d2.png', 1.0000, '4', 4, NULL);
INSERT INTO `platform_product_info` VALUES (613, 'NetEase Inc', 'NetEase Inc', 0.0100, NULL, '0', '3', '0', '0', '0.0008', NULL, NULL, 'NTES', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-02-26 20:49:34', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 5, NULL);
INSERT INTO `platform_product_info` VALUES (614, 'USD/CHF', 'Switzerland', 0.0100, NULL, '0', '1', '0', '0', '0.0008', NULL, NULL, 'USD/CHF', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-03-13 20:24:04', 100.00, 5000000.00, NULL, 'cf508540b0d7d27f7ca2807f40a31270.png', 1.0000, '4', 4, NULL);
INSERT INTO `platform_product_info` VALUES (615, 'USD/HKD', 'USDHKD', 0.0100, NULL, '0', '1', '0', '0', '0.0008', NULL, NULL, 'USD/HKD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-03-13 20:27:13', 100.00, 5000000.00, NULL, 'e069dee072bb879b3606efd6efe9e929.png', 1.0000, '4', 5, NULL);
INSERT INTO `platform_product_info` VALUES (616, 'USD/SGD', 'USDSGD', 0.0100, NULL, '0', '1', '0', '0', '0.0008', NULL, NULL, 'USD/SGD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-03-13 20:28:19', 100.00, 5000000.00, NULL, '62a6eafce13e02fcab3d0fc4bceddd06.png', 1.0000, '4', 6, NULL);
INSERT INTO `platform_product_info` VALUES (617, 'GBP/USD', 'Us Dollar', 0.0100, NULL, '0', '1', '0', '0', '0.0008', NULL, NULL, 'GBP/USD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-03-13 20:29:47', 100.00, 5000000.00, NULL, 'ac9c46545e4bf77110db197a33a73c28.png', 1.0000, '4', 7, NULL);
INSERT INTO `platform_product_info` VALUES (618, 'HKD/CNY', 'Chinaese', 0.0100, NULL, '0', '1', '0', '0', '0.0008', NULL, NULL, 'HKD/CNY', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-03-13 20:31:40', 100.00, 5000000.00, NULL, '045380fa8f888f036c7675828ced921e.png', 1.0000, '4', 8, NULL);
INSERT INTO `platform_product_info` VALUES (619, 'DOGE/USD', 'DogeCoin', 0.0100, NULL, '0', '2', '0', '0', '0.0008', NULL, NULL, 'DOGE/USD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-03-13 20:34:27', 100.00, 5000000.00, NULL, '27629ad25c15205741905305a340bbf7.png', 1.0000, '4', 6, NULL);
INSERT INTO `platform_product_info` VALUES (620, 'XRP/USD', 'XRP', 0.0100, NULL, '0', '2', '0', '0', '0.0008', NULL, NULL, 'XRP/USD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-03-13 20:36:09', 100.00, 5000000.00, NULL, '132523db1970f78798e2934cf0763d9e.png', 1.0000, '4', 7, NULL);
INSERT INTO `platform_product_info` VALUES (621, 'Toyota Motor', 'Toyota Motor', 0.0100, NULL, '0', '3', '0.03', '0.08', '0.0008', NULL, NULL, 'TM', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-03-18 09:06:15', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 6, NULL);
INSERT INTO `platform_product_info` VALUES (622, 'Amazon.com', 'AMZN', 0.0100, NULL, '0', '3', '0.02', '0.06', '0.0008', NULL, NULL, 'AMZN', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-03-18 09:10:42', 100.00, 5000000.00, NULL, '019fd39aa6d112e64a6fc3334e298acb.png', 1.0000, '4', 7, NULL);
INSERT INTO `platform_product_info` VALUES (623, 'Berkshire Hathaway Inc', 'Berkshire Hathaway Inc', 0.0100, NULL, '0', '3', '0.03', '0.05', '0.0008', NULL, NULL, 'BRK-A', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-03-18 09:30:41', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 8, NULL);
INSERT INTO `platform_product_info` VALUES (624, 'NVIDIA Corp', 'NVIDIA Corp', 0.0100, NULL, '0', '3', '0.02', '0.05', '0.0008', NULL, NULL, 'NVDA', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-03-18 09:33:43', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 9, NULL);
INSERT INTO `platform_product_info` VALUES (625, 'Tesla Inc', 'Tesla Inc', 0.0100, NULL, '0', '3', '0.03', '0.06', '0.0008', NULL, NULL, 'TSLA', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-03-18 09:36:35', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 10, NULL);
INSERT INTO `platform_product_info` VALUES (626, 'Meta Platforms Inc', 'Meta Platforms Inc', 0.0100, NULL, '0', '3', '0.02', '0.06', '0.0008', NULL, NULL, 'META', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-03-18 09:39:01', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 11, NULL);
INSERT INTO `platform_product_info` VALUES (627, 'Visa Inc', 'Visa Inc', 0.0100, NULL, '0', '3', '0.02', '0.06', '0.0008', NULL, NULL, 'V', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-03-18 09:42:25', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 12, NULL);
INSERT INTO `platform_product_info` VALUES (628, 'Unitedhealth Group Inc', 'Unitedhealth Group Inc', 0.0100, NULL, '0', '3', '0.02', '0.05', '0.0008', NULL, NULL, 'UNH', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-03-18 09:46:55', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 13, NULL);
INSERT INTO `platform_product_info` VALUES (629, 'TRX/USD', 'TRX', 0.0100, NULL, '0', '2', '0.0002', '0.0006', '0.0008', NULL, NULL, 'TRX/USD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-03-18 09:54:12', 100.00, 5000000.00, NULL, 'e8249f4d3eb896dd5c93b0ed25c5cbcc.png', 1.0000, '4', 8, NULL);
INSERT INTO `platform_product_info` VALUES (630, 'EOS/USD', 'EOS', 0.0100, NULL, '0', '2', '0.002', '0.006', '0.0008', NULL, NULL, 'EOS/USD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-03-18 09:55:31', 100.00, 5000000.00, NULL, '13ed9f47b2c52a339238335272b707b9.png', 1.0000, '4', 9, NULL);
INSERT INTO `platform_product_info` VALUES (631, 'MATIC/USD', 'MATIC', 0.0100, NULL, '0', '2', '0.0002', '0.0006', '0.0008', NULL, NULL, 'MATIC/USD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-03-18 09:57:05', 100.00, 5000000.00, NULL, '0c4abf7fdc230f2cb800e8a96b9f8b3e.png', 1.0000, '4', 10, NULL);
INSERT INTO `platform_product_info` VALUES (632, 'ADA/USD', 'ADA', 0.0100, NULL, '0', '2', '0.00002', '0.00006', '0.0008', NULL, NULL, 'ADA/USD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-03-18 10:00:59', 100.00, 5000000.00, NULL, 'fd73e92a9e3669b5d96e5d0a1e8b2ddc.png', 1.0000, '4', 11, NULL);
INSERT INTO `platform_product_info` VALUES (635, 'LINK/USD', 'LINK', 0.0100, NULL, '0', '2', '0.002', '0.006', '0.0008', NULL, NULL, 'LINK/USD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-03-18 10:22:34', 100.00, 5000000.00, NULL, '85e9579a33bbe9c2f0333fbd61f571e9.png', 1.0000, '4', 14, NULL);
INSERT INTO `platform_product_info` VALUES (636, 'ATOM/USD', 'ATOM', 0.0100, NULL, '0', '2', '0.002', '0.006', '0.0008', NULL, NULL, 'ATOM/USD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-03-18 10:24:00', 100.00, 5000000.00, NULL, 'f230aa16bbe7ab0bb75c002cdb9c4b64.png', 1.0000, '4', 15, NULL);
INSERT INTO `platform_product_info` VALUES (638, 'EOS/USD', 'EOS/USD', 0.0100, NULL, '0', '2', '0.0002', '0.0006', '0.0008', NULL, NULL, 'EOS/USD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-03-21 22:13:54', 100.00, 5000000.00, NULL, '13ed9f47b2c52a339238335272b707b9.png', 1.0000, '4', 15, '0');
INSERT INTO `platform_product_info` VALUES (639, 'VPU', 'NYSEARCA', 0.0100, NULL, '0', '5', '0', '0', '0.0008', NULL, NULL, 'VPU', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '0', '2023-03-27 16:16:02', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 1, '0');
INSERT INTO `platform_product_info` VALUES (640, 'RYU', 'NYSEARCA', 0.0100, NULL, '0', '5', '0.02', '0.05', '0.0008', NULL, NULL, 'RYU', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-03-27 16:35:51', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 2, '0');
INSERT INTO `platform_product_info` VALUES (641, 'XLU', 'NYSEARCA', 0.0100, NULL, '0', '5', '0.02', '0.05', '0.0008', NULL, NULL, 'XLU', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-03-27 16:38:14', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 3, '0');
INSERT INTO `platform_product_info` VALUES (642, 'FUTY', 'NYSEARCA', 0.0100, NULL, '0', '5', '0.02', '0.05', '0.0008', NULL, NULL, 'FUTY', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-03-27 16:40:55', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 4, '0');
INSERT INTO `platform_product_info` VALUES (643, 'ICF', 'BATS', 0.0100, NULL, '0', '5', '0.02', '0.05', '0.0008', NULL, NULL, 'ICF', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-03-27 16:42:03', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 5, '0');
INSERT INTO `platform_product_info` VALUES (645, 'QLD', 'QLD', 0.0100, NULL, '0', '5', '0.02', '0.03', '0.0008', NULL, NULL, 'QLD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 13:13:24', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 6, '0');
INSERT INTO `platform_product_info` VALUES (646, 'ITB', 'ITB', 0.0100, NULL, '0', '5', '0.02', '0.03', '0.0008', NULL, NULL, 'ITB', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 13:16:10', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 7, '0');
INSERT INTO `platform_product_info` VALUES (647, 'RZV', 'RZV', 0.0100, NULL, '0', '5', '0.02', '0.05', '0.0008', NULL, NULL, 'RZV', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 13:18:45', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 8, '0');
INSERT INTO `platform_product_info` VALUES (648, 'FDIS', 'FDIS', 0.0100, NULL, '0', '5', '0.02', '0.05', '0.0008', NULL, NULL, 'FDIS', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 13:20:55', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 9, '0');
INSERT INTO `platform_product_info` VALUES (649, 'NURE', 'NURE', 0.0100, NULL, '0', '5', '0.02', '0.06', '0.0008', NULL, NULL, 'NURE', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 13:22:47', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 10, '0');
INSERT INTO `platform_product_info` VALUES (650, 'PSCD', 'PSCD', 0.0100, NULL, '0', '5', '0.02', '0.06', '0.0008', NULL, NULL, 'PSCD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 13:24:18', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 11, '0');
INSERT INTO `platform_product_info` VALUES (651, 'VCR', 'VCR', 0.0100, NULL, '0', '5', '0.02', '0.03', '0.0008', NULL, NULL, 'VCR', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 13:26:14', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 12, '0');
INSERT INTO `platform_product_info` VALUES (652, 'XHB', 'XHB', 0.0100, NULL, '0', '5', '0.02', '0.03', '0.0008', NULL, NULL, 'XHB', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 13:28:15', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 13, '0');
INSERT INTO `platform_product_info` VALUES (653, 'BLOK', 'BLOK', 0.0100, NULL, '0', '5', '0.02', '0.03', '0.0008', NULL, NULL, 'BLOK', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 13:30:03', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 14, '0');
INSERT INTO `platform_product_info` VALUES (654, 'EWRE', 'EWRE', 0.0100, NULL, '0', '5', '0.02', '0.03', '0.0008', NULL, NULL, 'EWRE', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 13:32:39', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 15, '0');
INSERT INTO `platform_product_info` VALUES (655, 'RWJ', 'RWJ', 0.0100, NULL, '0', '5', '0.02', '0.03', '0.0008', NULL, NULL, 'RWJ', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 13:34:49', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 16, '0');
INSERT INTO `platform_product_info` VALUES (656, 'PFFA', 'PFFA', 0.0100, NULL, '0', '5', '0.03', '0.05', '0.0008', NULL, NULL, 'PFFA', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 13:36:18', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 17, '0');
INSERT INTO `platform_product_info` VALUES (657, 'XTL', 'XTL', 0.0100, NULL, '0', '5', '0.02', '0.03', '0.0008', NULL, NULL, 'XTL', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 13:37:43', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 18, '0');
INSERT INTO `platform_product_info` VALUES (658, 'FYT', 'FYT', 0.0100, NULL, '0', '5', '0.02', '0.05', '0.0008', NULL, NULL, 'FYT', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 13:39:00', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 19, '0');
INSERT INTO `platform_product_info` VALUES (659, 'XLRE', 'XLRE', 0.0100, NULL, '0', '5', '0.02', '0.04', '0.0008', NULL, NULL, 'XLRE', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 13:40:28', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 20, '0');
INSERT INTO `platform_product_info` VALUES (660, 'CIBR', 'CIBR', 0.0100, NULL, '0', '5', '0.02', '0.03', '0.0008', NULL, NULL, 'CIBR', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 13:45:57', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 21, '0');
INSERT INTO `platform_product_info` VALUES (661, 'PSCT', 'PSCT', 0.0100, NULL, '0', '5', '0.02', '0.03', '0.0008', NULL, NULL, 'PSCT', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 13:47:27', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 22, '0');
INSERT INTO `platform_product_info` VALUES (662, 'C3.ai, Inc', 'C3.ai, Inc', 0.0100, NULL, '0', '3', '0.0002', '0.0003', '0.0008', NULL, NULL, 'AI', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 14:09:53', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 14, '0');
INSERT INTO `platform_product_info` VALUES (663, 'Braze, Inc.', 'Braze, Inc.', 0.0100, NULL, '0', '3', '0.02', '0.05', '0.0008', NULL, NULL, 'BRZE', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 14:12:03', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 15, '0');
INSERT INTO `platform_product_info` VALUES (664, 'Fluence Energy, Inc.', 'Fluence Energy, Inc.', 0.0100, NULL, '0', '3', '0.0002', '0.0003', '0.0008', NULL, NULL, 'FLNC', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 14:13:34', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 16, '0');
INSERT INTO `platform_product_info` VALUES (665, 'Snowflake Inc.', 'Snowflake Inc.', 0.0100, NULL, '0', '3', '0.0002', '0.0003', '0.0008', NULL, NULL, 'SNOW', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 14:15:28', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 17, '0');
INSERT INTO `platform_product_info` VALUES (666, 'BlackBerry Limited', 'BlackBerry Limited', 0.0100, NULL, '0', '3', '0.0002', '0.0003', '0.0008', NULL, NULL, 'BB', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 14:18:13', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 17, '0');
INSERT INTO `platform_product_info` VALUES (667, 'EVgo, Inc.', 'EVgo, Inc.', 0.0100, NULL, '0', '3', '0.02', '0.03', '0.0008', NULL, NULL, 'EVGO', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 14:20:10', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 19, '0');
INSERT INTO `platform_product_info` VALUES (668, 'Marqeta, Inc.', 'Marqeta, Inc.', 0.0100, NULL, '0', '3', '0', '0', '0.0008', NULL, NULL, 'MQ', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-01 14:21:49', 100.00, 5000000.00, NULL, NULL, 1.0000, '4', 20, '0');
INSERT INTO `platform_product_info` VALUES (669, 'CL', 'CL', 0.0200, NULL, '0', '4', '0.02', '0.03', '0.02', NULL, NULL, 'CL', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-04-14 21:44:51', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 1, '0');
INSERT INTO `platform_product_info` VALUES (670, 'OIL', 'OIL', 0.0200, NULL, '0', '4', '0.02', '0.03', '0.02', NULL, NULL, 'OIL', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-04-14 22:02:44', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 2, '0');
INSERT INTO `platform_product_info` VALUES (671, 'NG', 'NG', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'NG', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-04-14 22:04:22', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 3, '0');
INSERT INTO `platform_product_info` VALUES (672, 'HO', 'HO', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'HO', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '1', '1', '2023-04-14 22:05:27', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 4, '0');
INSERT INTO `platform_product_info` VALUES (673, 'GASO', 'GASO', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'GASO', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:06:38', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 5, '0');
INSERT INTO `platform_product_info` VALUES (674, 'GC', 'GC', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'GC', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:17:32', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 6, '0');
INSERT INTO `platform_product_info` VALUES (675, 'SI', 'SI', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'SI', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:18:47', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 7, '0');
INSERT INTO `platform_product_info` VALUES (676, 'HG', 'HG', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'HG', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:20:07', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 8, '0');
INSERT INTO `platform_product_info` VALUES (677, 'LHC', 'LHC', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'LHC', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:21:03', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 9, '0');
INSERT INTO `platform_product_info` VALUES (678, 'C', 'C', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'C', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:22:33', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 10, '0');
INSERT INTO `platform_product_info` VALUES (679, 'S', 'S', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'S', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:24:22', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 11, '0');
INSERT INTO `platform_product_info` VALUES (680, 'BO', 'BO', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'BO', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:25:26', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 12, '0');
INSERT INTO `platform_product_info` VALUES (681, 'SM', 'SM', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'SM', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:26:41', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 13, '0');
INSERT INTO `platform_product_info` VALUES (682, 'W', 'W', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'W', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:27:48', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 14, '0');
INSERT INTO `platform_product_info` VALUES (683, 'CT', 'CT', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'CT', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:29:28', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 15, '0');
INSERT INTO `platform_product_info` VALUES (684, 'RS', 'RS', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'RS', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:30:33', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 16, '0');
INSERT INTO `platform_product_info` VALUES (685, 'KC', 'KC', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'KC', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:31:28', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 17, '0');
INSERT INTO `platform_product_info` VALUES (686, 'XAU', 'XAU', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'XAU', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:37:03', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 18, '0');
INSERT INTO `platform_product_info` VALUES (687, 'XAG', 'XAG', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'XAG', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:38:17', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 19, '0');
INSERT INTO `platform_product_info` VALUES (688, 'CAD', 'CAD', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'CAD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:39:25', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 20, '0');
INSERT INTO `platform_product_info` VALUES (689, 'AHD', 'AHD', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'AHD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:41:10', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 21, '0');
INSERT INTO `platform_product_info` VALUES (690, 'ZSD', 'ZSD', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'ZSD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:42:01', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 22, '0');
INSERT INTO `platform_product_info` VALUES (691, 'NID', 'NID', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'NID', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:43:01', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 23, '0');
INSERT INTO `platform_product_info` VALUES (692, 'PBD', 'PBD', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'PBD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:43:56', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 24, '0');
INSERT INTO `platform_product_info` VALUES (693, 'SND', 'SND', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'SND', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:46:06', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 25, '0');
INSERT INTO `platform_product_info` VALUES (694, 'XPT', 'XPT', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'XPT', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:47:55', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 26, '0');
INSERT INTO `platform_product_info` VALUES (695, 'XPD', 'XPD', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'XPD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:48:54', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 27, '0');
INSERT INTO `platform_product_info` VALUES (696, 'FCPO', 'FCPO', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'FCPO', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:49:54', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 28, '0');
INSERT INTO `platform_product_info` VALUES (697, 'GAS', 'GAS', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'GAS', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:51:23', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 29, '0');
INSERT INTO `platform_product_info` VALUES (698, 'RSS3', 'RSS3', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'RSS3', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:52:27', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 30, '0');
INSERT INTO `platform_product_info` VALUES (699, 'FEF', 'FEF', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'FEF', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:53:39', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 31, '0');
INSERT INTO `platform_product_info` VALUES (700, 'GLS', 'GLS', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'GLS', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:54:31', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 32, '0');
INSERT INTO `platform_product_info` VALUES (701, 'LE', 'LE', 0.0200, NULL, '0', '4', '0.02', '0.04', '0.02', NULL, NULL, 'LE', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-14 22:56:22', 100.00, 5000000.00, NULL, NULL, 1.0000, '2', 33, '0');
INSERT INTO `platform_product_info` VALUES (702, 'AUD/USD', 'AUD/USD', 0.0200, NULL, '0', '1', '0.0002', '0.0004', '0.0002', NULL, NULL, 'AUD/USD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-15 20:43:45', 100.00, 5000000.00, NULL, '241f2db8c77bb7c52c19e3e36c5ece8e.png', 1.0000, '4', 9, '0');
INSERT INTO `platform_product_info` VALUES (703, 'CAD/USD', 'CAD/USD', 0.0200, NULL, '0', '1', '0.0002', '0.0004', '0.0002', NULL, NULL, 'CAD/USD', 500.00, 100000.00, 0.0000, '1,3,5,10,30', NULL, '0.98,0.95,0.85,0.75,0.62', '0', '1', '2023-04-15 20:45:46', 100.00, 5000000.00, NULL, '67c6e92841a587e1e6b4a5bc9d7dfdcc.png', 1.0000, '4', 10, '0');

-- ----------------------------
-- Table structure for platform_product_info_information
-- ----------------------------
DROP TABLE IF EXISTS `platform_product_info_information`;
CREATE TABLE `platform_product_info_information`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `pid` bigint NULL DEFAULT NULL COMMENT '产品ID',
  `brief_introduction` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品简介',
  `distribution_platform` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发行平台',
  `informations` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品信息',
  `printing_process` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '印刷工艺',
  `printer` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '印刷商',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注',
  `identification` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '语言标识',
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `language_id` bigint NULL DEFAULT NULL COMMENT '语言ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1625064833291350018 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品的多语言文本信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of platform_product_info_information
-- ----------------------------
INSERT INTO `platform_product_info_information` VALUES (1623556019886985218, 4, 'xxx', 'xxxx', 'xxx', 'xx', 'xxx', NULL, NULL, 'en_US', NULL, NULL, NULL, 1);
INSERT INTO `platform_product_info_information` VALUES (1623556019907956737, 4, 'SSSSSSSSSSSSSSSSSSSSSS', 'SSSSSSSSSSSSSS', 'SSSSSSSSSSSSSSSSSSSSS', 'SSSSSSSSSSSSSSS', 'SSSSS', NULL, NULL, 'jp_JP', NULL, NULL, NULL, 2);
INSERT INTO `platform_product_info_information` VALUES (1625064833291350017, 5, 'xxxxx', 'xxx', 'xxx', 'xxx', 'xxxxx', NULL, NULL, 'en_US', NULL, NULL, NULL, 1);

-- ----------------------------
-- Table structure for platform_user
-- ----------------------------
DROP TABLE IF EXISTS `platform_user`;
CREATE TABLE `platform_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `access_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '平台用户token',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '平台前端用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of platform_user
-- ----------------------------
INSERT INTO `platform_user` VALUES (1, 'meng', '55bc21a204be4a539dfc1aa7d0bc9e6f');
INSERT INTO `platform_user` VALUES (2, 'meng1', '0365080927db44b08da6e1a4b736f1eb');

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `blob_data` blob NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cron_expression` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time_zone_id` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `index_1`(`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME101', 'DEFAULT', '0 */1 * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME102', 'DEFAULT', '0 */5 * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME106', 'DEFAULT', '0 */15 * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME107', 'DEFAULT', '0 */30 * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME108', 'DEFAULT', '0 0 * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME109', 'DEFAULT', '0 0 * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME110', 'DEFAULT', '0 0 * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME11020', 'DEFAULT', '*/10 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME11035', 'DEFAULT', '0 */15 * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME113', 'DEFAULT', '0 0 * * * ?', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `entry_id` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fired_time` bigint NOT NULL,
  `sched_time` bigint NOT NULL,
  `priority` int NOT NULL,
  `state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `job_class_name` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_durable` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_update_data` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_data` blob NULL,
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE,
  INDEX `index_1`(`sched_name`) USING BTREE,
  INDEX `index_2`(`job_name`) USING BTREE,
  INDEX `index_3`(`job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME101', 'DEFAULT', NULL, 'com.ruoyi.common.utils.job.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720027636F6D2E72756F79692E70726F6A6563742E6D6F6E69746F722E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E72756F79692E6672616D65776F726B2E7765622E646F6D61696E2E42617365456E74697479000000000000000102000B4C0009626567696E54696D6571007E00094C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000D63726561746554696D6553747271007E00094C00096461746153636F706571007E00094C0007656E6454696D6571007E00094C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C7870707400007372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001735B7034B878707070707400007070707400013174000D30202A2F31202A202A202A203F74001B72795461736B2E75706461746550726F644B4C696E65282731272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000065740026E69BB4E696B0E68980E69C89E4BAA7E59381E79A8431E58886E9929F4BE7BABFE695B0E68DAE74000131740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME102', 'DEFAULT', NULL, 'com.ruoyi.common.utils.job.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720027636F6D2E72756F79692E70726F6A6563742E6D6F6E69746F722E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E72756F79692E6672616D65776F726B2E7765622E646F6D61696E2E42617365456E74697479000000000000000102000B4C0009626567696E54696D6571007E00094C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000D63726561746554696D6553747271007E00094C00096461746153636F706571007E00094C0007656E6454696D6571007E00094C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C7870707400007372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001735B7034B878707070707400007070707400013174000D30202A2F35202A202A202A203F74001B72795461736B2E75706461746550726F644B4C696E65282732272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000066740026E69BB4E696B0E68980E69C89E4BAA7E59381E79A8435E58886E9929F4BE7BABFE695B0E68DAE74000131740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME106', 'DEFAULT', NULL, 'com.ruoyi.common.utils.job.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720027636F6D2E72756F79692E70726F6A6563742E6D6F6E69746F722E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E72756F79692E6672616D65776F726B2E7765622E646F6D61696E2E42617365456E74697479000000000000000102000B4C0009626567696E54696D6571007E00094C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000D63726561746554696D6553747271007E00094C00096461746153636F706571007E00094C0007656E6454696D6571007E00094C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C7870707400007372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001735B7034B878707070707400007070707400013174000E30202A2F3135202A202A202A203F74001B72795461736B2E75706461746550726F644B4C696E65282733272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000006A740027E69BB4E696B0E68980E69C89E4BAA7E59381E79A843135E58886E9929F4BE7BABFE695B0E68DAE74000131740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME107', 'DEFAULT', NULL, 'com.ruoyi.common.utils.job.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720027636F6D2E72756F79692E70726F6A6563742E6D6F6E69746F722E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E72756F79692E6672616D65776F726B2E7765622E646F6D61696E2E42617365456E74697479000000000000000102000B4C0009626567696E54696D6571007E00094C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000D63726561746554696D6553747271007E00094C00096461746153636F706571007E00094C0007656E6454696D6571007E00094C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C7870707400007372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001735B7034B878707070707400007070707400013174000E30202A2F3330202A202A202A203F74001B72795461736B2E75706461746550726F644B4C696E65282734272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000006B740027E69BB4E696B0E68980E69C89E4BAA7E59381E79A843330E58886E9929F4BE7BABFE695B0E68DAE74000131740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME108', 'DEFAULT', NULL, 'com.ruoyi.common.utils.job.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720027636F6D2E72756F79692E70726F6A6563742E6D6F6E69746F722E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E72756F79692E6672616D65776F726B2E7765622E646F6D61696E2E42617365456E74697479000000000000000102000B4C0009626567696E54696D6571007E00094C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000D63726561746554696D6553747271007E00094C00096461746153636F706571007E00094C0007656E6454696D6571007E00094C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C7870707400007372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001735B7034B878707070707400007070707400013174000B302030202A202A202A203F74001B72795461736B2E75706461746550726F644B4C696E65282735272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000006C740025E69BB4E696B0E68980E69C89E4BAA7E59381E79A84E5B08FE697B64BE7BABFE695B0E68DAE74000131740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME109', 'DEFAULT', NULL, 'com.ruoyi.common.utils.job.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720027636F6D2E72756F79692E70726F6A6563742E6D6F6E69746F722E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E72756F79692E6672616D65776F726B2E7765622E646F6D61696E2E42617365456E74697479000000000000000102000B4C0009626567696E54696D6571007E00094C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000D63726561746554696D6553747271007E00094C00096461746153636F706571007E00094C0007656E6454696D6571007E00094C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C7870707400007372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001735B7034B878707070707400007070707400013174000B302030202A202A202A203F74001B72795461736B2E75706461746550726F644B4C696E65282736272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000006D740022E69BB4E696B0E68980E69C89E4BAA7E59381E79A84E697A54BE7BABFE695B0E68DAE74000131740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME110', 'DEFAULT', NULL, 'com.ruoyi.common.utils.job.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720027636F6D2E72756F79692E70726F6A6563742E6D6F6E69746F722E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E72756F79692E6672616D65776F726B2E7765622E646F6D61696E2E42617365456E74697479000000000000000102000B4C0009626567696E54696D6571007E00094C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000D63726561746554696D6553747271007E00094C00096461746153636F706571007E00094C0007656E6454696D6571007E00094C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C7870707400007372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001735B7034B878707070707400007070707400013174000B302030202A202A202A203F74001B72795461736B2E75706461746550726F644B4C696E65282737272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000006E740022E69BB4E696B0E68980E69C89E4BAA7E59381E79A84E591A84BE7BABFE695B0E68DAE74000131740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME11020', 'DEFAULT', NULL, 'com.ruoyi.common.utils.job.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720027636F6D2E72756F79692E70726F6A6563742E6D6F6E69746F722E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E72756F79692E6672616D65776F726B2E7765622E646F6D61696E2E42617365456E74697479000000000000000102000B4C0009626567696E54696D6571007E00094C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000D63726561746554696D6553747271007E00094C00096461746153636F706571007E00094C0007656E6454696D6571007E00094C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C7870707400007372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000184F6FEE21078707070707400007070707400013174000E2A2F3130202A202A202A202A203F74001F72795461736B2E636163686543757272656E63795261746548616E646C657274000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000002B0C740015E7BC93E5AD98E5B881E7A78DE79A84E6B187E78E8774000131740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME11035', 'DEFAULT', NULL, 'com.ruoyi.common.utils.job.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720027636F6D2E72756F79692E70726F6A6563742E6D6F6E69746F722E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E72756F79692E6672616D65776F726B2E7765622E646F6D61696E2E42617365456E74697479000000000000000102000B4C0009626567696E54696D6571007E00094C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000D63726561746554696D6553747271007E00094C00096461746153636F706571007E00094C0007656E6454696D6571007E00094C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C7870707400007372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000186BD3668A878707070707400007070707400013174000E30202A2F3135202A202A202A203F74001A72795461736B2E7570646174655265616C54696D65507269636574000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000002B1B740021E5AE9AE697B6E69BB4E696B0E4BAA7E59381E79A84E5AE9EE697B6E4BBB7E6A0BC74000131740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME113', 'DEFAULT', NULL, 'com.ruoyi.common.utils.job.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720027636F6D2E72756F79692E70726F6A6563742E6D6F6E69746F722E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E72756F79692E6672616D65776F726B2E7765622E646F6D61696E2E42617365456E74697479000000000000000102000B4C0009626567696E54696D6571007E00094C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000D63726561746554696D6553747271007E00094C00096461746153636F706571007E00094C0007656E6454696D6571007E00094C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C7870707400007372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001735B7034B878707070707400007070707400013174000B302030202A202A202A203F74001B72795461736B2E75706461746550726F644B4C696E65282738272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000071740022E69BB4E696B0E68980E69C89E4BAA7E59381E79A84E69C884BE7BABFE695B0E68DAE74000131740001317800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lock_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE,
  INDEX `index_2`(`lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('RuoyiScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('RuoyiScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_checkin_time` bigint NOT NULL,
  `checkin_interval` bigint NOT NULL,
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('RuoyiScheduler', 'DESKTOP-QVTSIES1682519800866', 1682520449191, 15000);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repeat_count` bigint NOT NULL,
  `repeat_interval` bigint NOT NULL,
  `times_triggered` bigint NOT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `str_prop_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `str_prop_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `str_prop_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `int_prop_1` int NULL DEFAULT NULL,
  `int_prop_2` int NULL DEFAULT NULL,
  `long_prop_1` bigint NULL DEFAULT NULL,
  `long_prop_2` bigint NULL DEFAULT NULL,
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL,
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL,
  `bool_prop_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bool_prop_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `next_fire_time` bigint NULL DEFAULT NULL,
  `prev_fire_time` bigint NULL DEFAULT NULL,
  `priority` int NULL DEFAULT NULL,
  `trigger_state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_type` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `start_time` bigint NOT NULL,
  `end_time` bigint NULL DEFAULT NULL,
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `misfire_instr` smallint NULL DEFAULT NULL,
  `job_data` blob NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  INDEX `index_1`(`trigger_name`, `trigger_group`) USING BTREE,
  INDEX `index_2`(`next_fire_time`) USING BTREE,
  INDEX `index_3`(`sched_name`, `next_fire_time`, `trigger_state`, `misfire_instr`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME101', 'DEFAULT', 'TASK_CLASS_NAME101', 'DEFAULT', NULL, 1682519820000, -1, 5, 'PAUSED', 'CRON', 1682519800000, 0, NULL, -1, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME102', 'DEFAULT', 'TASK_CLASS_NAME102', 'DEFAULT', NULL, 1682520000000, -1, 5, 'PAUSED', 'CRON', 1682519801000, 0, NULL, -1, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME106', 'DEFAULT', 'TASK_CLASS_NAME106', 'DEFAULT', NULL, 1682520300000, -1, 5, 'PAUSED', 'CRON', 1682519801000, 0, NULL, -1, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME107', 'DEFAULT', 'TASK_CLASS_NAME107', 'DEFAULT', NULL, 1682521200000, -1, 5, 'PAUSED', 'CRON', 1682519801000, 0, NULL, -1, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME108', 'DEFAULT', 'TASK_CLASS_NAME108', 'DEFAULT', NULL, 1682521200000, -1, 5, 'PAUSED', 'CRON', 1682519801000, 0, NULL, -1, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME109', 'DEFAULT', 'TASK_CLASS_NAME109', 'DEFAULT', NULL, 1682521200000, -1, 5, 'PAUSED', 'CRON', 1682519801000, 0, NULL, -1, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME110', 'DEFAULT', 'TASK_CLASS_NAME110', 'DEFAULT', NULL, 1682521200000, -1, 5, 'PAUSED', 'CRON', 1682519801000, 0, NULL, -1, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME11020', 'DEFAULT', 'TASK_CLASS_NAME11020', 'DEFAULT', NULL, 1682519810000, -1, 5, 'PAUSED', 'CRON', 1682519801000, 0, NULL, -1, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME11035', 'DEFAULT', 'TASK_CLASS_NAME11035', 'DEFAULT', NULL, 1682520300000, -1, 5, 'PAUSED', 'CRON', 1682519801000, 0, NULL, -1, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME113', 'DEFAULT', 'TASK_CLASS_NAME113', 'DEFAULT', NULL, 1682521200000, -1, 5, 'PAUSED', 'CRON', 1682519801000, 0, NULL, -1, '');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE,
  INDEX `index_1`(`config_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11164 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (101, '每日最多提现次数', 'cash_out_num', '10', 'Y', 'admin', '2020-05-01 13:26:02', 'admins', '2022-04-09 13:15:07', '提现笔数');
INSERT INTO `sys_config` VALUES (102, '单笔提现范围USDT', 'cash_out_money_scope', '100~500000', 'Y', 'admin', '2020-05-01 13:27:32', 'admins', '2023-03-30 08:35:49', '单笔提现范围2000~3000元');
INSERT INTO `sys_config` VALUES (105, '充值范围', 'recharge_scope', '1~500000', 'Y', 'admin', '2020-05-01 13:30:58', 'admin', '2020-06-05 20:17:20', '充值范围');
INSERT INTO `sys_config` VALUES (106, '充值金额是几的倍数', 'times', '0', 'Y', 'admin', '2020-05-01 13:36:47', 'admin', '2020-05-23 15:28:03', '充值金额是10的倍数');
INSERT INTO `sys_config` VALUES (117, '网站名称', 'site_name', 'Aggregatio', 'Y', 'admin', '2020-05-05 14:39:40', 'admins', '2023-03-29 16:11:37', '网站名称');
INSERT INTO `sys_config` VALUES (133, '发件箱账号', 'mail_account', 'gagakefu@gmail.com', 'Y', 'admin', '2020-06-24 22:10:16', 'limeng', '2023-03-29 15:20:57', '邮箱账号');
INSERT INTO `sys_config` VALUES (134, '发件箱密码', 'mail_password', 'chiebrxsgaqdkouu', 'Y', 'admin', '2020-06-24 22:10:40', 'limeng', '2023-03-29 15:21:07', '发件箱密码');
INSERT INTO `sys_config` VALUES (135, '发件箱地址', 'mail_address', 'smtp.gmail.com', 'Y', 'admin', '2020-06-24 22:11:15', 'limeng', '2023-03-29 15:21:21', '发件箱地址');
INSERT INTO `sys_config` VALUES (136, '邮件端口号', 'mail_port', '465', 'Y', 'admin', '2020-06-24 22:15:46', '', NULL, '邮件端口号');
INSERT INTO `sys_config` VALUES (152, '提现路上参数', 'cashout_is_goway', 'yes', 'Y', 'admin', '2020-10-29 18:47:08', 'admins', '2021-08-01 08:02:17', '提现路上参数');
INSERT INTO `sys_config` VALUES (306, '提现时间', 'cash_out_time', '08:00~24:00', 'Y', 'admin', '2020-10-20 20:19:47', 'admins', '2021-08-01 08:58:23', NULL);
INSERT INTO `sys_config` VALUES (316, '收款地址', 'address_to', '0x5AD7244a940F57eF19efd364218BFCF37F3a93ED', 'Y', 'admins', '2021-07-01 08:56:33', 'admins', '2022-05-05 23:29:10', NULL);
INSERT INTO `sys_config` VALUES (321, '邀请链接地址', 'ewm_url', 'http://34.72.33.175/web/#/', 'Y', 'admins', '2021-07-06 13:58:43', 'admins', '2021-07-07 12:59:52', NULL);
INSERT INTO `sys_config` VALUES (322, 'ip注册数限制', 'register_limit_num', '1000', 'Y', 'admins', '2021-07-07 12:59:26', 'admins', '2021-08-20 14:21:19', NULL);
INSERT INTO `sys_config` VALUES (328, '是否开启提现下发', 'is_online_cash_out', 'yes', 'Y', 'admins', '2021-07-08 19:37:21', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (329, '一级代理返佣', 'one_rate', '0.05', 'Y', 'admins', '2021-07-08 21:59:29', 'admins', '2021-07-11 11:09:49', NULL);
INSERT INTO `sys_config` VALUES (330, '二级代理返佣', 'two_rate', '0.03', 'Y', 'admins', '2021-07-08 21:59:50', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (331, '三级代理返佣', 'three_rate', '0.01', 'Y', 'admins', '2021-07-08 22:00:06', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (333, '提款汇率', 'cash_out_rate', '0.1', 'Y', 'admins', '2021-07-11 12:06:33', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (335, '客服token', 'kf_token', 'yckj60lw', 'Y', 'admins', '2021-07-20 14:46:26', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (338, '默认邀请码用户', 'default-userid', '72', 'Y', 'admins', '2021-08-19 00:40:15', 'admins', '2023-04-03 08:34:23', NULL);
INSERT INTO `sys_config` VALUES (8889, '试玩用户提现是否自动通过', 'test_user_cash', 'yes', 'Y', 'admins', '2021-10-05 16:03:18', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (8892, '时间加减值', 'time_num', '0', 'Y', 'admins', '2021-10-14 07:03:34', 'admins', '2022-12-07 13:45:24', NULL);
INSERT INTO `sys_config` VALUES (8894, 'TG-Botkey', 'tele_key', '2082701808:AAH8mRV_R95XfXRZ6y43LUiR1tmln6vpG_I', 'Y', 'admins', '2021-10-14 12:37:24', 'admins', '2021-10-17 15:17:15', NULL);
INSERT INTO `sys_config` VALUES (8895, 'TG-ChatID', 'chat_id', '-647339691', 'Y', 'admins', '2021-10-14 12:41:09', 'admins', '2021-10-17 15:17:03', NULL);
INSERT INTO `sys_config` VALUES (8897, '开启提现间隔X天', 'cash_once_day', '0', 'Y', 'admins', '2021-10-20 14:36:35', 'admins', '2022-04-09 13:41:02', NULL);
INSERT INTO `sys_config` VALUES (8902, '图片地址前缀', 'base_img_url', 'http://172.104.191.77/file/', 'Y', 'admins', '2022-01-03 14:24:55', 'admins', '2023-03-15 09:41:05', NULL);
INSERT INTO `sys_config` VALUES (11002, 'tele_id', 'chat_id', '-647339691', 'Y', 'admins', '2021-10-14 12:41:09', 'admins', '2021-10-14 13:07:15', NULL);
INSERT INTO `sys_config` VALUES (11124, 'tron的收款地址', 'address_to_tron', 'TC1WuPjd4aDzztEmmYPGbhGCyPbPZdCtTNxx', 'Y', 'admins', NULL, 'admins', '2022-05-05 23:27:26', NULL);
INSERT INTO `sys_config` VALUES (11127, 'trx兑换usdt汇率', 'trx_rate', '0.079091', 'Y', 'admins', '2021-10-14 07:03:34', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (11132, '英语文本的ID', 'english_id', '1', 'Y', 'admins', '2022-12-10 22:39:57', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (11135, '线上充值key', 'recharge_key', 'ec4f78f88181921350625c75efb318b44155e3d0', 'Y', 'admins', '2022-12-21 08:09:01', 'admins', '2022-12-21 12:13:22', NULL);
INSERT INTO `sys_config` VALUES (11136, '线上充值提现app_id', 'app_id', 'ItCSJHeb', 'Y', 'admins', '2022-12-21 08:09:32', 'admins', '2022-12-21 12:13:08', NULL);
INSERT INTO `sys_config` VALUES (11137, '线上充值提现调用地址前缀', 'online_url', 'http://api.canoscoin.com/apis', 'Y', 'admins', '2022-12-21 08:10:08', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (11138, '提前赎回理财扣除比例', 'early_redeem_order_rate', '0.1', 'Y', 'limeng', '2023-03-20 06:28:26', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (11139, '借贷最高可借', 'max_loan_money', '2000000', 'Y', 'limeng', '2023-03-21 06:07:52', 'admins', '2023-04-19 08:18:04', NULL);
INSERT INTO `sys_config` VALUES (11140, '借款X天还款不计息', 'no_rate_days', '3', 'Y', 'limeng', '2023-03-21 06:52:39', 'admins', '2023-03-22 13:48:17', NULL);
INSERT INTO `sys_config` VALUES (11141, '提现手续费比例', 'cash_fee', '0.05', 'Y', 'limeng', '2023-03-23 13:29:21', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (11142, '放款人', 'lender', 'xxxx', 'Y', 'limeng', '2023-03-23 16:05:31', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (11143, '合约涨跌点回落时间(min)', 'fall_rise_time', '3', 'Y', 'admins', '2023-03-25 05:20:58', 'admins', '2023-03-25 05:21:08', NULL);
INSERT INTO `sys_config` VALUES (11144, '统一的用户合约平仓额度', 'close_position_quota', '100000', 'Y', 'admins', '2023-03-25 05:38:56', 'admins', '2023-04-20 17:10:24', NULL);
INSERT INTO `sys_config` VALUES (11145, '是否开启抵御风险', 'is_risk', 'yes', 'Y', 'admins', '2023-03-25 05:40:20', 'admins', '2023-03-30 17:50:02', NULL);
INSERT INTO `sys_config` VALUES (11146, '平台名称', 'platform_name', 'Aggregation', 'Y', 'admins', '2023-03-26 13:48:34', 'admins', '2023-03-29 12:57:18', NULL);
INSERT INTO `sys_config` VALUES (11147, '重置密码链接', 'rest_back_url', 'http://172.104.191.77/aggregation/#/changepwd', 'Y', 'admins', '2023-03-27 15:02:07', 'admins', '2023-03-27 15:04:16', NULL);
INSERT INTO `sys_config` VALUES (11148, '邮件展示的平台名称', 'email_site_name', 'Aggregatio', 'Y', 'limeng', '2023-03-29 12:45:12', 'admins', '2023-03-29 16:11:14', NULL);
INSERT INTO `sys_config` VALUES (11149, '期货请求前缀', 'future_request_url', 'https://cjapi.stweets.cc/waipan', 'Y', 'admins', '2023-04-17 08:49:24', 'admins', '2023-04-17 13:03:57', NULL);
INSERT INTO `sys_config` VALUES (11150, '期货token', 'future_token', 'xxxxxxx', 'Y', 'admins', '2023-04-17 08:49:56', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (11151, '是否开启在线充值', 'is_open_online_recharge', 'no', 'Y', 'admins', '2023-04-20 07:05:01', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (11161, '三方ip白名单', 'white_ip', ',34.96.164.71,', 'Y', 'admin', '2020-08-21 10:29:15', '', NULL, '三方ip白名单');
INSERT INTO `sys_config` VALUES (11162, '英语标识', 'english_Identification', 'en_US', 'Y', 'admins', '2022-12-21 08:18:11', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (11163, '线上提现key', 'cash_out_key', 'bea0bce17b1988f61f62271d0133435ac3a7ff62', 'Y', 'admin', '2020-06-23 15:23:11', 'admin', '2020-08-01 14:55:31', '线上提现key');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '管理部门', 0, '管理员', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 94 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '系统任务', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'admin', '2021-03-04 17:24:21', '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '限时产品', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2018-03-16 11:33:00', 'admin', '2021-04-22 15:43:23', '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '首页公告', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'admin', '2020-05-05 17:03:41', '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '普通公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2018-03-16 11:33:00', 'admin', '2020-05-05 17:03:49', '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '新增操作');
INSERT INTO `sys_dict_data` VALUES (19, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '修改操作');
INSERT INTO `sys_dict_data` VALUES (20, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '删除操作');
INSERT INTO `sys_dict_data` VALUES (21, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '授权操作');
INSERT INTO `sys_dict_data` VALUES (22, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '导出操作');
INSERT INTO `sys_dict_data` VALUES (23, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '导入操作');
INSERT INTO `sys_dict_data` VALUES (24, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '强退操作');
INSERT INTO `sys_dict_data` VALUES (25, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '生成操作');
INSERT INTO `sys_dict_data` VALUES (26, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '清空操作');
INSERT INTO `sys_dict_data` VALUES (27, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '正常状态');
INSERT INTO `sys_dict_data` VALUES (28, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '停用状态');
INSERT INTO `sys_dict_data` VALUES (29, 0, '中国', '+86', 'country', NULL, NULL, 'N', '0', 'admin', '2020-06-01 14:04:17', 'admin', '2020-06-01 14:08:47', '字典键值为对应的区号');
INSERT INTO `sys_dict_data` VALUES (30, 1, '美国', '+89', 'country', NULL, NULL, 'N', '0', 'admin', '2020-06-01 14:04:27', 'admin', '2020-06-01 14:08:59', '字典键值为对应的区号');
INSERT INTO `sys_dict_data` VALUES (31, 2, '俄罗斯', '+124', 'country', NULL, NULL, 'N', '0', 'admin', '2020-06-01 14:04:42', 'admin', '2020-06-01 14:09:01', '字典键值为对应的区号');
INSERT INTO `sys_dict_data` VALUES (32, 3, '印度', '+7290', 'country', NULL, NULL, 'N', '0', 'admin', '2020-06-01 14:04:55', 'admin', '2020-06-01 14:09:04', '字典键值为对应的区号');
INSERT INTO `sys_dict_data` VALUES (33, 4, '英国', '+791', 'country', NULL, NULL, 'N', '0', 'admin', '2020-06-01 14:05:07', 'admin', '2020-06-01 14:09:08', '字典键值为对应的区号');
INSERT INTO `sys_dict_data` VALUES (34, 5, '土耳其', '+8112', 'country', NULL, NULL, 'N', '0', 'admin', '2020-06-01 14:06:03', 'admin', '2020-06-01 14:09:11', '字典键值为对应的区号');
INSERT INTO `sys_dict_data` VALUES (35, 0, '韩国', '+130', 'country', NULL, NULL, 'N', '0', 'admin', '2020-06-01 14:10:29', '', NULL, '韩国');
INSERT INTO `sys_dict_data` VALUES (36, 0, '法国', '+170', 'country', NULL, NULL, 'N', '0', 'admin', '2020-06-01 14:10:46', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (37, 0, '日本', '+150', 'country', NULL, NULL, 'N', '0', 'admin', '2020-06-01 14:11:02', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (38, 0, '以色列', '+400', 'country', NULL, NULL, 'N', '0', 'admin', '2020-06-01 14:11:16', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (39, 0, '巴西', '+431', 'country', NULL, NULL, 'N', '0', 'admin', '2020-06-01 14:11:35', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (40, 0, '二代身份证', '0', 'documenttype', NULL, NULL, 'N', '0', 'admin', '2020-06-01 14:14:40', '', NULL, '二代身份证');
INSERT INTO `sys_dict_data` VALUES (41, 0, '机动车驾驶证', '1', 'documenttype', NULL, NULL, 'N', '0', 'admin', '2020-06-01 14:15:01', '', NULL, '机动车驾驶证');
INSERT INTO `sys_dict_data` VALUES (42, 0, '美国绿卡', '2', 'documenttype', NULL, NULL, 'N', '0', 'admin', '2020-06-01 14:15:20', '', NULL, '美国绿卡');
INSERT INTO `sys_dict_data` VALUES (43, 0, 'USD', 'USD', 'currency_type', NULL, NULL, 'N', '0', 'admin', '2020-06-10 15:50:54', '', NULL, 'USD');
INSERT INTO `sys_dict_data` VALUES (44, 0, 'CNY', 'CNY', 'currency_type', NULL, NULL, 'N', '0', 'admin', '2020-06-10 15:51:09', '', NULL, 'CNY');
INSERT INTO `sys_dict_data` VALUES (45, 0, 'BTC', 'BTC', 'currency_type', NULL, NULL, 'N', '0', 'admin', '2020-06-10 15:51:43', '', NULL, 'BTC');
INSERT INTO `sys_dict_data` VALUES (46, 3, '币币产品', 'BBZD', 'sys_job_group', NULL, NULL, 'N', '0', 'admin', '2021-03-04 17:28:31', 'admin', '2021-04-22 15:40:46', NULL);
INSERT INTO `sys_dict_data` VALUES (47, 4, '搬砖产品', 'BZCP', 'sys_job_group', NULL, NULL, 'N', '0', 'admin', '2021-04-22 15:43:53', 'admin', '2021-04-22 15:43:58', NULL);
INSERT INTO `sys_dict_data` VALUES (48, 5, '矿机产品', 'KJCP', 'sys_job_group', NULL, NULL, 'N', '0', 'admin', '2021-04-22 15:44:17', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (49, 1, '充值文本', '1', 'text_type', NULL, NULL, 'N', '0', 'admins', '2022-12-10 22:34:45', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (50, 2, '提现文本', '2', 'text_type', NULL, NULL, 'N', '0', 'admins', '2022-12-11 09:25:30', 'admins', '2022-12-11 09:25:36', NULL);
INSERT INTO `sys_dict_data` VALUES (51, 0, '预售产品', '1', 'product_type', NULL, NULL, 'N', '0', 'admins', '2023-02-05 14:55:07', '', NULL, '预售产品');
INSERT INTO `sys_dict_data` VALUES (52, 1, '市场产品', '2', 'product_type', NULL, NULL, 'N', '0', 'admins', '2023-02-05 14:55:19', '', NULL, '市场产品');
INSERT INTO `sys_dict_data` VALUES (53, 1, '是', '1', 'is_hot', NULL, NULL, 'N', '0', 'admins', '2023-02-08 22:28:18', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (54, 2, '否', '2', 'is_hot', NULL, NULL, 'N', '0', 'admins', '2023-02-08 22:28:24', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (55, 1, '充值', '1', 'account_record_type', NULL, NULL, 'N', '0', 'admins', '2023-02-15 10:45:27', 'admins', '2023-02-15 10:45:55', NULL);
INSERT INTO `sys_dict_data` VALUES (56, 2, '提现', '2', 'account_record_type', NULL, NULL, 'N', '0', 'admins', '2023-02-15 10:45:37', 'admins', '2023-02-15 10:45:59', NULL);
INSERT INTO `sys_dict_data` VALUES (57, 3, '提现退回', '3', 'account_record_type', NULL, NULL, 'N', '0', 'admins', '2023-02-15 10:45:50', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (58, 4, '系统充值', '4', 'account_record_type', NULL, NULL, 'N', '0', 'admins', '2023-02-15 10:46:08', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (59, 5, '系统扣费', '5', 'account_record_type', NULL, NULL, 'N', '0', 'admins', '2023-02-15 10:46:18', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (60, 6, '购买期权', '6', 'account_record_type', NULL, NULL, 'N', '0', 'admins', '2023-02-15 10:46:47', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (61, 7, '期权结算', '7', 'account_record_type', NULL, NULL, 'N', '0', 'admins', '2023-02-15 10:47:01', 'admins', '2023-02-15 10:47:11', NULL);
INSERT INTO `sys_dict_data` VALUES (62, 8, '合约下单', '8', 'account_record_type', NULL, NULL, 'N', '0', 'admins', '2023-02-15 10:47:23', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (63, 1, '市价订单', '1', 'order_trade_type', NULL, NULL, 'N', '0', 'admins', '2023-02-15 10:48:37', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (64, 2, '限价订单', '2', 'order_trade_type', NULL, NULL, 'N', '0', 'admins', '2023-02-15 10:48:50', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (65, 1, '买进', '1', 'direction_type', NULL, NULL, 'N', '0', 'admins', '2023-02-15 10:49:35', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (66, 2, '卖出', '2', 'direction_type', NULL, NULL, 'N', '0', 'admins', '2023-02-15 10:49:46', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (67, 1, '挂单中', '1', 'order_status', NULL, NULL, 'N', '0', 'admins', '2023-02-15 10:50:32', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (68, 2, '部分成交', '2', 'order_status', NULL, NULL, 'N', '0', 'admins', '2023-02-15 10:50:43', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (69, 3, '完全成交', '3', 'order_status', NULL, NULL, 'N', '0', 'admins', '2023-02-15 10:50:56', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (70, 4, '已撤单', '4', 'order_status', NULL, NULL, 'N', '0', 'admins', '2023-02-15 10:51:05', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (71, 1, '帮助中心', 'faq', 'article_type', NULL, NULL, 'N', '0', 'admins', '2023-03-15 03:49:41', 'admins', '2023-04-17 02:16:36', NULL);
INSERT INTO `sys_dict_data` VALUES (72, 0, 'Licenses', 'licenses', 'article_type', NULL, NULL, 'N', '0', 'admins', '2023-03-15 11:00:07', 'admins', '2023-03-15 11:00:37', NULL);
INSERT INTO `sys_dict_data` VALUES (73, 0, 'Terms and Conditions', 'terms', 'article_type', NULL, NULL, 'N', '0', 'admins', '2023-03-15 11:01:06', 'admins', '2023-03-15 11:01:33', NULL);
INSERT INTO `sys_dict_data` VALUES (74, 0, 'Privacy policy', 'privacy', 'article_type', NULL, NULL, 'N', '0', 'admins', '2023-03-15 11:02:03', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (75, 0, 'Cookies Policy', 'cookies', 'article_type', NULL, NULL, 'N', '0', 'admins', '2023-03-15 11:02:25', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (76, 9, '合约结算', '9', 'account_record_type', NULL, NULL, 'N', '0', 'limeng', '2023-03-16 02:24:58', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (77, 10, '理财下单', '10', 'account_record_type', NULL, NULL, 'N', '0', 'limeng', '2023-03-16 02:25:21', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (78, 11, '理财结算', '11', 'account_record_type', NULL, NULL, 'N', '0', 'limeng', '2023-03-16 02:48:45', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (79, 12, '提前赎回理财', '12', 'account_record_type', NULL, NULL, 'N', '0', 'admins', '2023-03-17 17:13:14', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (80, 13, '购买NFT', '13', 'account_record_type', NULL, NULL, 'N', '0', 'admins', '2023-03-17 17:13:32', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (81, 14, '借贷成功', '14', 'account_record_type', NULL, NULL, 'N', '0', 'admins', '2023-03-17 17:13:49', 'admins', '2023-03-22 14:56:35', NULL);
INSERT INTO `sys_dict_data` VALUES (82, 3, '贷款协议', '3', 'text_type', NULL, NULL, 'N', '0', 'admins', '2023-03-22 05:58:43', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (83, 15, '借贷还款', '15', 'account_record_type', NULL, NULL, 'N', '0', 'admins', '2023-03-23 01:52:37', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (84, 6, 'About aggregation', 'aggregation', 'article_type', NULL, NULL, 'N', '0', 'admins', '2023-03-25 09:10:03', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (85, 0, 'Notice', 'notice', 'article_type', NULL, NULL, 'N', '0', 'admins', '2023-03-26 13:10:12', 'admins', '2023-03-26 13:11:43', NULL);
INSERT INTO `sys_dict_data` VALUES (86, 0, 'Disclaimer', 'disclaimer', 'article_type', NULL, NULL, 'N', '0', 'admins', '2023-03-27 09:49:42', 'admins', '2023-03-27 09:53:24', NULL);
INSERT INTO `sys_dict_data` VALUES (87, 0, 'Legal Information', 'legal', 'article_type', NULL, NULL, 'N', '0', 'limeng', '2023-03-27 11:36:32', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (88, 0, 'Risk Warning', 'risk', 'article_type', NULL, NULL, 'N', '0', 'limeng', '2023-03-27 11:36:53', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (89, 0, 'About Advertising', 'about', 'article_type', NULL, NULL, 'N', '0', 'limeng', '2023-03-27 11:37:08', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (90, 0, 'Smart trading', 'smart', 'article_type', NULL, NULL, 'N', '0', 'limeng', '2023-03-28 02:44:42', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (91, 0, '贷款文本', '4', 'text_type', NULL, NULL, 'N', '0', 'limeng', '2023-03-28 13:27:54', 'limeng', '2023-03-28 13:34:51', '贷款页面，贷款按钮上面的文本，包含贷款天数，使用通配符 $days 代替');
INSERT INTO `sys_dict_data` VALUES (92, 5, '邀请文本', '5', 'text_type', NULL, NULL, 'N', '0', 'admins', '2023-04-01 02:46:19', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (93, 16, '赠送', '16', 'account_record_type', NULL, NULL, 'N', '0', 'limeng', '2023-04-02 15:17:06', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (13, '法币类型', 'currency_type', '0', 'admin', '2020-06-10 15:49:37', '', NULL, '法币类型');
INSERT INTO `sys_dict_type` VALUES (14, '文本类型', 'text_type', '0', 'admins', '2022-12-10 22:34:28', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (15, '产品类型', 'product_type', '0', 'admins', '2023-02-05 14:54:46', '', NULL, '产品类型');
INSERT INTO `sys_dict_type` VALUES (16, '是否热门', 'is_hot', '0', 'admins', '2023-02-08 22:28:04', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (17, '资金变动类型', 'account_record_type', '0', 'admins', '2023-02-15 10:45:08', '', NULL, '资金变动类型');
INSERT INTO `sys_dict_type` VALUES (18, '订单交易类型', 'order_trade_type', '0', 'admins', '2023-02-15 10:48:12', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (19, '订单交易方向', 'direction_type', '0', 'admins', '2023-02-15 10:49:23', '', NULL, '订单交易方向');
INSERT INTO `sys_dict_type` VALUES (20, '订单状态', 'order_status', '0', 'admins', '2023-02-15 10:50:17', '', NULL, '订单状态');
INSERT INTO `sys_dict_type` VALUES (21, '文章分类', 'article_type', '0', 'admins', '2023-03-15 03:48:46', '', NULL, '1');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE,
  INDEX `index_1`(`job_group`) USING BTREE,
  INDEX `index_2`(`status`) USING BTREE,
  INDEX `index_3`(`job_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11246 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (101, '更新所有产品的1分钟K线数据', 'DEFAULT', 'ryTask.updateProdKLine(\'1\')', '0 */1 * * * ?', '1', '1', '1', '', '2020-07-17 14:22:27', '', '2023-04-24 22:23:38', '');
INSERT INTO `sys_job` VALUES (102, '更新所有产品的5分钟K线数据', 'DEFAULT', 'ryTask.updateProdKLine(\'2\')', '0 */5 * * * ?', '1', '1', '1', '', '2020-07-17 14:22:27', '', '2023-04-24 22:23:37', '');
INSERT INTO `sys_job` VALUES (106, '更新所有产品的15分钟K线数据', 'DEFAULT', 'ryTask.updateProdKLine(\'3\')', '0 */15 * * * ?', '1', '1', '1', '', '2020-07-17 14:22:27', '', '2023-04-24 22:23:35', '');
INSERT INTO `sys_job` VALUES (107, '更新所有产品的30分钟K线数据', 'DEFAULT', 'ryTask.updateProdKLine(\'4\')', '0 */30 * * * ?', '1', '1', '1', '', '2020-07-17 14:22:27', '', '2023-04-24 22:23:33', '');
INSERT INTO `sys_job` VALUES (108, '更新所有产品的小时K线数据', 'DEFAULT', 'ryTask.updateProdKLine(\'5\')', '0 0 * * * ?', '1', '1', '1', '', '2020-07-17 14:22:27', '', '2023-04-24 22:23:32', '');
INSERT INTO `sys_job` VALUES (109, '更新所有产品的日K线数据', 'DEFAULT', 'ryTask.updateProdKLine(\'6\')', '0 0 * * * ?', '1', '1', '1', '', '2020-07-17 14:22:27', '', '2023-04-24 22:23:30', '');
INSERT INTO `sys_job` VALUES (110, '更新所有产品的周K线数据', 'DEFAULT', 'ryTask.updateProdKLine(\'7\')', '0 0 * * * ?', '1', '1', '1', '', '2020-07-17 14:22:27', '', '2023-04-24 22:23:29', '');
INSERT INTO `sys_job` VALUES (113, '更新所有产品的月K线数据', 'DEFAULT', 'ryTask.updateProdKLine(\'8\')', '0 0 * * * ?', '1', '1', '1', '', '2020-07-17 14:22:27', '', '2023-04-24 22:23:28', '');
INSERT INTO `sys_job` VALUES (11020, '缓存币种的汇率', 'DEFAULT', 'ryTask.cacheCurrencyRateHandler', '*/10 * * * * ?', '1', '1', '1', '', '2022-12-09 21:06:50', '', '2023-03-08 06:20:34', '');
INSERT INTO `sys_job` VALUES (11035, '定时更新产品的实时价格', 'DEFAULT', 'ryTask.updateRealTimePrice', '0 */15 * * * ?', '1', '1', '1', '', '2023-03-08 01:55:05', '', '2023-04-24 22:23:40', '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4606 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `menu_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `perms` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2156 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 7, 'system', NULL, 1, 'M', '0', '', 'system', 'admin', '2018-03-16 11:33:00', 'admin', '2020-05-31 11:01:25', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 8, 'monitor', NULL, 1, 'M', '0', '', 'monitor', 'admin', '2018-03-16 11:33:00', 'admins', '2021-07-05 12:44:10', '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 9, 'tool', NULL, 1, 'M', '0', '', 'tool', 'admin', '2018-03-16 11:33:00', 'admin', '2020-05-31 11:01:34', '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', 1, 'C', '0', 'system:user:list', 'user', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', 1, 'C', '0', 'system:role:list', 'peoples', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', 1, 'C', '0', 'system:menu:list', 'tree-table', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', 1, 'C', '0', 'system:dict:list', 'dict', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '基础参数设置', 1, 7, 'config', 'system/config/index', 1, 'C', '0', 'system:config:list', 'edit', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '参数设置菜单');
INSERT INTO `sys_menu` VALUES (108, '系统日志', 1, 9, 'log', 'system/log/index', 1, 'M', '0', '', 'log', 'admin', '2018-03-16 11:33:00', 'admins', '2021-10-17 13:47:55', '日志管理菜单');
INSERT INTO `sys_menu` VALUES (110, '任务调度', 2, 2, 'job', 'monitor/job/index', 0, 'C', '0', 'monitor:job:list', 'job', 'admin', '2018-03-16 11:33:00', 'admins', '2021-07-05 12:44:22', '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', 1, 'C', '0', 'monitor:druid:list', 'druid', 'admin', '2018-03-16 11:33:00', 'admins', '2023-03-28 14:30:13', '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', 1, 'C', '0', 'monitor:server:list', 'server', 'admin', '2018-03-16 11:33:00', 'admins', '2023-03-28 14:30:18', '服务监控菜单');
INSERT INTO `sys_menu` VALUES (114, '代码生成', 3, 2, 'gen', 'tool/gen/index', 1, 'C', '0', 'tool:gen:list', 'code', 'admin', '2018-03-16 11:33:00', 'admins', '2022-10-06 14:19:54', '代码生成菜单');
INSERT INTO `sys_menu` VALUES (115, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', 1, 'C', '0', 'tool:swagger:list', 'swagger', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', 1, 'C', '0', 'monitor:operlog:list', 'form', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', 1, 'C', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1001, '用户查询', 100, 1, '', '', 1, 'F', '0', 'system:user:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1002, '用户新增', 100, 2, '', '', 1, 'F', '0', 'system:user:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1003, '用户修改', 100, 3, '', '', 1, 'F', '0', 'system:user:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1004, '用户删除', 100, 4, '', '', 1, 'F', '0', 'system:user:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1005, '用户导出', 100, 5, '', '', 1, 'F', '0', 'system:user:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1006, '用户导入', 100, 6, '', '', 1, 'F', '0', 'system:user:import', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1007, '重置密码', 100, 7, '', '', 1, 'F', '0', 'system:user:resetPwd', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1008, '角色查询', 101, 1, '', '', 1, 'F', '0', 'system:role:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1009, '角色新增', 101, 2, '', '', 1, 'F', '0', 'system:role:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1010, '角色修改', 101, 3, '', '', 1, 'F', '0', 'system:role:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1011, '角色删除', 101, 4, '', '', 1, 'F', '0', 'system:role:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1012, '角色导出', 101, 5, '', '', 1, 'F', '0', 'system:role:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1013, '菜单查询', 102, 1, '', '', 1, 'F', '0', 'system:menu:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1014, '菜单新增', 102, 2, '', '', 1, 'F', '0', 'system:menu:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1015, '菜单修改', 102, 3, '', '', 1, 'F', '0', 'system:menu:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1016, '菜单删除', 102, 4, '', '', 1, 'F', '0', 'system:menu:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1017, '部门查询', 103, 1, '', '', 1, 'F', '0', 'system:dept:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1018, '部门新增', 103, 2, '', '', 1, 'F', '0', 'system:dept:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1019, '部门修改', 103, 3, '', '', 1, 'F', '0', 'system:dept:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1020, '部门删除', 103, 4, '', '', 1, 'F', '0', 'system:dept:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1021, '岗位查询', 104, 1, '', '', 1, 'F', '0', 'system:post:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1022, '岗位新增', 104, 2, '', '', 1, 'F', '0', 'system:post:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1023, '岗位修改', 104, 3, '', '', 1, 'F', '0', 'system:post:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1024, '岗位删除', 104, 4, '', '', 1, 'F', '0', 'system:post:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1025, '岗位导出', 104, 5, '', '', 1, 'F', '0', 'system:post:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1026, '字典查询', 105, 1, '#', '', 1, 'F', '0', 'system:dict:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1027, '字典新增', 105, 2, '#', '', 1, 'F', '0', 'system:dict:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1028, '字典修改', 105, 3, '#', '', 1, 'F', '0', 'system:dict:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1029, '字典删除', 105, 4, '#', '', 1, 'F', '0', 'system:dict:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1030, '字典导出', 105, 5, '#', '', 1, 'F', '0', 'system:dict:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1031, '参数查询', 106, 1, '#', '', 1, 'F', '0', 'system:config:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1032, '参数新增', 106, 2, '#', '', 1, 'F', '0', 'system:config:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1033, '参数修改', 106, 3, '#', '', 1, 'F', '0', 'system:config:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1034, '参数删除', 106, 4, '#', '', 1, 'F', '0', 'system:config:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1035, '参数导出', 106, 5, '#', '', 1, 'F', '0', 'system:config:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1040, '操作查询', 500, 1, '#', '', 1, 'F', '0', 'monitor:operlog:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1041, '操作删除', 500, 2, '#', '', 1, 'F', '0', 'monitor:operlog:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1042, '日志导出', 500, 4, '#', '', 1, 'F', '0', 'monitor:operlog:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1043, '登录查询', 501, 1, '#', '', 1, 'F', '0', 'monitor:logininfor:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1044, '登录删除', 501, 2, '#', '', 1, 'F', '0', 'monitor:logininfor:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1045, '日志导出', 501, 3, '#', '', 1, 'F', '0', 'monitor:logininfor:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', 1, 'F', '0', 'monitor:online:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', 1, 'F', '0', 'monitor:online:batchLogout', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', 1, 'F', '0', 'monitor:online:forceLogout', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', 1, 'F', '0', 'monitor:job:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', 1, 'F', '0', 'monitor:job:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', 1, 'F', '0', 'monitor:job:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', 1, 'F', '0', 'monitor:job:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', 1, 'F', '0', 'monitor:job:changeStatus', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 7, '#', '', 1, 'F', '0', 'monitor:job:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 114, 1, '#', '', 1, 'F', '0', 'tool:gen:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 114, 2, '#', '', 1, 'F', '0', 'tool:gen:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 114, 3, '#', '', 1, 'F', '0', 'tool:gen:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 114, 2, '#', '', 1, 'F', '0', 'tool:gen:import', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 114, 4, '#', '', 1, 'F', '0', 'tool:gen:preview', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 114, 5, '#', '', 1, 'F', '0', 'tool:gen:code', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1077, '生成查询', 114, 1, '#', '', 1, 'F', '0', 'tool:gen:query', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1078, '生成修改', 114, 2, '#', '', 1, 'F', '0', 'tool:gen:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1079, '生成删除', 114, 3, '#', '', 1, 'F', '0', 'tool:gen:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1080, '导入代码', 114, 2, '#', '', 1, 'F', '0', 'tool:gen:import', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1081, '预览代码', 114, 4, '#', '', 1, 'F', '0', 'tool:gen:preview', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1082, '生成代码', 114, 5, '#', '', 1, 'F', '0', 'tool:gen:code', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (2005, '在线情况', 2000, 6, 'online', 'monitor/online/index', 1, 'C', '0', 'monitor:online:list', 'online', 'admin', '2020-04-29 18:00:27', 'admin', '2020-05-28 11:19:43', '');
INSERT INTO `sys_menu` VALUES (2006, '登入日志', 2000, 7, 'logininforlog', 'monitor/logininfor/index', 1, 'C', '0', 'monitor:logininfor:list', 'edit', 'admin', '2020-04-29 18:01:23', 'admin', '2020-06-25 10:10:25', '');
INSERT INTO `sys_menu` VALUES (2029, '表单构建', 3, 1, 'build', 'tool/build/index', 1, 'C', '0', 'tool:build:list', 'build', 'admin', '2020-05-28 10:51:38', 'admins', '2023-02-05 22:35:10', '');
INSERT INTO `sys_menu` VALUES (2054, '用户中心', 0, 1, 'yy', NULL, 1, 'M', '0', '', 'peoples', 'admins', '2021-06-27 17:41:37', 'admins', '2022-12-10 15:14:40', '');
INSERT INTO `sys_menu` VALUES (2055, '用户管理', 2054, 1, 'wuser', 'system/platformuser/index', 1, 'C', '0', '', 'peoples', 'admins', '2021-06-27 17:42:05', 'admins', '2022-12-08 16:03:14', '');
INSERT INTO `sys_menu` VALUES (2065, '归集代币', 2056, 1, '#', NULL, 1, 'F', '0', 'system:address:notionalPooling', '#', 'admins', '2021-08-12 14:27:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2066, '更新余额', 2056, 2, '', NULL, 1, 'F', '0', NULL, '#', 'admins', '2021-08-12 14:40:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2080, '系统参数设置', 1, 14, 'syscode', 'system/syscode/index', 1, 'C', '0', NULL, 'validCode', 'admins', '2021-10-17 13:55:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2104, '平台币种', 2106, 0, 'type', 'system/currency/index', 1, 'C', '0', '', 'international', 'admins', '2022-04-26 03:25:07', 'admins', '2022-12-10 15:14:10', '');
INSERT INTO `sys_menu` VALUES (2105, '在线用户', 1, 16, 'online', 'system/online/index', 1, 'C', '0', '', 'online', 'admins', '2022-10-06 15:40:16', 'admins', '2022-10-06 15:41:03', '');
INSERT INTO `sys_menu` VALUES (2106, '基础配置', 0, 0, 'basic', NULL, 1, 'M', '0', NULL, 'education', 'admins', '2022-12-10 15:11:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2108, '产品管理', 0, 4, 'operate', NULL, 1, 'M', '0', '', 'server', 'admins', '2022-12-10 15:18:51', 'admins', '2023-02-05 11:56:42', '');
INSERT INTO `sys_menu` VALUES (2113, '外汇产品', 2108, 1, 'productinfo', 'system/productinfo/index', 1, 'C', '0', '', 'monitor', 'admins', '2023-02-05 11:58:22', 'admins', '2023-02-23 13:28:27', '');
INSERT INTO `sys_menu` VALUES (2114, '加密货币', 2108, 2, 'data', 'system/productinfo/index_jm', 1, 'C', '0', '', 'slider', 'admins', '2023-02-05 15:13:14', 'admins', '2023-02-26 20:13:37', '');
INSERT INTO `sys_menu` VALUES (2115, '美股产品', 2108, 3, 'order', 'system/productinfo/index_mg', 1, 'C', '0', '', 'monitor', 'admins', '2023-02-15 11:05:21', 'admins', '2023-02-26 20:14:00', '');
INSERT INTO `sys_menu` VALUES (2116, '期货产品', 2108, 4, 'forward', 'system/productinfo/index_qh', 1, 'C', '0', '', 'slider', 'admins', '2023-02-23 13:30:25', 'admins', '2023-02-26 20:14:11', '');
INSERT INTO `sys_menu` VALUES (2117, 'ETF产品', 2108, 5, 'etf', 'system/productinfo/index_etf', 1, 'C', '0', '', 'monitor', 'admins', '2023-02-23 13:31:08', 'admins', '2023-02-26 20:14:21', '');
INSERT INTO `sys_menu` VALUES (2155, '域名管理', 2106, 3, 'domain', 'system/domain/index', 1, 'C', '0', NULL, 'documentation', 'admins', '2023-04-06 07:41:22', '', NULL, '');

-- ----------------------------
-- Table structure for sys_online
-- ----------------------------
DROP TABLE IF EXISTS `sys_online`;
CREATE TABLE `sys_online`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '钱包地址',
  `ipaddr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态',
  `login_time` datetime NULL DEFAULT NULL COMMENT '最后访问时间',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户在线情况' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_online
-- ----------------------------
INSERT INTO `sys_online` VALUES (1, '0x8e0371e8c056f7ecfe40ffd2c47160935a457430', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '在线', '2022-10-06 15:52:49', 199);

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4495 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '管理员');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '最后登陆IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登陆时间',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `google_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 100, 'admins', '超级管理员', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$ckNVjlItCVnpTP9vAqFtW.Dyk0lwPzCj8OZd1miRRmh84dio6apQC', '0', '0', '127.0.0.1', '2018-03-16 11:33:00', 'admin', '2018-03-16 11:33:00', 'ry', '2022-10-08 20:02:40', '管理员', '313123');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (106, 2);
INSERT INTO `sys_user_post` VALUES (107, 1);
INSERT INTO `sys_user_post` VALUES (108, 1);
INSERT INTO `sys_user_post` VALUES (109, 1);
INSERT INTO `sys_user_post` VALUES (110, 1);
INSERT INTO `sys_user_post` VALUES (111, 1);
INSERT INTO `sys_user_post` VALUES (112, 1);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
