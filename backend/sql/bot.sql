/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : bot

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 26/05/2023 18:49:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'platform_msg', '', 'PlatformMsg', 'crud', 'com.ruoyi.project.system', 'system', 'msg', NULL, 'ruoyi', NULL, 'admins', '2023-05-23 19:40:42', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (2, 'platform_group', '平台前端用户表', 'PlatformGroup', 'crud', 'com.ruoyi.project.system', 'system', 'group', '平台前端用户', 'ruoyi', NULL, 'admins', '2023-05-25 18:54:35', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (3, 'platform_msg_group', '消息组群', 'PlatformMsgGroup', 'crud', 'com.ruoyi.project.system', 'system', 'group', '消息组群', 'ruoyi', NULL, 'admins', '2023-05-25 19:05:52', '', NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, '1', 'id', 'id', 'bigint', 'Long', 'id', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admins', '2023-05-23 19:40:42', '', NULL);
INSERT INTO `gen_table_column` VALUES (2, '1', 'app_name', 'app名称', 'varchar(255)', 'String', 'appName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admins', '2023-05-23 19:40:42', '', NULL);
INSERT INTO `gen_table_column` VALUES (3, '1', 'sender', '发送人', 'varchar(255)', 'String', 'sender', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admins', '2023-05-23 19:40:42', '', NULL);
INSERT INTO `gen_table_column` VALUES (4, '1', 'sender_id', '发送人id', 'bigint', 'Long', 'senderId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admins', '2023-05-23 19:40:42', '', NULL);
INSERT INTO `gen_table_column` VALUES (5, '1', 'message', '发送过来的消息体', 'varchar(255)', 'String', 'message', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admins', '2023-05-23 19:40:42', '', NULL);
INSERT INTO `gen_table_column` VALUES (6, '1', 'group_name', '组群名', 'varchar(255)', 'String', 'groupName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 6, 'admins', '2023-05-23 19:40:42', '', NULL);
INSERT INTO `gen_table_column` VALUES (7, '1', 'receiver', '接收人', 'varchar(255)', 'String', 'receiver', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admins', '2023-05-23 19:40:42', '', NULL);
INSERT INTO `gen_table_column` VALUES (8, '1', 'receiver_id', '接送人id', 'bigint', 'Long', 'receiverId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admins', '2023-05-23 19:40:42', '', NULL);
INSERT INTO `gen_table_column` VALUES (9, '1', 'msg', '要回复的消息', 'varchar(255)', 'String', 'msg', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admins', '2023-05-23 19:40:42', '', NULL);
INSERT INTO `gen_table_column` VALUES (10, '1', 'pid', '相关的上一条消息id，没有上一条就是1', 'int', 'Long', 'pid', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admins', '2023-05-23 19:40:42', '', NULL);
INSERT INTO `gen_table_column` VALUES (11, '2', 'group_id', '用户组id', 'bigint', 'Long', 'groupId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admins', '2023-05-25 18:54:35', '', NULL);
INSERT INTO `gen_table_column` VALUES (12, '2', 'group_name', '用户组名称', 'varchar(255)', 'String', 'groupName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admins', '2023-05-25 18:54:35', '', NULL);
INSERT INTO `gen_table_column` VALUES (13, '2', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 3, 'admins', '2023-05-25 18:54:35', '', NULL);
INSERT INTO `gen_table_column` VALUES (14, '3', 'msg_group_id', '用户组id', 'bigint', 'Long', 'msgGroupId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admins', '2023-05-25 19:05:52', '', NULL);
INSERT INTO `gen_table_column` VALUES (15, '3', 'msg_group_name', '用户组名称', 'varchar(255)', 'String', 'msgGroupName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admins', '2023-05-25 19:05:52', '', NULL);
INSERT INTO `gen_table_column` VALUES (16, '3', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 3, 'admins', '2023-05-25 19:05:52', '', NULL);

-- ----------------------------
-- Table structure for platform_group
-- ----------------------------
DROP TABLE IF EXISTS `platform_group`;
CREATE TABLE `platform_group`  (
  `group_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户组id',
  `group_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户组名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '平台前端用户分组表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of platform_group
-- ----------------------------
INSERT INTO `platform_group` VALUES (1, '001组', '2023-05-25 19:03:04');
INSERT INTO `platform_group` VALUES (2, '002组', '2023-05-25 20:48:26');

-- ----------------------------
-- Table structure for platform_message
-- ----------------------------
DROP TABLE IF EXISTS `platform_message`;
CREATE TABLE `platform_message`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '消息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of platform_message
-- ----------------------------
INSERT INTO `platform_message` VALUES (1, '今天晚餐吃什么好呢？', '2023-05-25 22:43:12');
INSERT INTO `platform_message` VALUES (2, '我想吃中餐，你有什么推荐吗？', '2023-05-25 22:43:46');
INSERT INTO `platform_message` VALUES (3, '太棒了！我喜欢蔬菜和牛肉，你呢？', '2023-05-25 22:44:40');
INSERT INTO `platform_message` VALUES (4, '太棒了！我喜欢蔬菜和牛肉，你呢？', '2023-05-25 22:45:05');

-- ----------------------------
-- Table structure for platform_msg
-- ----------------------------
DROP TABLE IF EXISTS `platform_msg`;
CREATE TABLE `platform_msg`  (
  `id` bigint NOT NULL COMMENT 'id',
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '发送过来的消息体',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '要回复的消息',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user_id` bigint NOT NULL COMMENT '创建人id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '消息保存' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of platform_msg
-- ----------------------------
INSERT INTO `platform_msg` VALUES (1661733075029262336, '今天晚餐吃什么好呢？', '我想吃中餐，你有什么推荐吗？', '2023-05-25 21:56:53', 1);
INSERT INTO `platform_msg` VALUES (1661741290097930240, '我想吃中餐，你有什么推荐吗？', '可以去尝试那家新开的川菜馆，听说口味很正宗。', '2023-05-25 22:29:31', 1);
INSERT INTO `platform_msg` VALUES (1661745012744048640, '好主意！我喜欢吃辣的，川菜应该很合我口味。', '那我们点一份麻辣香锅吧，里面可以选不同的配料。', '2023-05-25 22:44:19', 1);
INSERT INTO `platform_msg` VALUES (1661745063100862464, '太棒了！我喜欢蔬菜和牛肉，你呢？', '我喜欢鸡肉和豆腐，我们可以点一些小龙虾吗？', '2023-05-25 22:44:31', 1);

-- ----------------------------
-- Table structure for platform_msg_group
-- ----------------------------
DROP TABLE IF EXISTS `platform_msg_group`;
CREATE TABLE `platform_msg_group`  (
  `msg_group_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户组id',
  `msg_group_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户组名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`msg_group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '消息组群' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of platform_msg_group
-- ----------------------------
INSERT INTO `platform_msg_group` VALUES (2, 'Ai群', '2023-05-25 20:41:58');
INSERT INTO `platform_msg_group` VALUES (3, '旅游群', '2023-05-25 20:42:06');
INSERT INTO `platform_msg_group` VALUES (4, '产品销售1群', '2023-05-25 20:47:11');
INSERT INTO `platform_msg_group` VALUES (5, '产品销售2群', '2023-05-25 20:47:18');

-- ----------------------------
-- Table structure for platform_user
-- ----------------------------
DROP TABLE IF EXISTS `platform_user`;
CREATE TABLE `platform_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `access_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '平台用户token',
  `user_group_id` bigint NULL DEFAULT NULL COMMENT '用户所属用户组id',
  `msg_group_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户所在消息群组',
  `create_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '平台前端用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of platform_user
-- ----------------------------
INSERT INTO `platform_user` VALUES (1, 'meng', '55bc21a204be4a539dfc1aa7d0bc9e6f', 1, '2,3', NULL);
INSERT INTO `platform_user` VALUES (2, 'cloud', 'f8d3c3dd91864eefb323da59926dcb6a', 1, '2,3', NULL);
INSERT INTO `platform_user` VALUES (3, 'Jack', '406218b3aa464451ae115e2e9e50b7f6', 1, '2,3', NULL);
INSERT INTO `platform_user` VALUES (4, 'Catc', '0f22eedd979044e283b66e854cfacdbd', 2, '4,5', NULL);

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lock_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE,
  INDEX `index_2`(`lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('RuoyiScheduler', 'DESKTOP-QVTSIES1685025619772', 1685025982949, 15000);

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 11164 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (101, '每日最多提现次数', 'cash_out_num', '10', 'Y', 'admin', '2020-05-01 13:26:02', 'admins', '2022-04-09 13:15:07', '提现笔数');
INSERT INTO `sys_config` VALUES (102, '单笔提现范围USDT', 'cash_out_money_scope', '100~500000', 'Y', 'admin', '2020-05-01 13:27:32', 'admins', '2023-03-30 08:35:49', '单笔提现范围2000~3000元');
INSERT INTO `sys_config` VALUES (105, '充值范围', 'recharge_scope', '1~500000', 'Y', 'admin', '2020-05-01 13:30:58', 'admin', '2020-06-05 20:17:20', '充值范围');
INSERT INTO `sys_config` VALUES (106, '充值金额是几的倍数', 'times', '0', 'Y', 'admin', '2020-05-01 13:36:47', 'admin', '2020-05-23 15:28:03', '充值金额是10的倍数');
INSERT INTO `sys_config` VALUES (117, '网站名称', 'site_name', 'Bot-Msg', 'Y', 'admin', '2020-05-05 14:39:40', 'admins', '2023-03-29 16:11:37', '网站名称');
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
INSERT INTO `sys_config` VALUES (11146, '平台名称', 'platform_name', 'bot', 'Y', 'admins', '2023-03-26 13:48:34', 'admins', '2023-05-22 20:09:41', NULL);
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
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 94 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 11244 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (1, 'admins', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-01 11:19:06', 1);
INSERT INTO `sys_logininfor` VALUES (2, 'admins', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-14 20:20:32', 1);
INSERT INTO `sys_logininfor` VALUES (3, 'admins', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-14 21:07:12', 1);
INSERT INTO `sys_logininfor` VALUES (4, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '1', '验证码错误', '2023-05-22 20:08:31', 0);
INSERT INTO `sys_logininfor` VALUES (5, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-22 20:08:38', 0);
INSERT INTO `sys_logininfor` VALUES (6, 'admins', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-22 20:08:44', 1);
INSERT INTO `sys_logininfor` VALUES (7, 'admins', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '1', '验证码已失效', '2023-05-22 20:08:45', 0);
INSERT INTO `sys_logininfor` VALUES (8, 'admins', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '退出成功', '2023-05-22 20:09:44', 1);
INSERT INTO `sys_logininfor` VALUES (9, 'admins', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '1', '验证码错误', '2023-05-22 20:18:05', 0);
INSERT INTO `sys_logininfor` VALUES (10, 'admins', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-22 20:18:08', 1);
INSERT INTO `sys_logininfor` VALUES (11, 'admins', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '退出成功', '2023-05-22 20:25:21', 1);
INSERT INTO `sys_logininfor` VALUES (12, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-23 19:35:51', 0);
INSERT INTO `sys_logininfor` VALUES (13, 'admins', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-23 19:35:57', 1);
INSERT INTO `sys_logininfor` VALUES (14, 'admins', '192.168.2.130', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-23 19:42:01', 1);
INSERT INTO `sys_logininfor` VALUES (15, 'admins', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-23 19:57:03', 1);
INSERT INTO `sys_logininfor` VALUES (16, 'admins', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-25 01:30:56', 1);
INSERT INTO `sys_logininfor` VALUES (17, 'admins', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-25 18:49:59', 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 2170 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

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
INSERT INTO `sys_menu` VALUES (2105, '在线用户', 1, 16, 'online', 'system/online/index', 1, 'C', '0', '', 'online', 'admins', '2022-10-06 15:40:16', 'admins', '2022-10-06 15:41:03', '');
INSERT INTO `sys_menu` VALUES (2106, '基础配置', 0, 0, 'basic', NULL, 1, 'M', '0', NULL, 'education', 'admins', '2022-12-10 15:11:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2155, '消息', 2106, 1, 'msg', 'system/msg/index', 1, 'C', '0', 'system:msg:list', 'code', 'admin', '2018-03-01 00:00:00', 'admins', '2023-05-23 20:06:52', '【请填写功能名称】菜单');
INSERT INTO `sys_menu` VALUES (2156, '【请填写功能名称】查询', 2155, 1, '#', '', 1, 'F', '0', 'system:msg:query', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2157, '【请填写功能名称】新增', 2155, 2, '#', '', 1, 'F', '0', 'system:msg:add', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2158, '【请填写功能名称】修改', 2155, 3, '#', '', 1, 'F', '0', 'system:msg:edit', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2159, '【请填写功能名称】删除', 2155, 4, '#', '', 1, 'F', '0', 'system:msg:remove', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2160, '用户分组', 2106, 1, 'group', 'system/group/index', 1, 'C', '0', 'system:group:list', 'peoples', 'admin', '2018-03-01 00:00:00', 'admins', '2023-05-25 19:38:45', '平台前端用户菜单');
INSERT INTO `sys_menu` VALUES (2161, '平台前端用户查询', 2160, 1, '#', '', 1, 'F', '0', 'system:group:query', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2162, '平台前端用户新增', 2160, 2, '#', '', 1, 'F', '0', 'system:group:add', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2163, '平台前端用户修改', 2160, 3, '#', '', 1, 'F', '0', 'system:group:edit', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2164, '平台前端用户删除', 2160, 4, '#', '', 1, 'F', '0', 'system:group:remove', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2165, '消息组群', 2106, 1, 'msggroup', 'system/msggroup/index', 1, 'C', '0', 'system:msggroup:list', 'github', 'admin', '2018-03-01 00:00:00', 'admins', '2023-05-25 19:14:49', '消息组群菜单');
INSERT INTO `sys_menu` VALUES (2166, '消息组群查询', 2165, 1, '#', '', 1, 'F', '0', 'system:msggroup:query', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2167, '消息组群新增', 2165, 2, '#', '', 1, 'F', '0', 'system:msggroup:add', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2168, '消息组群修改', 2165, 3, '#', '', 1, 'F', '0', 'system:msggroup:edit', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2169, '消息组群删除', 2165, 4, '#', '', 1, 'F', '0', 'system:msggroup:remove', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户在线情况' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 69 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (7, '参数管理', 2, 'com.ruoyi.project.system.controller.SysConfigController.edit()', 'PUT', 1, 'admins', NULL, '/system/config', '127.0.0.1', '内网IP', '{\"configId\":11146,\"configKey\":\"platform_name\",\"configName\":\"平台名称\",\"configType\":\"Y\",\"configValue\":\"bot\",\"createBy\":\"admins\",\"createTime\":\"2023-03-26 13:48:34\",\"params\":{},\"updateBy\":\"admins\",\"updateTime\":\"2023-03-29 12:57:18\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-22 20:09:41');
INSERT INTO `sys_oper_log` VALUES (8, '代码生成', 6, 'com.ruoyi.project.tool.gen.controller.GenController.importTableSave()', 'POST', 1, 'admins', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-23 19:40:42');
INSERT INTO `sys_oper_log` VALUES (9, '代码生成', 8, 'com.ruoyi.project.tool.gen.controller.GenController.batchGenCode()', 'GET', 1, 'admins', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', 'null', 0, NULL, '2023-05-23 19:59:27');
INSERT INTO `sys_oper_log` VALUES (10, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admins', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/msg/index\",\"createTime\":\"2018-03-01 00:00:00\",\"icon\":\"#\",\"isFrame\":\"1\",\"menuId\":2155,\"menuName\":\"消息\",\"menuType\":\"C\",\"orderNum\":\"1\",\"params\":{},\"parentId\":3,\"path\":\"msg\",\"perms\":\"system:msg:list\",\"updateBy\":\"admins\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-23 20:05:10');
INSERT INTO `sys_oper_log` VALUES (11, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admins', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/msg/index\",\"createTime\":\"2018-03-01 00:00:00\",\"icon\":\"#\",\"isFrame\":\"1\",\"menuId\":2155,\"menuName\":\"消息\",\"menuType\":\"C\",\"orderNum\":\"1\",\"params\":{},\"parentId\":0,\"path\":\"msg\",\"perms\":\"system:msg:list\",\"updateBy\":\"admins\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-23 20:05:15');
INSERT INTO `sys_oper_log` VALUES (12, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admins', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/msg/index\",\"createTime\":\"2018-03-01 00:00:00\",\"icon\":\"#\",\"isFrame\":\"1\",\"menuId\":2155,\"menuName\":\"消息\",\"menuType\":\"M\",\"orderNum\":\"1\",\"params\":{},\"parentId\":0,\"path\":\"msg\",\"perms\":\"system:msg:list\",\"updateBy\":\"admins\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-23 20:05:31');
INSERT INTO `sys_oper_log` VALUES (13, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admins', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/msg/index\",\"createTime\":\"2018-03-01 00:00:00\",\"icon\":\"#\",\"isFrame\":\"1\",\"menuId\":2155,\"menuName\":\"消息\",\"menuType\":\"C\",\"orderNum\":\"1\",\"params\":{},\"parentId\":2054,\"path\":\"msg\",\"perms\":\"system:msg:list\",\"updateBy\":\"admins\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-23 20:05:52');
INSERT INTO `sys_oper_log` VALUES (14, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admins', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/msg/index\",\"createTime\":\"2018-03-01 00:00:00\",\"icon\":\"code\",\"isFrame\":\"1\",\"menuId\":2155,\"menuName\":\"消息\",\"menuType\":\"C\",\"orderNum\":\"1\",\"params\":{},\"parentId\":2054,\"path\":\"msg\",\"perms\":\"system:msg:list\",\"updateBy\":\"admins\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-23 20:06:24');
INSERT INTO `sys_oper_log` VALUES (15, '菜单管理', 3, 'com.ruoyi.project.system.controller.SysMenuController.remove()', 'DELETE', 1, 'admins', NULL, '/system/menu/2108', '127.0.0.1', '内网IP', '{menuId=2108}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-23 20:06:40');
INSERT INTO `sys_oper_log` VALUES (16, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admins', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/msg/index\",\"createTime\":\"2018-03-01 00:00:00\",\"icon\":\"code\",\"isFrame\":\"1\",\"menuId\":2155,\"menuName\":\"消息\",\"menuType\":\"C\",\"orderNum\":\"1\",\"params\":{},\"parentId\":2106,\"path\":\"msg\",\"perms\":\"system:msg:list\",\"updateBy\":\"admins\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-23 20:06:52');
INSERT INTO `sys_oper_log` VALUES (17, '【请填写功能名称】', 1, 'com.ruoyi.project.system.controller.PlatformMsgController.add()', 'POST', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"appName\":\"WhatAuto\",\"groupName\":\"\",\"id\":1661012599072030720,\"message\":\"Ai群\",\"msg\":\"Ai群\",\"params\":{},\"receiver\":\"meng\",\"receiverId\":1,\"sender\":\"meng\",\"senderId\":1}', 'null', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'pid\' doesn\'t have a default value\r\n### The error may exist in file [H:\\code\\work\\bot-msg\\backend\\target\\classes\\mybatis\\system\\PlatformMsgMapper.xml]\r\n### The error may involve com.ruoyi.project.system.mapper.PlatformMsgMapper.insertPlatformMsg-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into platform_msg          ( id,             app_name,             sender,             sender_id,             message,                          receiver,             receiver_id,             msg )           values ( ?,             ?,             ?,             ?,             ?,                          ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'pid\' doesn\'t have a default value\n; Field \'pid\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'pid\' doesn\'t have a default value', '2023-05-23 22:13:58');
INSERT INTO `sys_oper_log` VALUES (18, '【请填写功能名称】', 1, 'com.ruoyi.project.system.controller.PlatformMsgController.add()', 'POST', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"appName\":\"WhatAuto\",\"groupName\":\"\",\"id\":1661012682840670208,\"message\":\"Ai群\",\"msg\":\"Ai群\",\"params\":{},\"receiver\":\"meng\",\"receiverId\":1,\"sender\":\"meng\",\"senderId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-23 22:14:18');
INSERT INTO `sys_oper_log` VALUES (19, '【请填写功能名称】', 1, 'com.ruoyi.project.system.controller.PlatformMsgController.add()', 'POST', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"appName\":\"WhatAuto\",\"id\":1661012880077815808,\"message\":\"Ai群1\",\"msg\":\"Ai群2\",\"params\":{},\"receiver\":\"meng\",\"receiverId\":1,\"sender\":\"meng\",\"senderId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-23 22:15:14');
INSERT INTO `sys_oper_log` VALUES (20, '【请填写功能名称】', 2, 'com.ruoyi.project.system.controller.PlatformMsgController.edit()', 'PUT', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"appName\":\"WhatAuto\",\"id\":1661012682840670208,\"message\":\"你好\",\"msg\":\"我很好\",\"params\":{},\"receiver\":\"cloud\",\"receiverId\":2,\"sender\":\"meng\",\"senderId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-23 23:51:36');
INSERT INTO `sys_oper_log` VALUES (21, '【请填写功能名称】', 2, 'com.ruoyi.project.system.controller.PlatformMsgController.edit()', 'PUT', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"appName\":\"WhatsApp\",\"id\":1661012682840670208,\"message\":\"你好\",\"msg\":\"我很好\",\"params\":{},\"receiver\":\"cloud\",\"receiverId\":2,\"sender\":\"meng\",\"senderId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-23 23:56:35');
INSERT INTO `sys_oper_log` VALUES (22, '【请填写功能名称】', 2, 'com.ruoyi.project.system.controller.PlatformMsgController.edit()', 'PUT', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"appName\":\"WhatsApp\",\"id\":1661012682840670208,\"message\":\"你好\",\"msg\":\"我很好\",\"params\":{},\"receiver\":\"cloud\",\"receiverId\":1,\"sender\":\"meng\",\"senderId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 01:33:48');
INSERT INTO `sys_oper_log` VALUES (23, '【请填写功能名称】', 2, 'com.ruoyi.project.system.controller.PlatformMsgController.edit()', 'PUT', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"appName\":\"WhatsApp\",\"id\":1661012682840670208,\"message\":\"你好\",\"msg\":\"我很好\",\"params\":{},\"receiver\":\"cloud\",\"receiverId\":1,\"sender\":\"meng\",\"senderId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 01:37:03');
INSERT INTO `sys_oper_log` VALUES (24, '【请填写功能名称】', 2, 'com.ruoyi.project.system.controller.PlatformMsgController.edit()', 'PUT', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"appName\":\"WhatsApp\",\"id\":1661012682840670208,\"message\":\"你好\",\"msg\":\"我很好\",\"params\":{},\"receiver\":\"cloud\",\"receiverId\":2,\"sender\":\"meng\",\"senderId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 01:38:24');
INSERT INTO `sys_oper_log` VALUES (25, '【请填写功能名称】', 2, 'com.ruoyi.project.system.controller.PlatformMsgController.edit()', 'PUT', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"appName\":\"WhatsApp\",\"id\":1661012682840670208,\"message\":\"你好\",\"msg\":\"我很好\",\"params\":{},\"receiver\":\"cloud\",\"receiverId\":2,\"sender\":\"meng\",\"senderId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 01:39:54');
INSERT INTO `sys_oper_log` VALUES (26, '【请填写功能名称】', 2, 'com.ruoyi.project.system.controller.PlatformMsgController.edit()', 'PUT', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"appName\":\"WhatsApp\",\"id\":1661012682840670208,\"message\":\"你好\",\"msg\":\"我很好\",\"params\":{},\"receiver\":\"cloud\",\"receiverId\":2,\"sender\":\"cloud\",\"senderId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 01:43:08');
INSERT INTO `sys_oper_log` VALUES (27, '【请填写功能名称】', 2, 'com.ruoyi.project.system.controller.PlatformMsgController.edit()', 'PUT', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"appName\":\"WhatAuto\",\"id\":1661012880077815808,\"message\":\"Ai群1\",\"msg\":\"Ai群2\",\"params\":{},\"receiver\":\"meng\",\"receiverId\":1,\"sender\":\"cloud\",\"senderId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 01:43:22');
INSERT INTO `sys_oper_log` VALUES (28, '【请填写功能名称】', 2, 'com.ruoyi.project.system.controller.PlatformMsgController.edit()', 'PUT', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"appName\":\"WhatsApp\",\"id\":1661012682840670208,\"message\":\"你好\",\"msg\":\"我很好\",\"params\":{},\"receiver\":\"cloud\",\"receiverId\":1,\"sender\":\"meng\",\"senderId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 01:43:27');
INSERT INTO `sys_oper_log` VALUES (29, '【请填写功能名称】', 2, 'com.ruoyi.project.system.controller.PlatformMsgController.edit()', 'PUT', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"appName\":\"WhatsApp\",\"id\":1661012682840670208,\"message\":\"你好\",\"msg\":\"我很好\",\"params\":{},\"receiver\":\"cloud\",\"receiverId\":1,\"sender\":\"meng\",\"senderId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 01:43:38');
INSERT INTO `sys_oper_log` VALUES (30, '【请填写功能名称】', 2, 'com.ruoyi.project.system.controller.PlatformMsgController.edit()', 'PUT', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"appName\":\"WhatsApp\",\"id\":1661012682840670208,\"message\":\"你好\",\"msg\":\"我很好\",\"params\":{},\"receiver\":\"cloud\",\"receiverId\":1,\"sender\":\"meng\",\"senderId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 01:43:54');
INSERT INTO `sys_oper_log` VALUES (31, '【请填写功能名称】', 2, 'com.ruoyi.project.system.controller.PlatformMsgController.edit()', 'PUT', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"appName\":\"WhatsApp\",\"id\":1661012682840670208,\"message\":\"你好\",\"msg\":\"我很好\",\"params\":{},\"receiver\":\"cloud\",\"receiverId\":1,\"sender\":\"meng\",\"senderId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 01:45:24');
INSERT INTO `sys_oper_log` VALUES (32, '【请填写功能名称】', 2, 'com.ruoyi.project.system.controller.PlatformMsgController.edit()', 'PUT', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"appName\":\"WhatsApp\",\"id\":1661012682840670208,\"message\":\"你好\",\"msg\":\"我很好\",\"params\":{},\"receiver\":\"meng\",\"receiverId\":1,\"sender\":\"cloud\",\"senderId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 01:47:40');
INSERT INTO `sys_oper_log` VALUES (33, '【请填写功能名称】', 2, 'com.ruoyi.project.system.controller.PlatformMsgController.edit()', 'PUT', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"appName\":\"WhatsApp\",\"id\":1661012682840670208,\"message\":\"你好\",\"msg\":\"我很好\",\"params\":{},\"receiver\":\"cloud\",\"receiverId\":2,\"sender\":\"meng\",\"senderId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 01:47:47');
INSERT INTO `sys_oper_log` VALUES (34, '【请填写功能名称】', 2, 'com.ruoyi.project.system.controller.PlatformMsgController.edit()', 'PUT', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"appName\":\"WhatsApp\",\"id\":1661012682840670208,\"message\":\"你好\",\"msg\":\"我很好\",\"params\":{},\"receiver\":\"meng\",\"receiverId\":1,\"sender\":\"cloud\",\"senderId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 01:47:54');
INSERT INTO `sys_oper_log` VALUES (35, '【请填写功能名称】', 2, 'com.ruoyi.project.system.controller.PlatformMsgController.edit()', 'PUT', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"appName\":\"WhatAuto\",\"id\":1661012880077815808,\"message\":\"Ai群1\",\"msg\":\"Ai群2\",\"params\":{},\"receiver\":\"cloud\",\"receiverId\":2,\"sender\":\"meng\",\"senderId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 01:48:03');
INSERT INTO `sys_oper_log` VALUES (36, '代码生成', 6, 'com.ruoyi.project.tool.gen.controller.GenController.importTableSave()', 'POST', 1, 'admins', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 18:54:35');
INSERT INTO `sys_oper_log` VALUES (37, '代码生成', 8, 'com.ruoyi.project.tool.gen.controller.GenController.batchGenCode()', 'GET', 1, 'admins', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', 'null', 0, NULL, '2023-05-25 18:57:25');
INSERT INTO `sys_oper_log` VALUES (38, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admins', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/group/index\",\"createTime\":\"2018-03-01 00:00:00\",\"icon\":\"peoples\",\"isFrame\":\"1\",\"menuId\":2160,\"menuName\":\"用户分组\",\"menuType\":\"C\",\"orderNum\":\"1\",\"params\":{},\"parentId\":2054,\"path\":\"group\",\"perms\":\"system:group:list\",\"updateBy\":\"admins\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 19:01:34');
INSERT INTO `sys_oper_log` VALUES (39, '平台前端用户', 1, 'com.ruoyi.project.system.controller.PlatformGroupController.add()', 'POST', 1, 'admins', NULL, '/system/group', '127.0.0.1', '内网IP', '{\"createTime\":\"2023-05-25 19:02:29\",\"groupId\":3,\"groupName\":\"001组\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 19:02:29');
INSERT INTO `sys_oper_log` VALUES (40, '平台前端用户', 1, 'com.ruoyi.project.system.controller.PlatformGroupController.add()', 'POST', 1, 'admins', NULL, '/system/group', '127.0.0.1', '内网IP', '{\"createTime\":\"2023-05-25 19:03:03\",\"groupId\":1,\"groupName\":\"001组\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 19:03:03');
INSERT INTO `sys_oper_log` VALUES (41, '代码生成', 6, 'com.ruoyi.project.tool.gen.controller.GenController.importTableSave()', 'POST', 1, 'admins', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 19:05:53');
INSERT INTO `sys_oper_log` VALUES (42, '代码生成', 8, 'com.ruoyi.project.tool.gen.controller.GenController.batchGenCode()', 'GET', 1, 'admins', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', 'null', 0, NULL, '2023-05-25 19:06:05');
INSERT INTO `sys_oper_log` VALUES (43, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admins', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/msggroup/index\",\"createTime\":\"2018-03-01 00:00:00\",\"icon\":\"#\",\"isFrame\":\"1\",\"menuId\":2165,\"menuName\":\"消息组群\",\"menuType\":\"C\",\"orderNum\":\"1\",\"params\":{},\"parentId\":2106,\"path\":\"msggroup\",\"perms\":\"system:msggroup:list\",\"updateBy\":\"admins\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 19:14:16');
INSERT INTO `sys_oper_log` VALUES (44, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admins', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/msggroup/index\",\"createTime\":\"2018-03-01 00:00:00\",\"icon\":\"github\",\"isFrame\":\"1\",\"menuId\":2165,\"menuName\":\"消息组群\",\"menuType\":\"C\",\"orderNum\":\"1\",\"params\":{},\"parentId\":2106,\"path\":\"msggroup\",\"perms\":\"system:msggroup:list\",\"updateBy\":\"admins\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 19:14:49');
INSERT INTO `sys_oper_log` VALUES (45, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admins', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/group/index\",\"createTime\":\"2018-03-01 00:00:00\",\"icon\":\"peoples\",\"isFrame\":\"1\",\"menuId\":2160,\"menuName\":\"用户分组\",\"menuType\":\"C\",\"orderNum\":\"1\",\"params\":{},\"parentId\":2106,\"path\":\"group\",\"perms\":\"system:group:list\",\"updateBy\":\"admins\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 19:38:45');
INSERT INTO `sys_oper_log` VALUES (46, '消息组群', 1, 'com.ruoyi.project.system.controller.PlatformMsgGroupController.add()', 'POST', 1, 'admins', NULL, '/system/msggroup', '127.0.0.1', '内网IP', '{\"createTime\":\"2023-05-25 20:41:58\",\"msgGroupId\":2,\"msgGroupName\":\"Ai群\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 20:41:58');
INSERT INTO `sys_oper_log` VALUES (47, '消息组群', 1, 'com.ruoyi.project.system.controller.PlatformMsgGroupController.add()', 'POST', 1, 'admins', NULL, '/system/msggroup', '127.0.0.1', '内网IP', '{\"createTime\":\"2023-05-25 20:42:06\",\"msgGroupId\":3,\"msgGroupName\":\"旅游群\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 20:42:06');
INSERT INTO `sys_oper_log` VALUES (48, '平台前端用户', 2, 'com.ruoyi.project.system.controller.PlatformUserController.edit()', 'POST', 1, 'admins', NULL, '/system/platuser/update', '127.0.0.1', '内网IP', '{\"accessToken\":\"55bc21a204be4a539dfc1aa7d0bc9e6f\",\"msgGroupIds\":\"2,3\",\"params\":{},\"userGroupId\":1,\"userId\":1,\"userName\":\"meng\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 20:45:29');
INSERT INTO `sys_oper_log` VALUES (49, '平台前端用户', 1, 'com.ruoyi.project.system.controller.PlatformUserController.add()', 'POST', 1, 'admins', NULL, '/system/platuser', '127.0.0.1', '内网IP', '{\"accessToken\":\"406218b3aa464451ae115e2e9e50b7f6\",\"msgGroupIds\":\"2,3\",\"params\":{},\"userGroupId\":1,\"userId\":3,\"userName\":\"Jack\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 20:46:45');
INSERT INTO `sys_oper_log` VALUES (50, '平台前端用户', 2, 'com.ruoyi.project.system.controller.PlatformUserController.edit()', 'POST', 1, 'admins', NULL, '/system/platuser/update', '127.0.0.1', '内网IP', '{\"accessToken\":\"f8d3c3dd91864eefb323da59926dcb6a\",\"msgGroupIds\":\"2,3\",\"params\":{},\"userGroupId\":1,\"userId\":2,\"userName\":\"cloud\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 20:46:52');
INSERT INTO `sys_oper_log` VALUES (51, '消息组群', 1, 'com.ruoyi.project.system.controller.PlatformMsgGroupController.add()', 'POST', 1, 'admins', NULL, '/system/msggroup', '127.0.0.1', '内网IP', '{\"createTime\":\"2023-05-25 20:47:11\",\"msgGroupId\":4,\"msgGroupName\":\"产品销售1群\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 20:47:11');
INSERT INTO `sys_oper_log` VALUES (52, '消息组群', 1, 'com.ruoyi.project.system.controller.PlatformMsgGroupController.add()', 'POST', 1, 'admins', NULL, '/system/msggroup', '127.0.0.1', '内网IP', '{\"createTime\":\"2023-05-25 20:47:17\",\"msgGroupId\":5,\"msgGroupName\":\"产品销售2群\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 20:47:17');
INSERT INTO `sys_oper_log` VALUES (53, '平台前端用户', 1, 'com.ruoyi.project.system.controller.PlatformGroupController.add()', 'POST', 1, 'admins', NULL, '/system/group', '127.0.0.1', '内网IP', '{\"createTime\":\"2023-05-25 20:48:26\",\"groupId\":2,\"groupName\":\"002组\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 20:48:26');
INSERT INTO `sys_oper_log` VALUES (54, '平台前端用户', 1, 'com.ruoyi.project.system.controller.PlatformUserController.add()', 'POST', 1, 'admins', NULL, '/system/platuser', '127.0.0.1', '内网IP', '{\"accessToken\":\"0f22eedd979044e283b66e854cfacdbd\",\"msgGroupIds\":\"4,5\",\"params\":{},\"userGroupId\":2,\"userId\":4,\"userName\":\"Catc\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 20:48:54');
INSERT INTO `sys_oper_log` VALUES (55, '消息组群', 3, 'com.ruoyi.project.system.controller.PlatformMsgGroupController.remove()', 'DELETE', 1, 'admins', NULL, '/system/msggroup/5', '127.0.0.1', '内网IP', '{msgGroupIds=5}', 'null', 1, '当前消息分组仍然被使用中，无法删除', '2023-05-25 21:05:19');
INSERT INTO `sys_oper_log` VALUES (56, '【请填写功能名称】', 1, 'com.ruoyi.project.system.controller.PlatformMsgController.add()', 'POST', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"id\":1661731755438309376,\"message\":\"今天晚餐吃什么好呢？\",\"msg\":\"我想吃中餐，你有什么推荐吗？\",\"params\":{}}', 'null', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'create_time\' doesn\'t have a default value\r\n### The error may exist in file [H:\\code\\work\\bot-msg\\backend\\target\\classes\\mybatis\\system\\PlatformMsgMapper.xml]\r\n### The error may involve com.ruoyi.project.system.mapper.PlatformMsgMapper.insertPlatformMsg-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into platform_msg          ( id,             message,             msg )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'create_time\' doesn\'t have a default value\n; Field \'create_time\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'create_time\' doesn\'t have a default value', '2023-05-25 21:51:38');
INSERT INTO `sys_oper_log` VALUES (57, '【请填写功能名称】', 1, 'com.ruoyi.project.system.controller.PlatformMsgController.add()', 'POST', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"id\":1661731931611660288,\"message\":\"今天晚餐吃什么好呢？\",\"msg\":\"我想吃中餐，你有什么推荐吗？\",\"params\":{}}', 'null', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'create_time\' doesn\'t have a default value\r\n### The error may exist in file [H:\\code\\work\\bot-msg\\backend\\target\\classes\\mybatis\\system\\PlatformMsgMapper.xml]\r\n### The error may involve com.ruoyi.project.system.mapper.PlatformMsgMapper.insertPlatformMsg-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into platform_msg          ( id,             message,             msg )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'create_time\' doesn\'t have a default value\n; Field \'create_time\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'create_time\' doesn\'t have a default value', '2023-05-25 21:52:20');
INSERT INTO `sys_oper_log` VALUES (58, '【请填写功能名称】', 1, 'com.ruoyi.project.system.controller.PlatformMsgController.add()', 'POST', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"id\":1661732027078213632,\"message\":\"今天晚餐吃什么好呢？\",\"msg\":\"我想吃中餐，你有什么推荐吗？\",\"params\":{}}', 'null', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'create_time\' doesn\'t have a default value\r\n### The error may exist in file [H:\\code\\work\\bot-msg\\backend\\target\\classes\\mybatis\\system\\PlatformMsgMapper.xml]\r\n### The error may involve com.ruoyi.project.system.mapper.PlatformMsgMapper.insertPlatformMsg-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into platform_msg          ( id,             message,             msg )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'create_time\' doesn\'t have a default value\n; Field \'create_time\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'create_time\' doesn\'t have a default value', '2023-05-25 21:52:43');
INSERT INTO `sys_oper_log` VALUES (59, '【请填写功能名称】', 1, 'com.ruoyi.project.system.controller.PlatformMsgController.add()', 'POST', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"id\":1661732191092277248,\"message\":\"今天晚餐吃什么好呢？\",\"msg\":\"我想吃中餐，你有什么推荐吗？\",\"params\":{}}', 'null', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'create_user_id\' doesn\'t have a default value\r\n### The error may exist in file [H:\\code\\work\\bot-msg\\backend\\target\\classes\\mybatis\\system\\PlatformMsgMapper.xml]\r\n### The error may involve com.ruoyi.project.system.mapper.PlatformMsgMapper.insertPlatformMsg-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into platform_msg          ( id,             message,             msg )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'create_user_id\' doesn\'t have a default value\n; Field \'create_user_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'create_user_id\' doesn\'t have a default value', '2023-05-25 21:53:22');
INSERT INTO `sys_oper_log` VALUES (60, '【请填写功能名称】', 1, 'com.ruoyi.project.system.controller.PlatformMsgController.add()', 'POST', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"id\":1661732523469897728,\"message\":\"今天晚餐吃什么好呢？\",\"msg\":\"我想吃中餐，你有什么推荐吗？\",\"params\":{}}', 'null', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'create_user_id\' doesn\'t have a default value\r\n### The error may exist in file [H:\\code\\work\\bot-msg\\backend\\target\\classes\\mybatis\\system\\PlatformMsgMapper.xml]\r\n### The error may involve com.ruoyi.project.system.mapper.PlatformMsgMapper.insertPlatformMsg-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into platform_msg          ( id,             message,             msg )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'create_user_id\' doesn\'t have a default value\n; Field \'create_user_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'create_user_id\' doesn\'t have a default value', '2023-05-25 21:54:41');
INSERT INTO `sys_oper_log` VALUES (61, '【请填写功能名称】', 1, 'com.ruoyi.project.system.controller.PlatformMsgController.add()', 'POST', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"id\":1661732658996248576,\"message\":\"今天晚餐吃什么好呢？\",\"msg\":\"我想吃中餐，你有什么推荐吗？\",\"params\":{}}', 'null', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'create_user_id\' doesn\'t have a default value\r\n### The error may exist in file [H:\\code\\work\\bot-msg\\backend\\target\\classes\\mybatis\\system\\PlatformMsgMapper.xml]\r\n### The error may involve com.ruoyi.project.system.mapper.PlatformMsgMapper.insertPlatformMsg-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into platform_msg          ( id,             message,             msg )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'create_user_id\' doesn\'t have a default value\n; Field \'create_user_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'create_user_id\' doesn\'t have a default value', '2023-05-25 21:55:14');
INSERT INTO `sys_oper_log` VALUES (62, '【请填写功能名称】', 2, 'com.ruoyi.project.system.controller.PlatformMsgController.edit()', 'PUT', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"createUserId\":1,\"id\":1661012682840670208,\"message\":\"你好\",\"msg\":\"我很好\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 21:56:43');
INSERT INTO `sys_oper_log` VALUES (63, '【请填写功能名称】', 1, 'com.ruoyi.project.system.controller.PlatformMsgController.add()', 'POST', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"createUserId\":1,\"id\":1661733075029262336,\"message\":\"今天晚餐吃什么好呢？\",\"msg\":\"我想吃中餐，你有什么推荐吗？\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 21:56:53');
INSERT INTO `sys_oper_log` VALUES (64, '【请填写功能名称】', 1, 'com.ruoyi.project.system.controller.PlatformMsgController.add()', 'POST', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"createUserId\":1,\"id\":1661741290097930240,\"message\":\"我想吃中餐，你有什么推荐吗？\",\"msg\":\"可以去尝试那家新开的川菜馆，听说口味很正宗。\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 22:29:31');
INSERT INTO `sys_oper_log` VALUES (65, '【请填写功能名称】', 3, 'com.ruoyi.project.system.controller.PlatformMsgController.remove()', 'DELETE', 1, 'admins', NULL, '/system/msg/1661012880077815808', '127.0.0.1', '内网IP', '{ids=1661012880077815808}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 22:30:56');
INSERT INTO `sys_oper_log` VALUES (66, '【请填写功能名称】', 3, 'com.ruoyi.project.system.controller.PlatformMsgController.remove()', 'DELETE', 1, 'admins', NULL, '/system/msg/1661012682840670208', '127.0.0.1', '内网IP', '{ids=1661012682840670208}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 22:35:26');
INSERT INTO `sys_oper_log` VALUES (67, '【请填写功能名称】', 1, 'com.ruoyi.project.system.controller.PlatformMsgController.add()', 'POST', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"createUserId\":1,\"id\":1661745012744048640,\"message\":\"好主意！我喜欢吃辣的，川菜应该很合我口味。\",\"msg\":\"那我们点一份麻辣香锅吧，里面可以选不同的配料。\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 22:44:19');
INSERT INTO `sys_oper_log` VALUES (68, '【请填写功能名称】', 1, 'com.ruoyi.project.system.controller.PlatformMsgController.add()', 'POST', 1, 'admins', NULL, '/system/msg', '127.0.0.1', '内网IP', '{\"createUserId\":1,\"id\":1661745063100862464,\"message\":\"太棒了！我喜欢蔬菜和牛肉，你呢？\",\"msg\":\"我喜欢鸡肉和豆腐，我们可以点一些小龙虾吗？\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-05-25 22:44:31');

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
