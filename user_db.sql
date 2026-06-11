/*
 Navicat Premium Dump SQL

 Source Server         : MyProgram
 Source Server Type    : MySQL
 Source Server Version : 90200 (9.2.0)
 Source Host           : localhost:3306
 Source Schema         : user_db

 Target Server Type    : MySQL
 Target Server Version : 90200 (9.2.0)
 File Encoding         : 65001

 Date: 08/06/2026 21:08:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '管理员用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '管理员' COMMENT '昵称',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `last_login` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态：0禁用，1启用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '管理员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '管理员', 'admin@example.com', '1234221', '2025-05-27 00:42:35', 1, '2025-05-03 17:56:49', '2025-05-27 00:42:35');
INSERT INTO `admin` VALUES (2, '2624513422@qq.com', 'fcea920f7412b5da7be0cf42b8c93759', '管理员', '2624513422@qq.com', NULL, '2025-05-03 18:22:23', 1, '2025-05-03 18:22:14', '2025-05-03 18:22:23');
INSERT INTO `admin` VALUES (3, 'li70929522@163.com', '25d55ad283aa400af464c76d713c07ad', '管理员', 'li70929522@163.com', '1234221', '2025-05-26 23:31:22', 1, '2025-05-03 21:26:45', '2025-05-26 23:31:22');
INSERT INTO `admin` VALUES (4, '262451342211@qq.com', 'e10adc3949ba59abbe56e057f20f883e', '管理员', '262451342211@qq.com', NULL, '2025-05-29 16:00:12', 1, '2025-05-26 23:41:41', '2025-05-29 16:00:12');

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `comment_id` int NOT NULL AUTO_INCREMENT COMMENT '评论唯一ID',
  `phone` char(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `post_id` int NOT NULL COMMENT '关联帖子ID',
  `comment_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '评论内容',
  `comment_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间',
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `phone`(`phone` ASC) USING BTREE,
  INDEX `comments_ibfk_1`(`post_id` ASC) USING BTREE,
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `community` (`post_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`phone`) REFERENCES `users` (`phone`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comments_chk_2` CHECK (char_length(`comment_content`) <= 1000),
  CONSTRAINT `comments_chk_3` CHECK (regexp_like(`phone`,_utf8mb4'^[0-9]{1,12}$'))
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (1, '123', 19, '1234455', '2025-03-27 10:29:42');
INSERT INTO `comments` VALUES (2, '123', 19, '你好', '2025-03-27 10:29:53');
INSERT INTO `comments` VALUES (4, '123', 19, '撒大苏打撒大大', '2025-03-27 10:30:03');
INSERT INTO `comments` VALUES (5, '123', 19, '阿三大苏打萨达', '2025-03-27 10:30:04');
INSERT INTO `comments` VALUES (6, '123', 19, '撒大大撒顶顶顶顶顶', '2025-03-27 10:30:07');
INSERT INTO `comments` VALUES (7, '123', 19, '飒飒撒', '2025-03-27 10:30:10');
INSERT INTO `comments` VALUES (8, '123', 19, '飒飒撒', '2025-03-27 10:30:15');
INSERT INTO `comments` VALUES (9, '123', 21, '啊实打实的', '2025-03-27 10:30:52');
INSERT INTO `comments` VALUES (27, '123', 327, '你好呀', '2025-05-27 22:17:52');
INSERT INTO `comments` VALUES (28, '123', 327, '我是谁', '2025-05-28 16:57:35');
INSERT INTO `comments` VALUES (29, '123', 328, '你好呀', '2025-05-28 16:58:46');
INSERT INTO `comments` VALUES (30, '123', 329, '-（顺序是从后往前）  —  XIII.13 【「空梦」—帕朵菲莉丝 Pardofelis】  -  【帕朵菲莉丝】诞生自声名狼藉的黄昏街。  一纸合约，一场博弈，令她告别故土，踏上了逐火的旅路。身为十三英桀末席，其地位与实力同其余十二人有天壤之别（自称）。  -  曾经是秘密部', '2025-05-28 22:24:48');
INSERT INTO `comments` VALUES (31, '123', 329, 'XII.12 【「浮生」—华 Hua】  -  沉默少言的年轻战士。  彼时的少女青涩、迷茫，尚未预见自己明日多的命途。未来永劫，她如一羽雏鸟，失去了来时的道路，亦不知去路的方向。  -  【华】是序号CM-014的融合战士，超变因子实验第一个成功者，前文明纪元人类最强的八位战士', '2025-05-28 22:24:59');
INSERT INTO `comments` VALUES (32, '123', 329, 'XI.11 【「繁星」—格蕾修 Griseo】  -  【格蕾修】不爱言语，所思所想皆在画笔之下；格蕾修不问世事，心之所向尽在色彩之中。  一幅画卷，直成了格蕾修与她的世界。往日的色彩，于绘梦之中铺展，直至银河的尽头。  -  看上去非常文静，十分可爱。  是一名喜欢用画来画出自', '2025-05-28 22:25:12');
INSERT INTO `comments` VALUES (33, '123', 329, 'X.10 【「无限♾️」—梅比乌斯 Mobius】  -  正如那对深不见底的蛇瞳，「女孩」的真面目罕有人知。  那双眼睛见证了崩坏一次又一次降临。  在进化的路途上，为穷尽世间真理，她从不介意任何代价。  -  【梅比乌斯】是前文明纪元中穆大陆的著名学者，【灰蛇】的创造者，【梅', '2025-05-28 22:25:31');
INSERT INTO `comments` VALUES (34, '12345', 329, '太美丽了', '2025-05-28 22:26:35');
INSERT INTO `comments` VALUES (35, '12345', 329, '我也想要加入逐火之', '2025-05-28 22:27:29');

-- ----------------------------
-- Table structure for community
-- ----------------------------
DROP TABLE IF EXISTS `community`;
CREATE TABLE `community`  (
  `post_id` int NOT NULL AUTO_INCREMENT COMMENT '帖子唯一ID',
  `phone` char(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `post_topic` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '帖子主题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '帖子内容',
  `post_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `comment_count` int NULL DEFAULT 0 COMMENT '评论数',
  `like_count` int NULL DEFAULT 0 COMMENT '点赞数',
  `image_path` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '图片路径',
  PRIMARY KEY (`post_id`) USING BTREE,
  INDEX `phone`(`phone` ASC) USING BTREE,
  CONSTRAINT `community_ibfk_1` FOREIGN KEY (`phone`) REFERENCES `users` (`phone`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `community_chk_2` CHECK (char_length(`post_topic`) <= 20),
  CONSTRAINT `community_chk_3` CHECK (char_length(`content`) <= 1000),
  CONSTRAINT `community_chk_4` CHECK (`comment_count` >= 0),
  CONSTRAINT `community_chk_5` CHECK (`like_count` >= 0),
  CONSTRAINT `community_chk_6` CHECK (regexp_like(`phone`,_utf8mb4'^[0-9]{1,12}$'))
) ENGINE = InnoDB AUTO_INCREMENT = 330 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of community
-- ----------------------------
INSERT INTO `community` VALUES (1, '123', '1221', '12121', '2025-02-20 09:56:38', 0, 0, '');
INSERT INTO `community` VALUES (4, '123', '你是个好人', '对不起', '2025-02-20 12:02:28', 1, 1, '');
INSERT INTO `community` VALUES (18, '123', 'assaas', 'asasa', '2025-02-21 16:14:37', 0, 0, '');
INSERT INTO `community` VALUES (19, '123', 'asdasdasd', 'sdasdasdasd', '2025-03-27 10:30:15', 7, 1, '');
INSERT INTO `community` VALUES (21, '123', 'zsasasasa', 'saasasasasas', '2025-03-27 10:32:58', 2, 1, '');
INSERT INTO `community` VALUES (26, '12345', '我是米卫兵', '你试试', '2025-02-21 17:11:37', 0, 0, '');
INSERT INTO `community` VALUES (37, '123', 'wewes的撒旦', 'ewdssd得瑟得瑟s', '2025-03-02 20:33:15', 0, 0, '');
INSERT INTO `community` VALUES (39, '123', '啊实打实的', '撒大苏打', '2025-03-03 19:59:17', 0, 4, '');
INSERT INTO `community` VALUES (40, '123', '委屈问问去', '我去问问', '2025-03-03 19:58:37', 0, 2, '');
INSERT INTO `community` VALUES (41, '123', '胜多负少', '阿松大', '2025-04-14 23:03:17', 0, 0, '');
INSERT INTO `community` VALUES (42, '123', 'assassinated', '啊水水', '2025-04-18 15:57:06', 0, 1, 'http://tmp/37xM2LWWLOLe9980afed32f8444286d29164c917a0b5.png');
INSERT INTO `community` VALUES (43, '1231313', '健康小贴士第2条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-04-06 17:02:35', 0, 76, '');
INSERT INTO `community` VALUES (44, '1234556666', '健康小贴士第6条', '科学运动建议：合理饮水对运动表现至关重要', '2025-03-29 17:02:35', 0, 70, '');
INSERT INTO `community` VALUES (45, '12345', '健康小贴士第5条', '科学运动建议：合理饮水对运动表现至关重要', '2025-04-06 17:02:35', 0, 50, '');
INSERT INTO `community` VALUES (46, '123', '健康小贴士第1条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-04-12 17:02:35', 0, 95, '');
INSERT INTO `community` VALUES (47, '12344', '健康小贴士第4条', '科学运动建议：力量训练后需补充蛋白质', '2025-04-11 17:02:35', 0, 19, '');
INSERT INTO `community` VALUES (48, '123456', '健康小贴士第7条', '科学运动建议：力量训练后需补充蛋白质', '2025-03-30 17:02:35', 0, 58, '');
INSERT INTO `community` VALUES (49, '1234', '健康小贴士第3条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-03-24 17:02:35', 0, 99, '');
INSERT INTO `community` VALUES (50, '13800138000', '健康小贴士第9条', '科学运动建议：力量训练后需补充蛋白质', '2025-04-09 17:02:35', 0, 75, '');
INSERT INTO `community` VALUES (51, '13552', '健康小贴士第8条', '科学运动建议：每日30分钟有氧运动可提升心肺功能', '2025-03-22 17:02:35', 0, 9, '');
INSERT INTO `community` VALUES (58, '123456', '健康小贴士第7条', '科学运动建议：合理饮水对运动表现至关重要', '2025-03-21 17:02:56', 0, 18, '');
INSERT INTO `community` VALUES (59, '13552', '健康小贴士第8条', '科学运动建议：合理饮水对运动表现至关重要', '2025-03-30 17:02:56', 0, 32, '');
INSERT INTO `community` VALUES (60, '12345', '健康小贴士第5条', '科学运动建议：建议保持每周3次间歇训练', '2025-04-18 17:02:56', 0, 56, '');
INSERT INTO `community` VALUES (61, '12344', '健康小贴士第4条', '科学运动建议：力量训练后需补充蛋白质', '2025-03-20 17:02:56', 0, 83, '');
INSERT INTO `community` VALUES (62, '13800138000', '健康小贴士第9条', '科学运动建议：每日30分钟有氧运动可提升心肺功能', '2025-03-28 17:02:56', 0, 31, '');
INSERT INTO `community` VALUES (63, '1234556666', '健康小贴士第6条', '科学运动建议：合理饮水对运动表现至关重要', '2025-03-31 17:02:56', 0, 18, '');
INSERT INTO `community` VALUES (64, '123', '健康小贴士第1条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-03-28 17:02:56', 0, 79, '');
INSERT INTO `community` VALUES (65, '1231313', '健康小贴士第2条', '科学运动建议：建议保持每周3次间歇训练', '2025-04-06 17:02:56', 0, 43, '');
INSERT INTO `community` VALUES (66, '1234', '健康小贴士第3条', '科学运动建议：力量训练后需补充蛋白质', '2025-03-28 17:02:56', 0, 68, '');
INSERT INTO `community` VALUES (73, '1234', '健康小贴士第3条', '科学运动建议：每日30分钟有氧运动可提升心肺功能', '2025-04-03 17:02:56', 0, 24, '');
INSERT INTO `community` VALUES (74, '123', '健康小贴士第1条', '科学运动建议：合理饮水对运动表现至关重要', '2025-04-11 17:02:56', 0, 71, '');
INSERT INTO `community` VALUES (75, '12345', '健康小贴士第5条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-03-30 17:02:56', 0, 94, '');
INSERT INTO `community` VALUES (76, '13552', '健康小贴士第8条', '科学运动建议：力量训练后需补充蛋白质', '2025-03-24 17:02:56', 0, 10, '');
INSERT INTO `community` VALUES (77, '12344', '健康小贴士第4条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-04-03 17:02:56', 0, 37, '');
INSERT INTO `community` VALUES (78, '1234556666', '健康小贴士第6条', '科学运动建议：每日30分钟有氧运动可提升心肺功能', '2025-04-17 17:02:56', 0, 100, '');
INSERT INTO `community` VALUES (79, '1231313', '健康小贴士第2条', '科学运动建议：合理饮水对运动表现至关重要', '2025-03-30 17:02:56', 0, 86, '');
INSERT INTO `community` VALUES (80, '123456', '健康小贴士第7条', '科学运动建议：力量训练后需补充蛋白质', '2025-03-22 17:02:56', 0, 68, '');
INSERT INTO `community` VALUES (81, '13800138000', '健康小贴士第9条', '科学运动建议：建议保持每周3次间歇训练', '2025-03-29 17:02:56', 0, 92, '');
INSERT INTO `community` VALUES (88, '12345', '健康小贴士第5条', '科学运动建议：力量训练后需补充蛋白质', '2025-04-01 17:02:56', 0, 28, '');
INSERT INTO `community` VALUES (89, '13800138000', '健康小贴士第9条', '科学运动建议：力量训练后需补充蛋白质', '2025-03-26 17:02:56', 0, 94, '');
INSERT INTO `community` VALUES (90, '123456', '健康小贴士第7条', '科学运动建议：力量训练后需补充蛋白质', '2025-04-10 17:02:56', 0, 52, '');
INSERT INTO `community` VALUES (91, '12344', '健康小贴士第4条', '科学运动建议：建议保持每周3次间歇训练', '2025-04-02 17:02:56', 0, 57, '');
INSERT INTO `community` VALUES (92, '123', '健康小贴士第1条', '科学运动建议：合理饮水对运动表现至关重要', '2025-04-14 17:02:56', 0, 86, '');
INSERT INTO `community` VALUES (93, '1234556666', '健康小贴士第6条', '科学运动建议：力量训练后需补充蛋白质', '2025-04-04 17:02:56', 0, 56, '');
INSERT INTO `community` VALUES (94, '1234', '健康小贴士第3条', '科学运动建议：每日30分钟有氧运动可提升心肺功能', '2025-04-12 17:02:56', 0, 3, '');
INSERT INTO `community` VALUES (95, '13552', '健康小贴士第8条', '科学运动建议：力量训练后需补充蛋白质', '2025-03-21 17:02:56', 0, 2, '');
INSERT INTO `community` VALUES (96, '1231313', '健康小贴士第2条', '科学运动建议：合理饮水对运动表现至关重要', '2025-03-29 17:02:56', 0, 72, '');
INSERT INTO `community` VALUES (103, '1231313', '健康小贴士第2条', '科学运动建议：建议保持每周3次间歇训练', '2025-03-25 17:02:57', 0, 36, '');
INSERT INTO `community` VALUES (104, '1234', '健康小贴士第3条', '科学运动建议：建议保持每周3次间歇训练', '2025-04-01 17:02:57', 0, 45, '');
INSERT INTO `community` VALUES (105, '123', '健康小贴士第1条', '科学运动建议：每日30分钟有氧运动可提升心肺功能', '2025-03-22 17:02:57', 0, 55, '');
INSERT INTO `community` VALUES (106, '123456', '健康小贴士第7条', '科学运动建议：建议保持每周3次间歇训练', '2025-04-05 17:02:57', 0, 63, '');
INSERT INTO `community` VALUES (107, '12344', '健康小贴士第4条', '科学运动建议：合理饮水对运动表现至关重要', '2025-04-01 17:02:57', 0, 85, '');
INSERT INTO `community` VALUES (108, '13800138000', '健康小贴士第9条', '科学运动建议：合理饮水对运动表现至关重要', '2025-04-08 17:02:57', 0, 75, '');
INSERT INTO `community` VALUES (109, '12345', '健康小贴士第5条', '科学运动建议：力量训练后需补充蛋白质', '2025-03-31 17:02:57', 0, 34, '');
INSERT INTO `community` VALUES (110, '1234556666', '健康小贴士第6条', '科学运动建议：每日30分钟有氧运动可提升心肺功能', '2025-04-11 17:02:57', 0, 83, '');
INSERT INTO `community` VALUES (111, '13552', '健康小贴士第8条', '科学运动建议：力量训练后需补充蛋白质', '2025-04-15 17:02:57', 0, 57, '');
INSERT INTO `community` VALUES (118, '123456', '健康小贴士第7条', '科学运动建议：建议保持每周3次间歇训练', '2025-04-09 17:02:57', 0, 8, '');
INSERT INTO `community` VALUES (119, '12344', '健康小贴士第4条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-03-31 17:02:57', 0, 86, '');
INSERT INTO `community` VALUES (120, '1234556666', '健康小贴士第6条', '科学运动建议：力量训练后需补充蛋白质', '2025-04-07 17:02:57', 0, 24, '');
INSERT INTO `community` VALUES (121, '12345', '健康小贴士第5条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-03-24 17:02:57', 0, 36, '');
INSERT INTO `community` VALUES (122, '1231313', '健康小贴士第2条', '科学运动建议：建议保持每周3次间歇训练', '2025-04-04 17:02:57', 0, 63, '');
INSERT INTO `community` VALUES (123, '13552', '健康小贴士第8条', '科学运动建议：力量训练后需补充蛋白质', '2025-04-01 17:02:57', 0, 28, '');
INSERT INTO `community` VALUES (124, '13800138000', '健康小贴士第9条', '科学运动建议：建议保持每周3次间歇训练', '2025-04-14 17:02:57', 0, 52, '');
INSERT INTO `community` VALUES (125, '123', '健康小贴士第1条', '科学运动建议：力量训练后需补充蛋白质', '2025-04-03 17:02:57', 0, 61, '');
INSERT INTO `community` VALUES (126, '1234', '健康小贴士第3条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-04-07 17:02:57', 0, 85, '');
INSERT INTO `community` VALUES (133, '1231313', '健康小贴士第2条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-04-03 17:02:57', 0, 19, '');
INSERT INTO `community` VALUES (134, '123', '健康小贴士第1条', '科学运动建议：力量训练后需补充蛋白质', '2025-03-30 17:02:57', 0, 62, '');
INSERT INTO `community` VALUES (135, '12344', '健康小贴士第4条', '科学运动建议：每日30分钟有氧运动可提升心肺功能', '2025-04-12 17:02:57', 0, 65, '');
INSERT INTO `community` VALUES (136, '1234556666', '健康小贴士第6条', '科学运动建议：合理饮水对运动表现至关重要', '2025-04-05 17:02:57', 0, 19, '');
INSERT INTO `community` VALUES (137, '1234', '健康小贴士第3条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-03-22 17:02:57', 0, 57, '');
INSERT INTO `community` VALUES (138, '13800138000', '健康小贴士第9条', '科学运动建议：建议保持每周3次间歇训练', '2025-03-25 17:02:57', 0, 72, '');
INSERT INTO `community` VALUES (139, '12345', '健康小贴士第5条', '科学运动建议：每日30分钟有氧运动可提升心肺功能', '2025-03-23 17:02:57', 0, 96, '');
INSERT INTO `community` VALUES (140, '123456', '健康小贴士第7条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-04-01 17:02:57', 0, 71, '');
INSERT INTO `community` VALUES (141, '13552', '健康小贴士第8条', '科学运动建议：每日30分钟有氧运动可提升心肺功能', '2025-04-07 17:02:57', 0, 32, '');
INSERT INTO `community` VALUES (148, '1231313', '健康小贴士第2条', '科学运动建议：建议保持每周3次间歇训练', '2025-04-13 17:02:57', 0, 52, '');
INSERT INTO `community` VALUES (149, '1234', '健康小贴士第3条', '科学运动建议：合理饮水对运动表现至关重要', '2025-03-26 17:02:57', 0, 51, '');
INSERT INTO `community` VALUES (150, '13800138000', '健康小贴士第9条', '科学运动建议：力量训练后需补充蛋白质', '2025-04-17 17:02:57', 0, 39, '');
INSERT INTO `community` VALUES (152, '13552', '健康小贴士第8条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-03-29 17:02:57', 0, 43, '');
INSERT INTO `community` VALUES (153, '12344', '健康小贴士第4条', '科学运动建议：建议保持每周3次间歇训练', '2025-04-14 17:02:57', 0, 4, '');
INSERT INTO `community` VALUES (154, '12345', '健康小贴士第5条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-04-01 17:02:57', 0, 53, '');
INSERT INTO `community` VALUES (155, '123456', '健康小贴士第7条', '科学运动建议：力量训练后需补充蛋白质', '2025-03-25 17:02:57', 0, 13, '');
INSERT INTO `community` VALUES (156, '1234556666', '健康小贴士第6条', '科学运动建议：每日30分钟有氧运动可提升心肺功能', '2025-03-27 17:02:57', 0, 44, '');
INSERT INTO `community` VALUES (163, '1234', '健康小贴士第3条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-03-31 17:02:57', 0, 14, '');
INSERT INTO `community` VALUES (164, '1234556666', '健康小贴士第6条', '科学运动建议：每日30分钟有氧运动可提升心肺功能', '2025-03-20 17:02:57', 0, 51, '');
INSERT INTO `community` VALUES (165, '13800138000', '健康小贴士第9条', '科学运动建议：力量训练后需补充蛋白质', '2025-03-20 17:02:57', 0, 92, '');
INSERT INTO `community` VALUES (166, '13552', '健康小贴士第8条', '科学运动建议：力量训练后需补充蛋白质', '2025-04-10 17:02:57', 0, 62, '');
INSERT INTO `community` VALUES (167, '1231313', '健康小贴士第2条', '科学运动建议：每日30分钟有氧运动可提升心肺功能', '2025-04-13 17:02:57', 0, 74, '');
INSERT INTO `community` VALUES (168, '12345', '健康小贴士第5条', '科学运动建议：力量训练后需补充蛋白质', '2025-03-21 17:02:57', 0, 2, '');
INSERT INTO `community` VALUES (169, '123456', '健康小贴士第7条', '科学运动建议：建议保持每周3次间歇训练', '2025-04-03 17:02:57', 0, 18, '');
INSERT INTO `community` VALUES (170, '123', '健康小贴士第1条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-04-05 17:02:57', 0, 94, '');
INSERT INTO `community` VALUES (171, '12344', '健康小贴士第4条', '科学运动建议：力量训练后需补充蛋白质', '2025-04-11 17:02:57', 0, 63, '');
INSERT INTO `community` VALUES (178, '1234556666', '健康小贴士第6条', '科学运动建议：合理饮水对运动表现至关重要', '2025-03-31 17:02:58', 0, 22, '');
INSERT INTO `community` VALUES (179, '1234', '健康小贴士第3条', '科学运动建议：合理饮水对运动表现至关重要', '2025-04-08 17:02:58', 0, 32, '');
INSERT INTO `community` VALUES (180, '123456', '健康小贴士第7条', '科学运动建议：合理饮水对运动表现至关重要', '2025-04-02 17:02:58', 0, 8, '');
INSERT INTO `community` VALUES (181, '12345', '健康小贴士第5条', '科学运动建议：力量训练后需补充蛋白质', '2025-04-06 17:02:58', 0, 4, '');
INSERT INTO `community` VALUES (182, '1231313', '健康小贴士第2条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-03-25 17:02:58', 0, 14, '');
INSERT INTO `community` VALUES (183, '12344', '健康小贴士第4条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-04-13 17:02:58', 0, 58, '');
INSERT INTO `community` VALUES (184, '13800138000', '健康小贴士第9条', '科学运动建议：力量训练后需补充蛋白质', '2025-04-15 17:02:58', 0, 93, '');
INSERT INTO `community` VALUES (185, '123', '健康小贴士第1条', '科学运动建议：建议保持每周3次间歇训练', '2025-03-28 17:02:58', 0, 92, '');
INSERT INTO `community` VALUES (186, '13552', '健康小贴士第8条', '科学运动建议：建议保持每周3次间歇训练', '2025-04-12 17:02:58', 0, 66, '');
INSERT INTO `community` VALUES (193, '13552', '健康小贴士第8条', '科学运动建议：每日30分钟有氧运动可提升心肺功能', '2025-03-31 17:02:58', 0, 4, '');
INSERT INTO `community` VALUES (194, '123', '健康小贴士第1条', '科学运动建议：合理饮水对运动表现至关重要', '2025-04-03 17:02:58', 0, 88, '');
INSERT INTO `community` VALUES (195, '13800138000', '健康小贴士第9条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-04-08 17:02:58', 0, 67, '');
INSERT INTO `community` VALUES (196, '123456', '健康小贴士第7条', '科学运动建议：每日30分钟有氧运动可提升心肺功能', '2025-03-25 17:02:58', 0, 91, '');
INSERT INTO `community` VALUES (198, '1234556666', '健康小贴士第6条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-03-22 17:02:58', 0, 43, '');
INSERT INTO `community` VALUES (199, '1231313', '健康小贴士第2条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-04-05 17:02:58', 0, 46, '');
INSERT INTO `community` VALUES (200, '12345', '健康小贴士第5条', '科学运动建议：合理饮水对运动表现至关重要', '2025-04-04 17:02:58', 0, 85, '');
INSERT INTO `community` VALUES (201, '1234', '健康小贴士第3条', '科学运动建议：建议保持每周3次间歇训练', '2025-04-15 17:02:58', 0, 43, '');
INSERT INTO `community` VALUES (208, '1234556666', '健康小贴士第6条', '科学运动建议：每日30分钟有氧运动可提升心肺功能', '2025-03-31 17:02:58', 0, 63, '');
INSERT INTO `community` VALUES (209, '12345', '健康小贴士第5条', '科学运动建议：力量训练后需补充蛋白质', '2025-04-11 17:02:58', 0, 36, '');
INSERT INTO `community` VALUES (210, '123456', '健康小贴士第7条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-04-14 17:02:58', 0, 96, '');
INSERT INTO `community` VALUES (211, '123', '健康小贴士第1条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-04-08 17:02:58', 0, 77, '');
INSERT INTO `community` VALUES (212, '13552', '健康小贴士第8条', '科学运动建议：合理饮水对运动表现至关重要', '2025-04-09 17:02:58', 0, 93, '');
INSERT INTO `community` VALUES (213, '1234', '健康小贴士第3条', '科学运动建议：力量训练后需补充蛋白质', '2025-03-24 17:02:58', 0, 8, '');
INSERT INTO `community` VALUES (215, '1231313', '健康小贴士第2条', '科学运动建议：运动前后充分拉伸预防损伤', '2025-03-25 17:02:58', 0, 16, '');
INSERT INTO `community` VALUES (216, '12344', '健康小贴士第4条', '科学运动建议：每日30分钟有氧运动可提升心肺功能', '2025-03-21 17:02:58', 0, 38, '');
INSERT INTO `community` VALUES (217, '123', '飒飒撒', '啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊', '2025-04-26 16:03:26', 0, 0, 'http://tmp/XaL2SuErcryxcddb301ae0c5f38f98d05864ca179fdb.png');
INSERT INTO `community` VALUES (218, '123', '你好', '我是奶龙', '2025-04-26 18:00:45', 0, 1, 'wxfile://tmp_3fee82ed731cc7f486fa329827212e2c4435c6e120fea035.jpg');
INSERT INTO `community` VALUES (224, '12314141', '主题-2', '帖子内容详情-06874c7e-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 6, 91, '');
INSERT INTO `community` VALUES (225, '1000000075', '主题-1', '帖子内容详情-0687b0c2-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 1, 55, '');
INSERT INTO `community` VALUES (226, '1000000097', '主题-7', '帖子内容详情-068818a6-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 1, 6, '');
INSERT INTO `community` VALUES (228, '1000000047', '主题-9', '帖子内容详情-0688c511-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 3, 12, '');
INSERT INTO `community` VALUES (229, '1000000016', '主题-3', '帖子内容详情-06893481-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 3, 8, '');
INSERT INTO `community` VALUES (230, '1000000054', '主题-10', '帖子内容详情-06898bff-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 6, 33, '');
INSERT INTO `community` VALUES (231, '1000000002', '主题-8', '帖子内容详情-0689db6b-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 6, 19, '');
INSERT INTO `community` VALUES (232, '1000000096', '主题-7', '帖子内容详情-068a3558-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 3, 90, '');
INSERT INTO `community` VALUES (233, '1000000043', '主题-7', '帖子内容详情-068a8889-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 9, 15, '');
INSERT INTO `community` VALUES (234, '1000000023', '主题-4', '帖子内容详情-068ae720-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 7, 51, '');
INSERT INTO `community` VALUES (235, '1000000070', '主题-3', '帖子内容详情-068b50cb-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 9, 32, '');
INSERT INTO `community` VALUES (236, '1000000020', '主题-8', '帖子内容详情-068ba457-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 7, 65, '');
INSERT INTO `community` VALUES (237, '1000000036', '主题-8', '帖子内容详情-068bfcd9-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 7, 46, '');
INSERT INTO `community` VALUES (238, '1000000036', '主题-1', '帖子内容详情-068c59e3-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 0, 24, '');
INSERT INTO `community` VALUES (239, '1000000058', '主题-1', '帖子内容详情-068cb546-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 1, 46, '');
INSERT INTO `community` VALUES (240, '1000000028', '主题-5', '帖子内容详情-068d1f88-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 2, 71, '');
INSERT INTO `community` VALUES (241, '1000000085', '主题-8', '帖子内容详情-068d8183-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 8, 14, '');
INSERT INTO `community` VALUES (242, '1000000021', '主题-3', '帖子内容详情-068deb84-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 2, 60, '');
INSERT INTO `community` VALUES (243, '1000000064', '主题-7', '帖子内容详情-068e4b90-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 0, 30, '');
INSERT INTO `community` VALUES (244, '1000000031', '主题-5', '帖子内容详情-068ea5f2-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 3, 31, '');
INSERT INTO `community` VALUES (245, '1000000052', '主题-6', '帖子内容详情-068f0080-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 6, 80, '');
INSERT INTO `community` VALUES (246, '1000000020', '主题-10', '帖子内容详情-068f5fad-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 7, 86, '');
INSERT INTO `community` VALUES (247, '1000000019', '主题-9', '帖子内容详情-068fbf3f-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 2, 51, '');
INSERT INTO `community` VALUES (248, '1000000099', '主题-3', '帖子内容详情-06902436-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 4, 57, '');
INSERT INTO `community` VALUES (249, '1000000011', '主题-1', '帖子内容详情-0690756a-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 0, 19, '');
INSERT INTO `community` VALUES (250, '1000000088', '主题-10', '帖子内容详情-0690cfc4-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 6, 58, '');
INSERT INTO `community` VALUES (251, '1000000044', '主题-1', '帖子内容详情-0691215e-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 1, 53, '');
INSERT INTO `community` VALUES (252, '1000000043', '主题-9', '帖子内容详情-0691761e-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 0, 81, '');
INSERT INTO `community` VALUES (253, '1000000024', '主题-4', '帖子内容详情-0691c893-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 5, 97, '');
INSERT INTO `community` VALUES (254, '1000000066', '主题-3', '帖子内容详情-069222ce-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 0, 42, '');
INSERT INTO `community` VALUES (255, '1000000059', '主题-1', '帖子内容详情-0692784c-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 1, 53, '');
INSERT INTO `community` VALUES (256, '1000000031', '主题-9', '帖子内容详情-0692ca0f-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 2, 67, '');
INSERT INTO `community` VALUES (257, '1000000023', '主题-3', '帖子内容详情-06932019-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 1, 22, '');
INSERT INTO `community` VALUES (258, '1000000055', '主题-4', '帖子内容详情-06937497-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 5, 97, '');
INSERT INTO `community` VALUES (259, '1000000069', '主题-4', '帖子内容详情-0693c746-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 6, 11, '');
INSERT INTO `community` VALUES (260, '1000000093', '主题-5', '帖子内容详情-06942435-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 4, 61, '');
INSERT INTO `community` VALUES (261, '1000000093', '主题-10', '帖子内容详情-06948597-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 8, 24, '');
INSERT INTO `community` VALUES (262, '1000000070', '主题-6', '帖子内容详情-0694e376-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 6, 49, '');
INSERT INTO `community` VALUES (263, '1000000086', '主题-6', '帖子内容详情-069539f8-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 5, 8, '');
INSERT INTO `community` VALUES (264, '1000000049', '主题-5', '帖子内容详情-06958b63-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 1, 30, '');
INSERT INTO `community` VALUES (265, '1000000005', '主题-3', '帖子内容详情-0695daf3-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 3, 8, '');
INSERT INTO `community` VALUES (266, '1000000047', '主题-8', '帖子内容详情-06962fef-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 9, 27, '');
INSERT INTO `community` VALUES (267, '1000000063', '主题-10', '帖子内容详情-06968f7c-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 6, 30, '');
INSERT INTO `community` VALUES (268, '1000000030', '主题-8', '帖子内容详情-0696e214-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 9, 17, '');
INSERT INTO `community` VALUES (269, '1000000056', '主题-4', '帖子内容详情-06973af2-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 8, 99, '');
INSERT INTO `community` VALUES (270, '132425', '主题-8', '帖子内容详情-0697a705-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 4, 16, '');
INSERT INTO `community` VALUES (271, '1000000042', '主题-8', '帖子内容详情-0697f5ad-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 8, 0, '');
INSERT INTO `community` VALUES (272, '1000000044', '主题-6', '帖子内容详情-06985954-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 7, 97, '');
INSERT INTO `community` VALUES (273, '1000000022', '主题-1', '帖子内容详情-0698a9fe-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 0, 25, '');
INSERT INTO `community` VALUES (274, '1000000087', '主题-8', '帖子内容详情-069906f4-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 4, 35, '');
INSERT INTO `community` VALUES (275, '1000000092', '主题-10', '帖子内容详情-069958e6-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 7, 8, '');
INSERT INTO `community` VALUES (276, '1234', '主题-2', '帖子内容详情-0699aec2-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 6, 98, '');
INSERT INTO `community` VALUES (277, '1000000084', '主题-9', '帖子内容详情-069a02b6-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 0, 90, '');
INSERT INTO `community` VALUES (278, '1000000027', '主题-1', '帖子内容详情-069a503d-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 4, 91, '');
INSERT INTO `community` VALUES (279, '1000000026', '主题-1', '帖子内容详情-069aa274-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 1, 50, '');
INSERT INTO `community` VALUES (281, '1000000005', '主题-6', '帖子内容详情-069b4a87-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 9, 82, '');
INSERT INTO `community` VALUES (282, '1000000100', '主题-8', '帖子内容详情-069ba559-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 4, 33, '');
INSERT INTO `community` VALUES (283, '1000000097', '主题-4', '帖子内容详情-069bf691-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 8, 22, '');
INSERT INTO `community` VALUES (284, '123141', '主题-7', '帖子内容详情-069c48ae-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 0, 54, '');
INSERT INTO `community` VALUES (285, '1000000100', '主题-10', '帖子内容详情-069c99ea-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 5, 87, '');
INSERT INTO `community` VALUES (286, '1000000048', '主题-5', '帖子内容详情-069ce7d8-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 2, 91, '');
INSERT INTO `community` VALUES (287, '1000000082', '主题-10', '帖子内容详情-069d3f1c-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 8, 44, '');
INSERT INTO `community` VALUES (288, '1000000001', '主题-3', '帖子内容详情-069d8c48-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 9, 25, '');
INSERT INTO `community` VALUES (289, '12314141', '主题-1', '帖子内容详情-069de8a1-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 2, 12, '');
INSERT INTO `community` VALUES (290, '1000000017', '主题-9', '帖子内容详情-069e343e-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 3, 34, '');
INSERT INTO `community` VALUES (291, '1000000086', '主题-8', '帖子内容详情-069e8c40-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 6, 84, '');
INSERT INTO `community` VALUES (292, '1000000036', '主题-10', '帖子内容详情-069ed9bc-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 7, 96, '');
INSERT INTO `community` VALUES (293, '1000000060', '主题-7', '帖子内容详情-069f357a-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 1, 69, '');
INSERT INTO `community` VALUES (294, '132425', '主题-7', '帖子内容详情-069f8d0e-2b09-11f0-ad0a-00e04c8b891e', '2025-05-06 14:03:41', 3, 87, '');
INSERT INTO `community` VALUES (295, '1000000016', '主题-9', '帖子内容详情-069fd9c5-2b09-11f0-ad0a-00e04c8b891e', '2025-05-06 14:03:41', 4, 64, '');
INSERT INTO `community` VALUES (296, '1000000043', '主题-5', '帖子内容详情-06a030f6-2b09-11f0-ad0a-00e04c8b891e', '2025-05-06 14:03:41', 5, 20, '');
INSERT INTO `community` VALUES (297, '1000000024', '主题-4', '帖子内容详情-06a07f33-2b09-11f0-ad0a-00e04c8b891e', '2025-05-01 14:03:41', 6, 38, '');
INSERT INTO `community` VALUES (298, '1000000098', '主题-6', '帖子内容详情-06a0d895-2b09-11f0-ad0a-00e04c8b891e', '2025-05-02 14:03:41', 0, 97, '');
INSERT INTO `community` VALUES (299, '1000000087', '主题-10', '帖子内容详情-06a12afa-2b09-11f0-ad0a-00e04c8b891e', '2025-05-02 14:03:41', 9, 25, '');
INSERT INTO `community` VALUES (300, '1000000018', '主题-1', '帖子内容详情-06a17967-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 0, 12, '');
INSERT INTO `community` VALUES (301, '123141', '主题-6', '帖子内容详情-06a1d62a-2b09-11f0-ad0a-00e04c8b891e', '2025-05-04 14:03:41', 0, 91, '');
INSERT INTO `community` VALUES (302, '1000000019', '主题-4', '帖子内容详情-06a23aa1-2b09-11f0-ad0a-00e04c8b891e', '2025-05-01 14:03:41', 4, 53, '');
INSERT INTO `community` VALUES (303, '1000000056', '主题-7', '帖子内容详情-06a29296-2b09-11f0-ad0a-00e04c8b891e', '2025-05-06 14:03:41', 9, 13, '');
INSERT INTO `community` VALUES (305, '1000000003', '主题-9', '帖子内容详情-06a332b8-2b09-11f0-ad0a-00e04c8b891e', '2025-05-01 14:03:41', 5, 80, '');
INSERT INTO `community` VALUES (306, '1000000021', '主题-6', '帖子内容详情-06a389c2-2b09-11f0-ad0a-00e04c8b891e', '2025-05-03 14:03:41', 4, 25, '');
INSERT INTO `community` VALUES (307, '1000000005', '主题-3', '帖子内容详情-06a3dc23-2b09-11f0-ad0a-00e04c8b891e', '2025-05-06 14:03:41', 3, 99, '');
INSERT INTO `community` VALUES (308, '1000000022', '主题-10', '帖子内容详情-06a43085-2b09-11f0-ad0a-00e04c8b891e', '2025-05-02 14:03:41', 1, 40, '');
INSERT INTO `community` VALUES (310, '1000000056', '主题-8', '帖子内容详情-06a4db75-2b09-11f0-ad0a-00e04c8b891e', '2025-05-02 14:03:41', 3, 63, '');
INSERT INTO `community` VALUES (311, '1000000021', '主题-10', '帖子内容详情-06a52b13-2b09-11f0-ad0a-00e04c8b891e', '2025-05-04 14:03:41', 0, 48, '');
INSERT INTO `community` VALUES (312, '1000000017', '主题-9', '帖子内容详情-06a57d68-2b09-11f0-ad0a-00e04c8b891e', '2025-05-07 14:03:41', 6, 30, '');
INSERT INTO `community` VALUES (313, '1000000099', '主题-3', '帖子内容详情-06a5d92a-2b09-11f0-ad0a-00e04c8b891e', '2025-05-04 14:03:41', 3, 26, '');
INSERT INTO `community` VALUES (314, '1000000050', '主题-6', '帖子内容详情-06a625dc-2b09-11f0-ad0a-00e04c8b891e', '2025-05-04 14:03:41', 1, 6, '');
INSERT INTO `community` VALUES (315, '1000000091', '主题-10', '帖子内容详情-06a677ed-2b09-11f0-ad0a-00e04c8b891e', '2025-05-03 14:03:41', 1, 91, '');
INSERT INTO `community` VALUES (316, '1000000073', '主题-6', '帖子内容详情-06a6c8b6-2b09-11f0-ad0a-00e04c8b891e', '2025-05-03 14:03:41', 9, 52, '');
INSERT INTO `community` VALUES (317, '1000000001', '主题-2', '帖子内容详情-06a71478-2b09-11f0-ad0a-00e04c8b891e', '2025-05-02 14:03:41', 3, 59, '');
INSERT INTO `community` VALUES (318, '1000000075', '主题-8', '帖子内容详情-06a76d5e-2b09-11f0-ad0a-00e04c8b891e', '2025-05-03 14:03:41', 8, 28, '');
INSERT INTO `community` VALUES (319, '1000000070', '主题-10', '帖子内容详情-06a7c01f-2b09-11f0-ad0a-00e04c8b891e', '2025-05-04 14:03:41', 8, 72, '');
INSERT INTO `community` VALUES (320, '1000000085', '主题-9', '帖子内容详情-06a812e0-2b09-11f0-ad0a-00e04c8b891e', '2025-05-05 14:03:41', 3, 68, '');
INSERT INTO `community` VALUES (321, '1000000063', '主题-4', '帖子内容详情-06a86370-2b09-11f0-ad0a-00e04c8b891e', '2025-05-02 14:03:41', 6, 20, '');
INSERT INTO `community` VALUES (322, '1000000022', '主题-10', '帖子内容详情-06a8b1a1-2b09-11f0-ad0a-00e04c8b891e', '2025-05-04 14:03:41', 8, 77, '');
INSERT INTO `community` VALUES (323, '1000000071', '主题-5', '帖子内容详情-06a9180e-2b09-11f0-ad0a-00e04c8b891e', '2025-05-04 14:03:41', 7, 62, '');
INSERT INTO `community` VALUES (325, '123', '说到底是谁的', '所发生的', '2025-05-26 09:28:29', 1, 1, 'http://tmp/chDMY1ThAztoc7f4ab7eb68162f91f83dec50b0c7933.png');
INSERT INTO `community` VALUES (327, '123', '猜猜我是谁', '我是猛虎王', '2025-05-27 14:17:42', 2, 1, 'http://tmp/8CJksmpGeYGTc7f4ab7eb68162f91f83dec50b0c7933.png');
INSERT INTO `community` VALUES (328, '123', '哈基米', '哈基米叮咚鸡，曼波', '2025-05-28 08:58:39', 1, 1, 'wxfile://tmp_3049757ebd60579029deef27e8e8b762f0472fde95d0c941.jpg');
INSERT INTO `community` VALUES (329, '123', '【壁纸】★逐火十三英桀★', '【逐火之蛾】，《崩坏3》世界中的前文明纪元人类联合国为了对抗崩坏创立的组织，人类最大的抗崩坏组织。\n「逐火十三英桀」—\n【逐火之蛾】在对【第十一律者】的进行讨伐，也就是“约束的惨剧” 后，【逐火之蛾】仅存剩的13位融合战士的统称。\n他们是不可替代的重要资产，因此**的编制有其必要', '2025-05-29 14:24:22', 6, 2, 'http://tmp/mulwUJRzYNax40d846f4fad913df81cbd0e16e65f1f7.png');

-- ----------------------------
-- Table structure for foods
-- ----------------------------
DROP TABLE IF EXISTS `foods`;
CREATE TABLE `foods`  (
  `food_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '食物名称',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '食物类别',
  `calorie_per_100g` int UNSIGNED NOT NULL COMMENT '千卡/100克',
  PRIMARY KEY (`food_id`) USING BTREE,
  INDEX `idx_category`(`category` ASC) USING BTREE,
  FULLTEXT INDEX `idx_name`(`name`)
) ENGINE = InnoDB AUTO_INCREMENT = 381 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of foods
-- ----------------------------
INSERT INTO `foods` VALUES (1, '白米饭', '主食', 116);
INSERT INTO `foods` VALUES (2, '全麦面包', '主食', 265);
INSERT INTO `foods` VALUES (3, '兰州拉面', '面食', 280);
INSERT INTO `foods` VALUES (4, '重庆小面', '面食', 330);
INSERT INTO `foods` VALUES (5, '鲜肉包', '中式点心', 250);
INSERT INTO `foods` VALUES (6, '虾饺', '粤式点心', 120);
INSERT INTO `foods` VALUES (7, '麻婆豆腐', '川菜', 150);
INSERT INTO `foods` VALUES (8, '宫保鸡丁', '川菜', 220);
INSERT INTO `foods` VALUES (9, '北京烤鸭', '京菜', 337);
INSERT INTO `foods` VALUES (10, '广式叉烧', '粤菜', 280);
INSERT INTO `foods` VALUES (11, '寿司', '日式料理', 150);
INSERT INTO `foods` VALUES (12, '泡菜', '韩式料理', 30);
INSERT INTO `foods` VALUES (13, '冬阴功汤', '东南亚菜', 90);
INSERT INTO `foods` VALUES (14, '芒果糯米饭', '泰式主食', 250);
INSERT INTO `foods` VALUES (15, '番茄炒蛋', '家常菜', 90);
INSERT INTO `foods` VALUES (16, '红烧肉', '家常菜', 387);
INSERT INTO `foods` VALUES (17, '清蒸鲈鱼', '海鲜', 130);
INSERT INTO `foods` VALUES (18, '水煮牛肉', '川菜', 240);
INSERT INTO `foods` VALUES (19, '凉拌黄瓜', '凉菜', 16);
INSERT INTO `foods` VALUES (20, '皮蛋瘦肉粥', '粥类', 70);
INSERT INTO `foods` VALUES (21, '油条', '早餐', 388);
INSERT INTO `foods` VALUES (22, '阳春面', '面食', 180);
INSERT INTO `foods` VALUES (23, '螺蛳粉', '粉类', 350);
INSERT INTO `foods` VALUES (24, '麻辣烫', '小吃', 200);
INSERT INTO `foods` VALUES (25, '椰子鸡火锅', '火锅', 180);
INSERT INTO `foods` VALUES (26, '榴莲', '水果', 147);
INSERT INTO `foods` VALUES (27, '荔枝', '水果', 66);
INSERT INTO `foods` VALUES (28, '龙眼', '水果', 60);
INSERT INTO `foods` VALUES (29, '大白菜', '蔬菜', 13);
INSERT INTO `foods` VALUES (30, '西兰花', '蔬菜', 34);
INSERT INTO `foods` VALUES (31, '东坡肉', '浙菜', 470);
INSERT INTO `foods` VALUES (32, '佛跳墙', '闽菜', 280);
INSERT INTO `foods` VALUES (33, '热干面', '鄂菜', 256);
INSERT INTO `foods` VALUES (34, '刀削面', '面食', 220);
INSERT INTO `foods` VALUES (35, '河南烩面', '面食', 320);
INSERT INTO `foods` VALUES (36, '绍兴醉鸡', '浙菜', 180);
INSERT INTO `foods` VALUES (37, '客家酿豆腐', '粤菜', 150);
INSERT INTO `foods` VALUES (38, '云南过桥米线', '米粉', 280);
INSERT INTO `foods` VALUES (39, '台湾卤肉饭', '台式快餐', 450);
INSERT INTO `foods` VALUES (40, '武汉三鲜豆皮', '鄂菜', 220);
INSERT INTO `foods` VALUES (41, '江西瓦罐汤', '赣菜', 80);
INSERT INTO `foods` VALUES (42, '山西刀削面', '面食', 260);
INSERT INTO `foods` VALUES (43, '海南文昌鸡', '琼菜', 160);
INSERT INTO `foods` VALUES (44, '潮汕牛肉丸', '粤菜', 190);
INSERT INTO `foods` VALUES (45, '朝鲜冷面', '韩式料理', 210);
INSERT INTO `foods` VALUES (46, '日式天妇罗', '日式料理', 320);
INSERT INTO `foods` VALUES (47, '泰式青木瓜沙拉', '东南亚菜', 70);
INSERT INTO `foods` VALUES (48, '越南河粉', '东南亚主食', 280);
INSERT INTO `foods` VALUES (49, '蒙古奶豆腐', '蒙餐', 380);
INSERT INTO `foods` VALUES (50, '新疆大盘鸡', '新疆菜', 240);
INSERT INTO `foods` VALUES (51, '贵州酸汤鱼', '黔菜', 130);
INSERT INTO `foods` VALUES (52, '福建佛跳墙', '闽菜', 450);
INSERT INTO `foods` VALUES (53, '湖南剁椒鱼头', '湘菜', 200);
INSERT INTO `foods` VALUES (54, '上海生煎包', '沪式点心', 280);
INSERT INTO `foods` VALUES (55, '驴肉火烧', '冀菜', 330);
INSERT INTO `foods` VALUES (56, '宁波汤圆', '浙式点心', 300);
INSERT INTO `foods` VALUES (57, '桂林米粉', '桂菜', 250);
INSERT INTO `foods` VALUES (58, '沙县拌面', '闽小吃', 180);
INSERT INTO `foods` VALUES (59, '钵钵鸡', '川小吃', 110);
INSERT INTO `foods` VALUES (60, '龟苓膏', '广式甜品', 60);
INSERT INTO `foods` VALUES (61, '姜撞奶', '广式甜品', 90);
INSERT INTO `foods` VALUES (62, '杨枝甘露', '港式甜品', 120);
INSERT INTO `foods` VALUES (63, '东北锅包肉', '东北菜', 380);
INSERT INTO `foods` VALUES (64, '酸辣土豆丝', '家常菜', 80);
INSERT INTO `foods` VALUES (65, '蚂蚁上树', '川菜', 190);
INSERT INTO `foods` VALUES (66, '梅干菜扣肉', '浙菜', 420);
INSERT INTO `foods` VALUES (67, '客家梅菜扣肉', '粤菜', 420);
INSERT INTO `foods` VALUES (68, '延吉冷面', '朝鲜族美食', 210);
INSERT INTO `foods` VALUES (69, '柳州螺蛳粉', '桂菜', 330);
INSERT INTO `foods` VALUES (70, '无锡小笼包', '苏式点心', 280);
INSERT INTO `foods` VALUES (71, '岐山臊子面', '陕菜', 310);
INSERT INTO `foods` VALUES (72, '乐山甜皮鸭', '川菜', 320);
INSERT INTO `foods` VALUES (73, '徽州毛豆腐', '徽菜', 180);
INSERT INTO `foods` VALUES (74, '宁夏手抓羊肉', '宁菜', 380);
INSERT INTO `foods` VALUES (75, '西藏糌粑', '藏餐', 360);
INSERT INTO `foods` VALUES (76, '青海酿皮', '西北小吃', 220);
INSERT INTO `foods` VALUES (77, '闽南润饼', '闽南菜', 170);
INSERT INTO `foods` VALUES (78, '喀什烤包子', '新疆菜', 390);
INSERT INTO `foods` VALUES (79, '泸州黄粑', '川点心', 250);
INSERT INTO `foods` VALUES (80, '漳州四果汤', '闽甜品', 90);
INSERT INTO `foods` VALUES (81, '金华火腿', '浙腌制品', 330);
INSERT INTO `foods` VALUES (82, '镇江锅盖面', '苏菜', 270);
INSERT INTO `foods` VALUES (83, '安阳扁粉菜', '豫菜', 190);
INSERT INTO `foods` VALUES (84, '自贡冷吃兔', '川小吃', 280);
INSERT INTO `foods` VALUES (85, '顺德双皮奶', '广式甜品', 130);
INSERT INTO `foods` VALUES (86, '宜宾燃面', '川面食', 350);
INSERT INTO `foods` VALUES (87, '缅甸鱼汤米线', '东南亚主食', 240);
INSERT INTO `foods` VALUES (88, '老挝青木瓜沙拉', '东南亚菜', 85);
INSERT INTO `foods` VALUES (89, '柬埔寨阿莫克鱼', '高棉菜', 160);
INSERT INTO `foods` VALUES (90, '不丹辣椒奶酪', '南亚菜', 450);
INSERT INTO `foods` VALUES (91, '尼泊尔馍馍', '南亚面食', 280);
INSERT INTO `foods` VALUES (92, '斯里兰卡椰子饼', '南亚点心', 320);
INSERT INTO `foods` VALUES (93, '哈萨克斯坦抓饭', '中亚菜', 410);
INSERT INTO `foods` VALUES (94, '乌兹别克斯坦拉条子', '中亚面食', 290);
INSERT INTO `foods` VALUES (95, '吉尔吉斯斯坦马奶酒', '中亚饮品', 80);
INSERT INTO `foods` VALUES (96, '土库曼斯坦烤馕', '中亚主食', 280);
INSERT INTO `foods` VALUES (97, '汉堡包', '美洲快餐', 295);
INSERT INTO `foods` VALUES (98, '芝士披萨', '意大利菜', 266);
INSERT INTO `foods` VALUES (99, '凯撒沙拉', '西式轻食', 150);
INSERT INTO `foods` VALUES (100, '三明治', '快餐', 250);
INSERT INTO `foods` VALUES (101, '炸薯条', '快餐', 312);
INSERT INTO `foods` VALUES (102, '希腊酸奶', '乳制品', 59);
INSERT INTO `foods` VALUES (103, '墨西哥卷饼', '美洲快餐', 220);
INSERT INTO `foods` VALUES (104, '意大利肉酱面', '意式主食', 131);
INSERT INTO `foods` VALUES (105, '法式长棍面包', '烘焙', 265);
INSERT INTO `foods` VALUES (106, '牛油果吐司', '西式早餐', 230);
INSERT INTO `foods` VALUES (107, '培根煎蛋', '西式早餐', 196);
INSERT INTO `foods` VALUES (108, '燕麦粥', '健康食品', 68);
INSERT INTO `foods` VALUES (109, '蔬菜浓汤', '西式汤品', 45);
INSERT INTO `foods` VALUES (110, '金枪鱼罐头', '即食食品', 132);
INSERT INTO `foods` VALUES (111, '美式松饼', '烘焙', 377);
INSERT INTO `foods` VALUES (112, '酸奶果粒杯', '健康零食', 120);
INSERT INTO `foods` VALUES (113, '黑巧克力', '甜食', 546);
INSERT INTO `foods` VALUES (114, '能量棒', '代餐食品', 400);
INSERT INTO `foods` VALUES (115, '花生酱', '调味品', 588);
INSERT INTO `foods` VALUES (116, '鹰嘴豆泥', '中东食品', 177);
INSERT INTO `foods` VALUES (117, '寿司卷', '日式快餐', 142);
INSERT INTO `foods` VALUES (118, '韩式拌饭', '韩式快餐', 290);
INSERT INTO `foods` VALUES (119, '越南春卷', '越式轻食', 80);
INSERT INTO `foods` VALUES (120, '泰式炒河粉', '泰式主食', 300);
INSERT INTO `foods` VALUES (121, '印度咖喱鸡', '印度菜', 168);
INSERT INTO `foods` VALUES (122, '西班牙海鲜饭', '西式主食', 180);
INSERT INTO `foods` VALUES (123, '巴西烤肉', '美洲主菜', 250);
INSERT INTO `foods` VALUES (124, '德国香肠', '欧洲肉食', 330);
INSERT INTO `foods` VALUES (125, '法国可丽饼', '法式甜点', 230);
INSERT INTO `foods` VALUES (126, '比利时华夫饼', '西式甜点', 310);
INSERT INTO `foods` VALUES (127, '土耳其烤肉卷', '中东快餐', 280);
INSERT INTO `foods` VALUES (128, '以色列法拉费', '中东小吃', 330);
INSERT INTO `foods` VALUES (129, '埃及富尔梅达梅', '非洲主食', 110);
INSERT INTO `foods` VALUES (130, '摩洛哥塔吉锅', '北非炖菜', 190);
INSERT INTO `foods` VALUES (131, '阿根廷牛排', '美洲主菜', 270);
INSERT INTO `foods` VALUES (132, '夏威夷波奇碗', '美式轻食', 220);
INSERT INTO `foods` VALUES (133, '新加坡海南鸡饭', '东南亚快餐', 320);
INSERT INTO `foods` VALUES (134, '马来西亚椰浆饭', '东南亚主食', 380);
INSERT INTO `foods` VALUES (135, '英式炸鱼薯条', '英式快餐', 320);
INSERT INTO `foods` VALUES (136, '日式照烧鸡排', '日式快餐', 220);
INSERT INTO `foods` VALUES (137, '韩式泡菜汤', '韩式料理', 90);
INSERT INTO `foods` VALUES (138, '黎巴嫩塔布勒沙拉', '中东轻食', 85);
INSERT INTO `foods` VALUES (139, '南非比尔通肉干', '非洲零食', 350);
INSERT INTO `foods` VALUES (140, '挪威烟熏三文鱼', '北欧食品', 208);
INSERT INTO `foods` VALUES (141, '秘鲁藜麦沙拉', '南美健康餐', 120);
INSERT INTO `foods` VALUES (142, '葡萄牙蛋挞', '欧式甜点', 380);
INSERT INTO `foods` VALUES (143, '印尼沙爹肉串', '东南亚烧烤', 280);
INSERT INTO `foods` VALUES (144, '加拿大枫糖松饼', '美洲早餐', 310);
INSERT INTO `foods` VALUES (145, '瑞士奶酪火锅', '欧式料理', 410);
INSERT INTO `foods` VALUES (146, '智利鳄梨酱', '南美蘸料', 160);
INSERT INTO `foods` VALUES (147, '马来西亚肉骨茶', '东南亚汤品', 180);
INSERT INTO `foods` VALUES (148, '匈牙利古拉什', '东欧炖菜', 190);
INSERT INTO `foods` VALUES (149, '越南法棍三明治', '越式快餐', 270);
INSERT INTO `foods` VALUES (150, '埃塞俄比亚英吉拉', '非洲主食', 210);
INSERT INTO `foods` VALUES (151, '土耳其米布丁', '中东甜点', 240);
INSERT INTO `foods` VALUES (152, '苏格兰燕麦饼', '英式烘焙', 390);
INSERT INTO `foods` VALUES (153, '新西兰奇异果沙拉', '大洋洲轻食', 70);
INSERT INTO `foods` VALUES (154, '生酮脂肪炸弹', '功能食品', 450);
INSERT INTO `foods` VALUES (155, '植物肉汉堡', '素食替代', 210);
INSERT INTO `foods` VALUES (156, '奇亚籽布丁', '超级食品', 120);
INSERT INTO `foods` VALUES (157, '康普茶饮料', '发酵饮品', 30);
INSERT INTO `foods` VALUES (158, '羽衣甘蓝脆片', '健康零食', 150);
INSERT INTO `foods` VALUES (159, '姜黄拿铁', '功能饮品', 55);
INSERT INTO `foods` VALUES (160, '鹰嘴豆意面', '低GI主食', 180);
INSERT INTO `foods` VALUES (161, '日本罗马花椰菜', '十字花科', 30);
INSERT INTO `foods` VALUES (162, '泰国鸟眼辣椒', '茄科', 40);
INSERT INTO `foods` VALUES (163, '韩国紫苏叶', '香草类', 37);
INSERT INTO `foods` VALUES (164, '越南空心菜', '绿叶菜', 19);
INSERT INTO `foods` VALUES (165, '印度秋葵', '粘液蔬菜', 33);
INSERT INTO `foods` VALUES (166, '巴基斯坦苦瓜', '瓜类', 17);
INSERT INTO `foods` VALUES (167, '斯里兰卡木薯叶', '根茎叶', 42);
INSERT INTO `foods` VALUES (168, '土耳其樱桃萝卜', '根茎类', 20);
INSERT INTO `foods` VALUES (169, '以色列樱桃番茄', '茄科', 18);
INSERT INTO `foods` VALUES (170, '黎巴嫩扎塔尔香草', '调味蔬菜', 45);
INSERT INTO `foods` VALUES (171, '意大利菊苣', '苦味菜', 23);
INSERT INTO `foods` VALUES (172, '西班牙Padrón辣椒', '茄科', 35);
INSERT INTO `foods` VALUES (173, '法国小扁豆', '豆类', 116);
INSERT INTO `foods` VALUES (174, '德国孢子甘蓝', '十字花科', 43);
INSERT INTO `foods` VALUES (175, '荷兰食用大黄', '茎类', 21);
INSERT INTO `foods` VALUES (176, '希腊莙荙菜', '绿叶菜', 19);
INSERT INTO `foods` VALUES (177, '俄罗斯甜菜根', '根茎类', 43);
INSERT INTO `foods` VALUES (178, '乌克兰酸模叶', '野菜', 29);
INSERT INTO `foods` VALUES (179, '墨西哥哈瓦那辣椒', '茄科', 40);
INSERT INTO `foods` VALUES (180, '巴西羽衣甘蓝', '绿叶菜', 49);
INSERT INTO `foods` VALUES (181, '秘鲁紫玉米', '特色作物', 86);
INSERT INTO `foods` VALUES (182, '阿根廷银甜菜', '根茎类', 38);
INSERT INTO `foods` VALUES (183, '智利红皮洋葱', '鳞茎类', 40);
INSERT INTO `foods` VALUES (184, '古巴蕉芋', '块茎类', 97);
INSERT INTO `foods` VALUES (185, '埃及帝王椰枣叶', '棕榈科', 28);
INSERT INTO `foods` VALUES (186, '摩洛哥洋蓟', '花菜类', 47);
INSERT INTO `foods` VALUES (187, '南非野苋菜', '绿叶菜', 36);
INSERT INTO `foods` VALUES (188, '埃塞俄比亚苔麸', '谷物类', 160);
INSERT INTO `foods` VALUES (189, '肯尼亚木豆', '豆类', 343);
INSERT INTO `foods` VALUES (190, '尼日利亚水芋', '薯芋类', 112);
INSERT INTO `foods` VALUES (191, '澳大利亚丛林番茄', '茄科', 32);
INSERT INTO `foods` VALUES (192, '新西兰银蕨嫩芽', '蕨类', 29);
INSERT INTO `foods` VALUES (193, '斐济芋头叶', '叶菜类', 64);
INSERT INTO `foods` VALUES (194, '日本晴王葡萄', '浆果类', 69);
INSERT INTO `foods` VALUES (195, '泰国龙宫果', '热带水果', 60);
INSERT INTO `foods` VALUES (196, '马来西亚猫山王榴莲', '热带水果', 147);
INSERT INTO `foods` VALUES (197, '菲律宾蜜菠萝', '凤梨科', 50);
INSERT INTO `foods` VALUES (198, '印尼蛇皮果', '棕榈科', 77);
INSERT INTO `foods` VALUES (199, '越南牛奶果', '胶质水果', 92);
INSERT INTO `foods` VALUES (200, '印度神秘果', '奇异果', 20);
INSERT INTO `foods` VALUES (201, '土耳其无花果', '隐花果', 74);
INSERT INTO `foods` VALUES (202, '意大利血橙', '柑橘类', 49);
INSERT INTO `foods` VALUES (203, '西班牙枇杷', '蔷薇科', 47);
INSERT INTO `foods` VALUES (204, '法国蜜李', '核果类', 46);
INSERT INTO `foods` VALUES (205, '希腊克里特岛枣', '干果类', 287);
INSERT INTO `foods` VALUES (206, '葡萄牙杨桃', '热带水果', 31);
INSERT INTO `foods` VALUES (207, '黑海沿岸桑葚', '浆果类', 43);
INSERT INTO `foods` VALUES (208, '智利酒果', '浆果类', 28);
INSERT INTO `foods` VALUES (209, '墨西哥仙人掌果', '仙人掌科', 41);
INSERT INTO `foods` VALUES (210, '巴西阿萨伊果', '棕榈科', 70);
INSERT INTO `foods` VALUES (211, '秘鲁黄金莓', '茄科', 53);
INSERT INTO `foods` VALUES (212, '亚马逊瓜拉纳果', '藤本果实', 89);
INSERT INTO `foods` VALUES (213, '古巴芒果', '热带水果', 60);
INSERT INTO `foods` VALUES (214, '南非仙人掌果', '多肉植物', 41);
INSERT INTO `foods` VALUES (215, '马达加斯加猴面包果', '热带水果', 57);
INSERT INTO `foods` VALUES (216, '埃及椰枣', '棕榈科', 282);
INSERT INTO `foods` VALUES (217, '摩洛哥石榴', '石榴科', 83);
INSERT INTO `foods` VALUES (218, '肯尼亚百香果', '西番莲科', 97);
INSERT INTO `foods` VALUES (219, '澳大利亚指橙', '柑橘类', 43);
INSERT INTO `foods` VALUES (220, '斐济诺丽果', '热带水果', 47);
INSERT INTO `foods` VALUES (221, '塔希提香草荚', '香料果实', 51);
INSERT INTO `foods` VALUES (222, '秘鲁玛卡根', '功能食品', 325);
INSERT INTO `foods` VALUES (223, '厄瓜多尔可可豆', '热带作物', 228);
INSERT INTO `foods` VALUES (224, '中国西藏青稞', '高原谷物', 354);
INSERT INTO `foods` VALUES (225, '日本冲绳海葡萄', '藻类', 35);
INSERT INTO `foods` VALUES (226, '中国小白菜', '叶菜类', 13);
INSERT INTO `foods` VALUES (227, '日本水菜', '叶菜类', 21);
INSERT INTO `foods` VALUES (228, '韩国芝麻叶', '香草类', 37);
INSERT INTO `foods` VALUES (229, '泰國空心菜', '茎叶类', 19);
INSERT INTO `foods` VALUES (230, '印度秋葵', '粘液蔬菜', 33);
INSERT INTO `foods` VALUES (231, '越南鱼腥草', '根茎类', 39);
INSERT INTO `foods` VALUES (232, '意大利芝麻菜', '沙拉菜', 25);
INSERT INTO `foods` VALUES (233, '荷兰黄瓜', '瓜类', 15);
INSERT INTO `foods` VALUES (234, '西班牙甜椒', '茄果类', 20);
INSERT INTO `foods` VALUES (235, '德国球茎甘蓝', '根茎类', 27);
INSERT INTO `foods` VALUES (236, '法国韭葱', '葱蒜类', 61);
INSERT INTO `foods` VALUES (237, '希腊莙荙菜', '绿叶菜', 19);
INSERT INTO `foods` VALUES (238, '墨西哥牛油果', '脂肪类水果', 160);
INSERT INTO `foods` VALUES (239, '巴西羽衣甘蓝', '十字花科', 49);
INSERT INTO `foods` VALUES (240, '美国西芹', '茎类', 16);
INSERT INTO `foods` VALUES (241, '埃及帝王菜', '叶菜类', 23);
INSERT INTO `foods` VALUES (242, '南非孢子甘蓝', '十字花科', 43);
INSERT INTO `foods` VALUES (243, '澳大利亚芦笋', '茎类', 20);
INSERT INTO `foods` VALUES (244, '新西兰菠菜', '绿叶菜', 17);
INSERT INTO `foods` VALUES (245, '秘鲁紫玉米', '特色蔬菜', 86);
INSERT INTO `foods` VALUES (246, '智利红皮洋葱', '鳞茎类', 40);
INSERT INTO `foods` VALUES (247, '阿根廷银甜菜', '根茎类', 38);
INSERT INTO `foods` VALUES (248, '土耳其樱桃萝卜', '根茎类', 20);
INSERT INTO `foods` VALUES (249, '以色列樱桃番茄', '茄果类', 18);
INSERT INTO `foods` VALUES (250, '马来西亚四棱豆', '豆类', 49);
INSERT INTO `foods` VALUES (251, '菲律宾芋头叶', '叶菜类', 64);
INSERT INTO `foods` VALUES (252, '印尼木瓜叶', '叶菜类', 45);
INSERT INTO `foods` VALUES (253, '俄罗斯甜菜根', '根茎类', 43);
INSERT INTO `foods` VALUES (254, '乌克兰酸模', '野菜类', 29);
INSERT INTO `foods` VALUES (255, '挪威球茎茴香', '香草类', 31);
INSERT INTO `foods` VALUES (256, '中国水蜜桃', '核果类', 39);
INSERT INTO `foods` VALUES (257, '日本晴王葡萄', '浆果类', 69);
INSERT INTO `foods` VALUES (258, '韩国草莓', '浆果类', 32);
INSERT INTO `foods` VALUES (259, '泰国龙眼', '热带水果', 60);
INSERT INTO `foods` VALUES (260, '越南红毛丹', '热带水果', 68);
INSERT INTO `foods` VALUES (261, '印度番石榴', '热带水果', 68);
INSERT INTO `foods` VALUES (262, '马来西亚菠萝蜜', '热带水果', 95);
INSERT INTO `foods` VALUES (263, '菲律宾香蕉', '热带水果', 89);
INSERT INTO `foods` VALUES (264, '意大利血橙', '柑橘类', 49);
INSERT INTO `foods` VALUES (265, '西班牙枇杷', '蔷薇科', 47);
INSERT INTO `foods` VALUES (266, '法国布李', '核果类', 46);
INSERT INTO `foods` VALUES (267, '希腊无花果', '隐花果', 74);
INSERT INTO `foods` VALUES (268, '墨西哥青柠', '柑橘类', 30);
INSERT INTO `foods` VALUES (269, '巴西百香果', '西番莲科', 97);
INSERT INTO `foods` VALUES (270, '美国车厘子', '核果类', 50);
INSERT INTO `foods` VALUES (271, '埃及椰枣', '棕榈科', 282);
INSERT INTO `foods` VALUES (272, '南非葡萄柚', '柑橘类', 42);
INSERT INTO `foods` VALUES (273, '澳大利亚脐橙', '柑橘类', 47);
INSERT INTO `foods` VALUES (274, '新西兰奇异果', '浆果类', 61);
INSERT INTO `foods` VALUES (275, '智利蓝莓', '浆果类', 57);
INSERT INTO `foods` VALUES (276, '阿根廷柠檬', '柑橘类', 29);
INSERT INTO `foods` VALUES (277, '土耳其杏子', '核果类', 48);
INSERT INTO `foods` VALUES (278, '以色列朱栾', '柑橘类', 38);
INSERT INTO `foods` VALUES (279, '印尼蛇皮果', '棕榈科', 77);
INSERT INTO `foods` VALUES (280, '俄罗斯蔓越莓', '浆果类', 46);
INSERT INTO `foods` VALUES (281, '乌克兰黑醋栗', '浆果类', 63);
INSERT INTO `foods` VALUES (282, '挪威云莓', '浆果类', 51);
INSERT INTO `foods` VALUES (283, '秘鲁蛋黄果', '热带水果', 139);
INSERT INTO `foods` VALUES (284, '古巴芒果', '热带水果', 60);
INSERT INTO `foods` VALUES (285, '哥伦比亚树番茄', '茄科', 40);
INSERT INTO `foods` VALUES (286, '中国韭菜', '葱蒜类', 32);
INSERT INTO `foods` VALUES (287, '日本舞茸', '菌菇类', 34);
INSERT INTO `foods` VALUES (288, '韩国苏子叶', '香草类', 43);
INSERT INTO `foods` VALUES (289, '台湾山苏', '蕨类', 29);
INSERT INTO `foods` VALUES (290, '香港菜心', '茎叶类', 18);
INSERT INTO `foods` VALUES (291, '泰国九层塔', '香草类', 23);
INSERT INTO `foods` VALUES (292, '越南香茅', '茎类', 37);
INSERT INTO `foods` VALUES (293, '菲律宾芋头茎', '茎类', 56);
INSERT INTO `foods` VALUES (294, '马来西亚树仔菜', '叶菜类', 27);
INSERT INTO `foods` VALUES (295, '新加坡西洋菜', '水生蔬菜', 19);
INSERT INTO `foods` VALUES (296, '美国罗马生菜', '叶菜类', 17);
INSERT INTO `foods` VALUES (297, '意大利菊苣', '苦味菜', 23);
INSERT INTO `foods` VALUES (298, '荷兰红菊苣', '彩色蔬菜', 21);
INSERT INTO `foods` VALUES (299, '德国白芦笋', '茎类', 20);
INSERT INTO `foods` VALUES (300, '西班牙洋蓟', '花菜类', 47);
INSERT INTO `foods` VALUES (301, '中国荔浦芋头', '块茎类', 79);
INSERT INTO `foods` VALUES (302, '秘鲁紫马铃薯', '块茎类', 85);
INSERT INTO `foods` VALUES (303, '日本红皮南瓜', '瓜类', 40);
INSERT INTO `foods` VALUES (304, '印度圆茄子', '茄果类', 25);
INSERT INTO `foods` VALUES (305, '土耳其灯笼椒', '甜椒类', 31);
INSERT INTO `foods` VALUES (306, '中国四棱豆', '豆类', 49);
INSERT INTO `foods` VALUES (307, '埃及蚕豆', '豆类', 88);
INSERT INTO `foods` VALUES (308, '墨西哥鹰嘴豆', '豆类', 364);
INSERT INTO `foods` VALUES (309, '泰国翼豆', '豆类', 47);
INSERT INTO `foods` VALUES (310, '日本毛豆', '豆类', 121);
INSERT INTO `foods` VALUES (311, '中国杨梅', '浆果类', 30);
INSERT INTO `foods` VALUES (312, '日本富有柿', '柿子类', 71);
INSERT INTO `foods` VALUES (313, '韩国丰水梨', '梨类', 42);
INSERT INTO `foods` VALUES (314, '美国恐龙蛋李子', '核果类', 46);
INSERT INTO `foods` VALUES (315, '智利啤梨', '梨类', 57);
INSERT INTO `foods` VALUES (316, '泰国金枕头榴莲', '热带水果', 147);
INSERT INTO `foods` VALUES (317, '越南牛奶果', '胶质水果', 92);
INSERT INTO `foods` VALUES (318, '菲律宾吕宋芒果', '热带水果', 65);
INSERT INTO `foods` VALUES (319, '巴西甜瓜', '瓜类', 36);
INSERT INTO `foods` VALUES (320, '马来西亚水晶番石榴', '热带水果', 68);
INSERT INTO `foods` VALUES (321, '中国沃柑', '柑橘类', 43);
INSERT INTO `foods` VALUES (322, '日本蜜柑', '柑橘类', 45);
INSERT INTO `foods` VALUES (323, '西班牙脐橙', '柑橘类', 47);
INSERT INTO `foods` VALUES (324, '美国血橙', '柑橘类', 49);
INSERT INTO `foods` VALUES (325, '南非柠檬', '柑橘类', 29);
INSERT INTO `foods` VALUES (326, '中国蓝莓', '浆果类', 57);
INSERT INTO `foods` VALUES (327, '日本红颜草莓', '浆果类', 32);
INSERT INTO `foods` VALUES (328, '美国蔓越莓', '浆果类', 46);
INSERT INTO `foods` VALUES (329, '波兰树莓', '浆果类', 52);
INSERT INTO `foods` VALUES (330, '新西兰斐济果', '浆果类', 61);
INSERT INTO `foods` VALUES (331, '中国8424西瓜', '瓜类', 30);
INSERT INTO `foods` VALUES (332, '日本网纹蜜瓜', '瓜类', 34);
INSERT INTO `foods` VALUES (333, '意大利金丝瓜', '瓜类', 38);
INSERT INTO `foods` VALUES (334, '墨西哥黄西瓜', '瓜类', 32);
INSERT INTO `foods` VALUES (335, '新疆哈密瓜', '瓜类', 36);
INSERT INTO `foods` VALUES (336, '中国水蜜桃', '核果类', 39);
INSERT INTO `foods` VALUES (337, '美国黑布林', '核果类', 46);
INSERT INTO `foods` VALUES (338, '土耳其杏子', '核果类', 48);
INSERT INTO `foods` VALUES (339, '希腊油桃', '核果类', 44);
INSERT INTO `foods` VALUES (340, '智利车厘子', '核果类', 50);
INSERT INTO `foods` VALUES (341, '埃及秋葵', '粘液蔬菜', 33);
INSERT INTO `foods` VALUES (342, '摩洛哥洋蓟', '花菜类', 47);
INSERT INTO `foods` VALUES (343, '南非宝塔花菜', '十字花科', 31);
INSERT INTO `foods` VALUES (344, '肯尼亚木薯叶', '叶菜类', 64);
INSERT INTO `foods` VALUES (345, '尼日利亚芋头', '块茎类', 112);
INSERT INTO `foods` VALUES (346, '伊朗藏红花柱头', '香草类', 310);
INSERT INTO `foods` VALUES (347, '以色列樱桃萝卜', '根茎类', 20);
INSERT INTO `foods` VALUES (348, '土耳其皱叶甘蓝', '叶菜类', 43);
INSERT INTO `foods` VALUES (349, '黎巴嫩芝麻菜', '叶菜类', 25);
INSERT INTO `foods` VALUES (350, '阿联酋椰枣叶', '野菜类', 28);
INSERT INTO `foods` VALUES (351, '秘鲁玛卡根', '根茎类', 325);
INSERT INTO `foods` VALUES (352, '哥伦比亚树番茄', '茄果类', 40);
INSERT INTO `foods` VALUES (353, '古巴香蕉花', '花菜类', 89);
INSERT INTO `foods` VALUES (354, '阿根廷银甜菜', '根茎类', 38);
INSERT INTO `foods` VALUES (355, '智利红皮土豆', '块茎类', 77);
INSERT INTO `foods` VALUES (356, '斯里兰卡辣木叶', '叶菜类', 64);
INSERT INTO `foods` VALUES (357, '尼泊尔野蒜', '葱蒜类', 72);
INSERT INTO `foods` VALUES (358, '蒙古沙葱', '野菜类', 29);
INSERT INTO `foods` VALUES (359, '朝鲜明太鱼腥草', '根茎类', 39);
INSERT INTO `foods` VALUES (360, '老挝水蕨菜', '蕨类', 22);
INSERT INTO `foods` VALUES (361, '马达加斯加面包果', '热带水果', 103);
INSERT INTO `foods` VALUES (362, '塞内加尔猴面包果', '热带水果', 87);
INSERT INTO `foods` VALUES (363, '埃及无籽西瓜', '瓜类', 30);
INSERT INTO `foods` VALUES (364, '南非仙人掌果', '浆果类', 41);
INSERT INTO `foods` VALUES (365, '肯尼亚热情果', '西番莲科', 97);
INSERT INTO `foods` VALUES (366, '伊朗石榴', '浆果类', 83);
INSERT INTO `foods` VALUES (367, '沙特椰枣', '棕榈科', 282);
INSERT INTO `foods` VALUES (368, '阿曼乳香瓜', '瓜类', 38);
INSERT INTO `foods` VALUES (369, '以色列椰枣', '棕榈科', 277);
INSERT INTO `foods` VALUES (370, '约旦橄榄', '核果类', 115);
INSERT INTO `foods` VALUES (371, '墨西哥火龙果', '仙人掌科', 55);
INSERT INTO `foods` VALUES (372, '哥斯达黎加星苹果', '热带水果', 67);
INSERT INTO `foods` VALUES (373, '巴拿马杨桃', '热带水果', 31);
INSERT INTO `foods` VALUES (374, '厄瓜多尔黄金果', '热带水果', 44);
INSERT INTO `foods` VALUES (375, '委内瑞拉古布阿苏', '热带水果', 89);
INSERT INTO `foods` VALUES (376, '缅甸波罗蜜', '热带水果', 95);
INSERT INTO `foods` VALUES (377, '柬埔寨棕榈果', '棕榈科', 154);
INSERT INTO `foods` VALUES (378, '孟加拉木苹果', '热带水果', 137);
INSERT INTO `foods` VALUES (379, '不丹野生猕猴桃', '浆果类', 61);
INSERT INTO `foods` VALUES (380, '东帝汶红毛丹', '热带水果', 68);

-- ----------------------------
-- Table structure for post_likes
-- ----------------------------
DROP TABLE IF EXISTS `post_likes`;
CREATE TABLE `post_likes`  (
  `like_id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `phone` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`like_id`) USING BTREE,
  UNIQUE INDEX `unique_like`(`post_id` ASC, `phone` ASC) USING BTREE,
  INDEX `phone`(`phone` ASC) USING BTREE,
  CONSTRAINT `post_likes_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `community` (`post_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `post_likes_ibfk_2` FOREIGN KEY (`phone`) REFERENCES `users` (`phone`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of post_likes
-- ----------------------------
INSERT INTO `post_likes` VALUES (6, 40, '123', '2025-03-03 19:58:37');
INSERT INTO `post_likes` VALUES (7, 39, '123', '2025-03-03 19:59:17');
INSERT INTO `post_likes` VALUES (11, 19, '123', '2025-03-27 09:33:16');
INSERT INTO `post_likes` VALUES (12, 4, '123', '2025-03-27 10:49:27');
INSERT INTO `post_likes` VALUES (13, 21, '123', '2025-03-27 13:42:53');
INSERT INTO `post_likes` VALUES (14, 42, '123', '2025-04-18 15:57:19');
INSERT INTO `post_likes` VALUES (15, 150, '123', '2025-04-26 16:46:35');
INSERT INTO `post_likes` VALUES (16, 78, '123', '2025-04-26 16:46:41');
INSERT INTO `post_likes` VALUES (20, 218, '123', '2025-05-13 19:13:06');
INSERT INTO `post_likes` VALUES (22, 325, '123', '2025-05-26 17:28:33');
INSERT INTO `post_likes` VALUES (24, 327, '123', '2025-05-27 22:17:46');
INSERT INTO `post_likes` VALUES (25, 328, '123', '2025-05-28 16:58:43');
INSERT INTO `post_likes` VALUES (26, 329, '123', '2025-05-28 22:24:42');
INSERT INTO `post_likes` VALUES (27, 329, '12345', '2025-05-28 22:27:34');

-- ----------------------------
-- Table structure for sport_record
-- ----------------------------
DROP TABLE IF EXISTS `sport_record`;
CREATE TABLE `sport_record`  (
  `sport_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `phone` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号（数字）',
  `sport_content` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sport_duration` smallint UNSIGNED NOT NULL DEFAULT 0 COMMENT '运动时长（分钟）',
  `calorie_burned` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '卡路里消耗',
  `diet_record` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `calorie_intake` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '热量摄入',
  `sleep_duration` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '睡眠时长（小时）',
  `sleep_quality` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '未记录',
  `weight` decimal(5, 2) UNSIGNED NOT NULL DEFAULT 0.00,
  `height` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '身高（厘米）',
  `record_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录时间',
  PRIMARY KEY (`sport_id`) USING BTREE,
  INDEX `idx_phone_record_time`(`phone` ASC, `record_time` ASC) USING BTREE,
  INDEX `idx_weight`(`weight` ASC) USING BTREE,
  INDEX `idx_phone_date`(`phone` ASC, `record_time` ASC) USING BTREE,
  INDEX `idx_phone_recordtime`(`phone` ASC, `record_time` ASC) USING BTREE,
  CONSTRAINT `chk_diet_record` CHECK (char_length(`diet_record`) <= 1000),
  CONSTRAINT `chk_phone_format` CHECK (regexp_like(`phone`,_utf8mb4'^[0-9]{1,12}$')),
  CONSTRAINT `chk_sleep_quality` CHECK (char_length(`sleep_quality`) <= 1000),
  CONSTRAINT `chk_sport_content` CHECK (char_length(`sport_content`) <= 1000)
) ENGINE = InnoDB AUTO_INCREMENT = 142 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户健康记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sport_record
-- ----------------------------
INSERT INTO `sport_record` VALUES (1, '123', '晨跑30分钟', 30, 300, '鸡蛋+全麦面包+牛奶', 500, 6, '中途醒过一次', 65.50, 170, '2025-04-10 08:00:00');
INSERT INTO `sport_record` VALUES (2, '123', '瑜伽', 60, 250, '蔬菜沙拉+鸡胸肉', 400, 7, '深度睡眠质量较好', 60.00, 175, '2025-04-11 09:30:00');
INSERT INTO `sport_record` VALUES (3, '123', '慢跑', 0, 0, '麻辣火锅（牛肉+蔬菜）', 1500, 5, '多梦易醒', 66.20, 170, '2025-01-26 22:15:00');
INSERT INTO `sport_record` VALUES (4, '123', '游泳', 45, 400, '日式寿司套餐', 600, 8, '一觉到天亮', 61.50, 175, '2025-02-25 19:45:00');
INSERT INTO `sport_record` VALUES (5, '123', '动感单车', 60, 500, '金枪鱼三明治+橙汁', 300, 7, '无', 64.80, 170, '2025-02-28 18:00:00');
INSERT INTO `sport_record` VALUES (6, '12345', '慢跑', 0, 0, '披萨（海鲜口味）', 800, 6, '夜间咳嗽影响睡眠', 62.30, 175, '2025-02-24 21:20:00');
INSERT INTO `sport_record` VALUES (7, '123', '力量训练', 90, 600, '蛋白粉+香蕉', 200, 8, '睡眠非常深沉', 65.90, 170, '2025-02-23 20:10:00');
INSERT INTO `sport_record` VALUES (8, '12345', '公园快走', 30, 150, '水果拼盘（苹果+葡萄）', 250, 7, '午睡补充1小时', 60.80, 175, '2025-02-07 17:30:00');
INSERT INTO `sport_record` VALUES (9, '123', '慢跑', 0, 0, '烧烤（羊肉串+蔬菜）', 1200, 4, '熬夜工作睡眠不足', 66.50, 170, '2025-02-08 23:45:00');
INSERT INTO `sport_record` VALUES (10, '12345', '篮球', 60, 450, '台式卤肉饭+青菜', 700, 9, '睡眠质量极佳', 61.20, 175, '2025-02-09 16:00:00');
INSERT INTO `sport_record` VALUES (11, '123', '慢跑', 60, 1000, '大大大飒飒的', 500, 8, '撒大大', 60.00, 170, '2025-02-01 12:00:00');
INSERT INTO `sport_record` VALUES (15, '123', '水中慢跑', 30, 175, '[{\"name\":\"云南过桥米线\",\"grams\":100,\"calorie\":280,\"calorie_per_100g\":280}]', 280, 10, '优秀', 51.66, 170, '2025-04-12 08:00:00');
INSERT INTO `sport_record` VALUES (16, '123', '慢跑、法国跑酷、负重卷腹', 90, 725, '阳春面', 180, 6, '良好', 91.00, 170, '2025-04-15 08:00:00');
INSERT INTO `sport_record` VALUES (17, '123', '晨跑、广场舞', 90, 550, '白米饭200g+宫保鸡丁150g+凉拌黄瓜100g', 578, 7, '良好', 65.30, 170, '2025-04-19 08:15:00');
INSERT INTO `sport_record` VALUES (18, '123', '太极拳', 45, 210, '兰州拉面300g+泡菜50g', 855, 6, '中途醒过', 64.80, 170, '2025-04-17 18:30:00');
INSERT INTO `sport_record` VALUES (19, '123', '水中慢跑', 30, 175, '桂林米粉', 250, 10, '优秀', 51.00, 170, '2025-04-20 08:00:00');
INSERT INTO `sport_record` VALUES (20, '123', '慢跑', 30, 300, '芒果糯米饭', 250, 10, '优秀', 50.00, 170, '2025-04-24 08:00:00');
INSERT INTO `sport_record` VALUES (34, '123', '法国跑酷;、慢跑', 210, 2125, '土耳其米布丁(100克); 缅甸鱼汤米线(100克)', 480, 12, '优秀', 56.00, 180, '2025-04-28 00:00:00');
INSERT INTO `sport_record` VALUES (35, '1000000100', '运动内容-8', 76, 576, '饮食记录-5', 741, 5, '差', 62.91, 163, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (36, '1000000034', '运动内容-10', 99, 339, '饮食记录-4', 493, 5, '良好', 69.68, 160, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (37, '1000000032', '运动内容-7', 36, 596, '饮食记录-3', 403, 6, '一般', 69.74, 150, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (38, '1000000088', '运动内容-5', 55, 375, '饮食记录-3', 418, 5, '差', 60.84, 172, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (39, '1000000088', '运动内容-2', 91, 339, '饮食记录-1', 841, 6, '一般', 76.96, 172, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (40, '1000000001', '运动内容-5', 56, 390, '饮食记录-4', 825, 5, '优秀', 70.34, 172, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (41, '1000000006', '慢跑', 75, 136, '饮食记录-3', 623, 6, '优秀', 75.28, 171, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (42, '1000000099', '运动内容-6', 86, 122, '饮食记录-1', 1027, 7, '差', 74.93, 164, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (43, '1000000059', '跳绳', 63, 466, '饮食记录-2', 996, 7, '差', 70.62, 172, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (44, '1000000091', '运动内容-10', 72, 183, '饮食记录-1', 978, 5, '一般', 79.17, 162, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (45, '1000000080', '慢跑', 88, 475, '饮食记录-3', 353, 8, '一般', 75.37, 158, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (46, '1000000088', '骑自行车', 29, 513, '饮食记录-5', 825, 8, '优秀', 76.26, 172, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (47, '1000000072', '运动内容-10', 96, 271, '饮食记录-1', 889, 5, '差', 78.80, 158, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (48, '123141', '运动内容-8', 64, 286, '饮食记录-2', 910, 7, '优秀', 74.20, 80, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (49, '1000000091', '骑自行车', 43, 371, '饮食记录-5', 320, 6, '一般', 79.97, 162, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (50, '1000000084', '运动内容-8', 104, 269, '饮食记录-5', 551, 8, '差', 73.52, 152, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (51, '1000000025', '运动内容-7', 56, 100, '饮食记录-4', 981, 8, '优秀', 62.02, 162, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (52, '1000000100', '运动内容-8', 63, 260, '饮食记录-1', 906, 6, '一般', 69.56, 163, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (53, '1000000047', '运动内容-6', 100, 464, '饮食记录-5', 807, 6, '良好', 71.64, 178, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (54, '132425', '运动内容-5', 46, 150, '饮食记录-4', 934, 5, '优秀', 68.68, 80, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (55, '1000000046', '跳绳', 31, 171, '饮食记录-2', 470, 5, '差', 72.33, 161, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (56, '1000000034', '跳绳', 26, 555, '饮食记录-2', 1078, 8, '良好', 78.59, 160, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (57, '1000000070', '运动内容-2', 70, 340, '饮食记录-4', 398, 6, '优秀', 72.32, 151, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (58, '1000000088', '跳绳', 108, 351, '饮食记录-3', 590, 5, '良好', 71.65, 172, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (59, '1000000060', '运动内容-7', 106, 589, '饮食记录-1', 376, 6, '差', 72.18, 169, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (60, '1000000030', '跳绳', 63, 449, '饮食记录-1', 457, 8, '良好', 75.54, 175, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (61, '1000000040', '运动内容-8', 64, 297, '饮食记录-3', 446, 6, '差', 63.89, 157, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (62, '1000000076', '运动内容-8', 91, 440, '饮食记录-1', 391, 6, '优秀', 75.65, 176, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (63, '1000000027', '跳绳', 43, 463, '饮食记录-5', 423, 5, '良好', 67.96, 152, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (64, '1000000047', '运动内容-10', 66, 501, '饮食记录-3', 1030, 5, '优秀', 62.84, 178, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (65, '1000000091', '骑自行车', 33, 132, '饮食记录-5', 416, 5, '优秀', 69.73, 162, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (66, '1000000021', '慢跑', 74, 132, '饮食记录-3', 517, 8, '一般', 64.72, 160, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (67, '1000000032', '运动内容-1', 49, 320, '饮食记录-2', 921, 5, '差', 65.01, 150, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (68, '1000000086', '慢跑', 95, 128, '饮食记录-4', 895, 6, '一般', 60.15, 172, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (69, '1000000010', '运动内容-7', 26, 363, '饮食记录-3', 672, 5, '优秀', 64.20, 150, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (70, '1000000100', '运动内容-8', 92, 466, '饮食记录-2', 321, 6, '差', 68.21, 163, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (71, '1000000089', '跳绳', 60, 370, '饮食记录-2', 496, 5, '差', 73.54, 169, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (72, '1000000003', '运动内容-7', 50, 451, '饮食记录-3', 558, 5, '差', 71.75, 162, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (73, '1000000073', '跳绳', 34, 248, '饮食记录-5', 340, 6, '良好', 70.64, 173, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (74, '1000000089', '运动内容-10', 93, 175, '饮食记录-2', 379, 7, '一般', 78.74, 169, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (75, '6666655', '慢跑', 82, 312, '饮食记录-1', 1016, 6, '优秀', 75.82, 150, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (76, '1000000003', '运动内容-7', 50, 433, '饮食记录-2', 820, 6, '良好', 60.09, 162, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (77, '1234', '运动内容-6', 79, 433, '饮食记录-2', 928, 8, '差', 62.09, 0, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (78, '1000000072', '运动内容-10', 65, 487, '饮食记录-2', 713, 6, '差', 75.02, 158, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (79, '1000000099', '运动内容-8', 64, 277, '饮食记录-2', 616, 5, '良好', 67.40, 164, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (80, '1000000093', '运动内容-2', 99, 533, '饮食记录-4', 970, 5, '优秀', 64.23, 166, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (81, '1000000060', '运动内容-5', 41, 514, '饮食记录-3', 800, 8, '良好', 71.69, 169, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (82, '1000000005', '运动内容-10', 92, 150, '饮食记录-1', 390, 6, '优秀', 64.53, 156, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (83, '1000000028', '运动内容-6', 60, 455, '饮食记录-2', 1021, 8, '一般', 79.95, 171, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (84, '1000000047', '运动内容-6', 98, 394, '饮食记录-2', 1068, 8, '差', 67.93, 178, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (85, '1000000007', '运动内容-6', 75, 346, '饮食记录-4', 843, 6, '良好', 75.96, 165, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (86, '1000000040', '运动内容-8', 78, 130, '饮食记录-2', 767, 8, '一般', 63.79, 157, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (87, '1000000004', '骑自行车', 32, 590, '饮食记录-3', 751, 6, '差', 71.04, 173, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (88, '1000000082', '慢跑', 100, 244, '饮食记录-4', 316, 8, '差', 71.86, 152, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (89, '123141', '慢跑', 79, 236, '饮食记录-2', 402, 6, '差', 70.31, 80, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (90, '1000000053', '运动内容-6', 93, 285, '饮食记录-2', 1008, 5, '良好', 74.70, 152, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (91, '1000000023', '运动内容-5', 39, 457, '饮食记录-5', 734, 8, '差', 73.84, 179, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (92, '1000000086', '慢跑', 57, 193, '饮食记录-4', 962, 5, '优秀', 78.89, 172, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (93, '1000000092', '运动内容-2', 104, 154, '饮食记录-4', 569, 6, '良好', 71.12, 168, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (94, '1000000030', '运动内容-10', 70, 125, '饮食记录-3', 916, 5, '优秀', 71.76, 175, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (95, '1000000067', '运动内容-7', 62, 233, '饮食记录-5', 950, 6, '优秀', 67.30, 170, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (96, '12345', '骑自行车', 38, 258, '饮食记录-5', 975, 6, '优秀', 76.98, 0, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (97, '123455', '运动内容-6', 57, 397, '饮食记录-4', 923, 8, '良好', 78.49, 0, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (98, '1000000053', '骑自行车', 48, 467, '饮食记录-4', 669, 5, '优秀', 70.13, 152, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (99, '1000000041', '跳绳', 52, 197, '饮食记录-5', 962, 6, '差', 68.34, 175, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (100, '1000000034', '运动内容-10', 70, 120, '饮食记录-3', 740, 5, '优秀', 60.93, 160, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (101, '1000000044', '运动内容-6', 89, 188, '饮食记录-3', 601, 5, '一般', 68.61, 175, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (102, '1000000074', '骑自行车', 33, 114, '饮食记录-4', 590, 7, '一般', 77.56, 176, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (103, '1000000051', '运动内容-5', 25, 133, '饮食记录-1', 693, 5, '一般', 71.62, 152, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (104, '1000000062', '运动内容-5', 25, 124, '饮食记录-1', 475, 8, '一般', 60.12, 163, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (105, '1000000038', '运动内容-7', 25, 315, '饮食记录-5', 712, 7, '差', 70.04, 170, '2025-05-02 00:00:00');
INSERT INTO `sport_record` VALUES (106, '1000000011', '骑自行车', 41, 325, '饮食记录-3', 506, 7, '差', 62.59, 152, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (107, '1000000048', '运动内容-10', 100, 357, '饮食记录-5', 972, 7, '良好', 79.42, 166, '2025-05-02 00:00:00');
INSERT INTO `sport_record` VALUES (108, '1000000088', '跳绳', 102, 183, '饮食记录-1', 1058, 6, '一般', 62.42, 172, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (109, '123141121', '跳绳', 42, 436, '饮食记录-4', 417, 8, '一般', 63.05, 80, '2025-05-04 00:00:00');
INSERT INTO `sport_record` VALUES (110, '12314141', '慢跑', 69, 510, '饮食记录-3', 888, 6, '一般', 77.03, 0, '2025-05-04 00:00:00');
INSERT INTO `sport_record` VALUES (111, '1000000064', '运动内容-10', 66, 533, '饮食记录-4', 535, 5, '差', 71.41, 174, '2025-05-04 00:00:00');
INSERT INTO `sport_record` VALUES (112, '1000000080', '慢跑', 72, 567, '饮食记录-5', 1022, 7, '一般', 73.02, 158, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (113, '1000000064', '骑自行车', 20, 316, '饮食记录-1', 587, 6, '差', 68.81, 174, '2025-05-05 00:00:00');
INSERT INTO `sport_record` VALUES (114, '1000000005', '运动内容-2', 76, 464, '饮食记录-4', 851, 5, '一般', 67.14, 156, '2025-05-06 00:00:00');
INSERT INTO `sport_record` VALUES (115, '1000000064', '运动内容-6', 63, 550, '饮食记录-1', 787, 8, '良好', 75.67, 174, '2025-05-04 00:00:00');
INSERT INTO `sport_record` VALUES (116, '13800138000', '运动内容-8', 67, 365, '饮食记录-1', 870, 6, '差', 74.72, 170, '2025-05-05 00:00:00');
INSERT INTO `sport_record` VALUES (117, '1000000016', '骑自行车', 31, 559, '饮食记录-2', 582, 5, '良好', 76.98, 158, '2025-05-01 00:00:00');
INSERT INTO `sport_record` VALUES (118, '1000000063', '运动内容-1', 51, 371, '饮食记录-4', 824, 6, '一般', 78.16, 156, '2025-05-02 00:00:00');
INSERT INTO `sport_record` VALUES (119, '1000000055', '慢跑', 70, 529, '饮食记录-4', 712, 7, '优秀', 62.44, 166, '2025-05-04 00:00:00');
INSERT INTO `sport_record` VALUES (120, '1000000046', '跳绳', 24, 494, '饮食记录-5', 827, 8, '良好', 68.52, 161, '2025-05-01 00:00:00');
INSERT INTO `sport_record` VALUES (121, '1000000024', '跳绳', 46, 555, '饮食记录-4', 749, 8, '良好', 77.93, 164, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (122, '1000000059', '跳绳', 54, 242, '饮食记录-2', 690, 7, '一般', 73.01, 172, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (123, '1000000031', '慢跑', 99, 239, '饮食记录-4', 1019, 6, '一般', 63.79, 155, '2025-05-06 00:00:00');
INSERT INTO `sport_record` VALUES (124, '1000000097', '慢跑', 93, 597, '饮食记录-3', 800, 7, '差', 79.72, 179, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (125, '1000000011', '运动内容-2', 71, 363, '饮食记录-5', 1069, 5, '一般', 68.54, 152, '2025-05-04 00:00:00');
INSERT INTO `sport_record` VALUES (126, '1000000004', '运动内容-1', 27, 269, '饮食记录-3', 542, 5, '一般', 63.31, 173, '2025-05-03 00:00:00');
INSERT INTO `sport_record` VALUES (127, '1000000087', '运动内容-1', 59, 553, '饮食记录-2', 608, 6, '优秀', 79.82, 161, '2025-05-04 00:00:00');
INSERT INTO `sport_record` VALUES (128, '1000000038', '运动内容-8', 101, 168, '饮食记录-5', 652, 6, '优秀', 76.33, 170, '2025-05-03 00:00:00');
INSERT INTO `sport_record` VALUES (129, '1000000035', '慢跑', 96, 176, '饮食记录-2', 755, 5, '良好', 69.44, 154, '2025-05-07 00:00:00');
INSERT INTO `sport_record` VALUES (130, '1000000077', '运动内容-5', 38, 446, '饮食记录-5', 445, 6, '优秀', 61.54, 179, '2025-05-03 00:00:00');
INSERT INTO `sport_record` VALUES (131, '1000000060', '骑自行车', 28, 469, '饮食记录-3', 1046, 6, '优秀', 64.45, 169, '2025-05-01 00:00:00');
INSERT INTO `sport_record` VALUES (132, '1000000010', '骑自行车', 50, 545, '饮食记录-3', 695, 5, '良好', 66.47, 150, '2025-05-04 00:00:00');
INSERT INTO `sport_record` VALUES (133, '1000000004', '骑自行车', 43, 326, '饮食记录-3', 406, 5, '良好', 74.50, 173, '2025-05-06 00:00:00');
INSERT INTO `sport_record` VALUES (134, '1000000068', '运动内容-7', 107, 136, '饮食记录-3', 1088, 7, '优秀', 69.79, 165, '2025-05-06 00:00:00');
INSERT INTO `sport_record` VALUES (135, '123', '慢跑(40分钟)', 40, 400, '桂林米粉(100克)', 250, 10, '优秀', 51.00, 180, '2025-05-13 00:00:00');
INSERT INTO `sport_record` VALUES (137, '123', '慢跑(30分钟)', 30, 300, '芒果糯米饭(100克)', 250, 10, '优秀', 58.00, 180, '2025-05-19 00:00:00');
INSERT INTO `sport_record` VALUES (139, '123', '德国障碍跑(30分钟)', 30, 300, '秘鲁紫玉米(100克)', 86, 12, '优秀', 75.00, 180, '2025-05-26 00:00:00');
INSERT INTO `sport_record` VALUES (140, '123', '跑步机慢跑(30分钟)', 30, 300, '刀削面(100克)', 220, 10, '优秀', 68.00, 180, '2025-05-27 00:00:00');
INSERT INTO `sport_record` VALUES (141, '123', '水中慢跑(30分钟)', 30, 175, '云南过桥米线(100克)', 280, 10, '优秀', 65.00, 180, '2025-05-28 00:00:00');

-- ----------------------------
-- Table structure for sports
-- ----------------------------
DROP TABLE IF EXISTS `sports`;
CREATE TABLE `sports`  (
  `sport_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '运动名称',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '运动类别',
  `calorie_per_hour` int UNSIGNED NOT NULL COMMENT '千卡/小时',
  PRIMARY KEY (`sport_id`) USING BTREE,
  INDEX `idx_sport_category`(`category` ASC) USING BTREE,
  FULLTEXT INDEX `idx_name`(`name`)
) ENGINE = InnoDB AUTO_INCREMENT = 164 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sports
-- ----------------------------
INSERT INTO `sports` VALUES (1, '太极拳', '传统武术', 280);
INSERT INTO `sports` VALUES (2, '广场舞', '休闲运动', 250);
INSERT INTO `sports` VALUES (3, '羽毛球', '球类运动', 450);
INSERT INTO `sports` VALUES (4, '乒乓球', '球类运动', 300);
INSERT INTO `sports` VALUES (5, '瑜伽', '健身', 240);
INSERT INTO `sports` VALUES (6, '八段锦', '养生运动', 180);
INSERT INTO `sports` VALUES (7, '武术套路', '传统武术', 400);
INSERT INTO `sports` VALUES (8, '慢跑', '有氧运动', 600);
INSERT INTO `sports` VALUES (9, '跳绳', '高强度训练', 800);
INSERT INTO `sports` VALUES (10, '骑自行车', '有氧运动', 500);
INSERT INTO `sports` VALUES (11, '游泳（自由式）', '水上运动', 600);
INSERT INTO `sports` VALUES (12, '登山', '户外运动', 550);
INSERT INTO `sports` VALUES (13, '爬楼梯', '日常运动', 480);
INSERT INTO `sports` VALUES (14, '跆拳道', '格斗运动', 700);
INSERT INTO `sports` VALUES (15, '空手道', '格斗运动', 650);
INSERT INTO `sports` VALUES (16, '舞狮', '传统运动', 500);
INSERT INTO `sports` VALUES (17, '龙舟竞渡', '水上运动', 550);
INSERT INTO `sports` VALUES (18, '踢毽子', '民间运动', 300);
INSERT INTO `sports` VALUES (19, '围棋', '脑力运动', 120);
INSERT INTO `sports` VALUES (20, '气功', '养生运动', 150);
INSERT INTO `sports` VALUES (21, '快走', '有氧运动', 350);
INSERT INTO `sports` VALUES (22, '篮球', '球类运动', 600);
INSERT INTO `sports` VALUES (23, '普拉提', '健身', 300);
INSERT INTO `sports` VALUES (24, '击剑', '竞技运动', 400);
INSERT INTO `sports` VALUES (25, '滑冰', '冬季运动', 500);
INSERT INTO `sports` VALUES (26, '八卦掌', '传统武术', 320);
INSERT INTO `sports` VALUES (27, '五禽戏', '养生运动', 200);
INSERT INTO `sports` VALUES (28, '踩高跷', '民间运动', 380);
INSERT INTO `sports` VALUES (29, '抖空竹', '传统技艺', 250);
INSERT INTO `sports` VALUES (30, '柔道', '格斗运动', 650);
INSERT INTO `sports` VALUES (31, '合气道', '日本武术', 500);
INSERT INTO `sports` VALUES (32, '泰拳', '格斗运动', 750);
INSERT INTO `sports` VALUES (33, '印度瑜伽', '传统健身', 280);
INSERT INTO `sports` VALUES (34, '韩国跆拳道', '竞技运动', 680);
INSERT INTO `sports` VALUES (35, '蒙古摔跤', '传统竞技', 600);
INSERT INTO `sports` VALUES (36, '舞龙', '民俗活动', 450);
INSERT INTO `sports` VALUES (37, '踢藤球', '东南亚运动', 400);
INSERT INTO `sports` VALUES (38, '打陀螺', '民间游戏', 180);
INSERT INTO `sports` VALUES (39, '划竹筏', '水上运动', 350);
INSERT INTO `sports` VALUES (40, '攀岩', '极限运动', 700);
INSERT INTO `sports` VALUES (41, '定向越野', '户外运动', 550);
INSERT INTO `sports` VALUES (42, '击鼓传花', '传统游戏', 120);
INSERT INTO `sports` VALUES (43, '滚铁环', '童年游戏', 200);
INSERT INTO `sports` VALUES (44, '放风筝', '休闲活动', 150);
INSERT INTO `sports` VALUES (45, '踩水车', '农耕活动', 300);
INSERT INTO `sports` VALUES (46, '剑道', '日本武道', 550);
INSERT INTO `sports` VALUES (47, '马术', '竞技运动', 400);
INSERT INTO `sports` VALUES (48, '射箭', '传统运动', 350);
INSERT INTO `sports` VALUES (49, '打木球', '民间运动', 280);
INSERT INTO `sports` VALUES (50, '朝鲜族跳板', '民族运动', 480);
INSERT INTO `sports` VALUES (51, '达斡尔族曲棍球', '传统竞技', 550);
INSERT INTO `sports` VALUES (52, '苗族上刀山', '民俗表演', 680);
INSERT INTO `sports` VALUES (53, '侗族抢花炮', '集体运动', 600);
INSERT INTO `sports` VALUES (54, '彝族摔跤', '传统竞技', 620);
INSERT INTO `sports` VALUES (55, '傣族象脚鼓舞', '民族舞蹈', 400);
INSERT INTO `sports` VALUES (56, '佤族木鼓舞', '祭祀运动', 450);
INSERT INTO `sports` VALUES (57, '藏族押加', '力量竞技', 700);
INSERT INTO `sports` VALUES (58, '哈萨克姑娘追', '马上竞技', 750);
INSERT INTO `sports` VALUES (59, '鄂伦春滑雪猎', '冬季运动', 650);
INSERT INTO `sports` VALUES (60, '黎族竹竿舞', '团体活动', 380);
INSERT INTO `sports` VALUES (61, '畲族操石磉', '民间游戏', 300);
INSERT INTO `sports` VALUES (62, '缅甸藤球', '东南亚运动', 420);
INSERT INTO `sports` VALUES (63, '越南斗笠舞', '传统舞蹈', 320);
INSERT INTO `sports` VALUES (64, '印尼班卡西拉', '武术', 580);
INSERT INTO `sports` VALUES (65, '菲律宾短棍术', '格斗技术', 670);
INSERT INTO `sports` VALUES (66, '马来西亚风筝战', '休闲竞技', 280);
INSERT INTO `sports` VALUES (67, '文莱陀螺赛', '传统游戏', 250);
INSERT INTO `sports` VALUES (68, '东帝汶竹竿格斗', '民族竞技', 600);
INSERT INTO `sports` VALUES (69, '不丹射箭', '传统运动', 380);
INSERT INTO `sports` VALUES (70, '尼泊尔廓尔喀刀术', '武术', 720);
INSERT INTO `sports` VALUES (71, '斯里兰卡卡巴迪', '团体竞技', 550);
INSERT INTO `sports` VALUES (72, '椭圆机训练', '有氧运动', 500);
INSERT INTO `sports` VALUES (73, '动感单车', '室内健身', 600);
INSERT INTO `sports` VALUES (74, '尊巴舞', '舞蹈健身', 400);
INSERT INTO `sports` VALUES (75, '普拉提', '核心训练', 250);
INSERT INTO `sports` VALUES (76, '壶铃训练', '力量训练', 550);
INSERT INTO `sports` VALUES (77, '战绳训练', '高强度间歇', 680);
INSERT INTO `sports` VALUES (78, 'TRX悬吊训练', '全身锻炼', 450);
INSERT INTO `sports` VALUES (79, '攀岩墙运动', '室内攀岩', 700);
INSERT INTO `sports` VALUES (80, '拳击沙袋', '格斗训练', 800);
INSERT INTO `sports` VALUES (81, '芭蕾形体', '舞蹈', 300);
INSERT INTO `sports` VALUES (82, '爵士健美操', '有氧舞蹈', 350);
INSERT INTO `sports` VALUES (83, '水中慢跑', '水中有氧', 350);
INSERT INTO `sports` VALUES (84, '滑板运动', '街头运动', 400);
INSERT INTO `sports` VALUES (85, '飞盘竞技', '团队运动', 450);
INSERT INTO `sports` VALUES (86, '匹克球', '球类运动', 400);
INSERT INTO `sports` VALUES (87, '室内滑雪机', '冬季训练', 550);
INSERT INTO `sports` VALUES (88, '蹦床健身', '趣味训练', 480);
INSERT INTO `sports` VALUES (89, '徒步旅行', '户外活动', 350);
INSERT INTO `sports` VALUES (90, '巴西战舞', '南美武术', 500);
INSERT INTO `sports` VALUES (91, '法国跑酷', '城市运动', 650);
INSERT INTO `sports` VALUES (92, '以色列马伽术', '防身术', 700);
INSERT INTO `sports` VALUES (93, '俄罗斯桑搏', '格斗技', 680);
INSERT INTO `sports` VALUES (94, '印度板球', '球类运动', 450);
INSERT INTO `sports` VALUES (95, '美国啦啦操', '团体运动', 400);
INSERT INTO `sports` VALUES (96, '日本弓道', '传统运动', 300);
INSERT INTO `sports` VALUES (97, '非洲鼓舞蹈', '民俗活动', 380);
INSERT INTO `sports` VALUES (98, '澳式冲浪', '水上运动', 400);
INSERT INTO `sports` VALUES (99, '荷兰速滑', '冰上运动', 550);
INSERT INTO `sports` VALUES (100, '巴西卡波耶拉', '武术舞蹈', 500);
INSERT INTO `sports` VALUES (101, '北欧健走', '户外锻炼', 350);
INSERT INTO `sports` VALUES (102, '美式障碍赛', '极限训练', 700);
INSERT INTO `sports` VALUES (103, '印度街头瑜伽', '城市健身', 280);
INSERT INTO `sports` VALUES (104, '西班牙弗拉门戈舞', '有氧舞蹈', 380);
INSERT INTO `sports` VALUES (105, '菲律宾竹竿舞', '团体训练', 320);
INSERT INTO `sports` VALUES (106, '德国障碍跑', '综合训练', 600);
INSERT INTO `sports` VALUES (107, '日本公园慢跑', '基础有氧', 450);
INSERT INTO `sports` VALUES (108, '泰国泰拳健身', '格斗训练', 750);
INSERT INTO `sports` VALUES (109, '阿根廷探戈', '舞蹈燃脂', 330);
INSERT INTO `sports` VALUES (110, '夏威夷草裙舞', '趣味有氧', 300);
INSERT INTO `sports` VALUES (111, '俄罗斯芭蕾健身', '塑形运动', 280);
INSERT INTO `sports` VALUES (112, 'VR体感健身', '科技运动', 400);
INSERT INTO `sports` VALUES (113, '水下自行车', '新型有氧', 480);
INSERT INTO `sports` VALUES (114, 'AI拳击陪练', '智能训练', 650);
INSERT INTO `sports` VALUES (115, '悬浮瑜伽', '核心强化', 320);
INSERT INTO `sports` VALUES (116, '杠铃深蹲', '力量训练', 400);
INSERT INTO `sports` VALUES (117, '哑铃卧推', '力量训练', 350);
INSERT INTO `sports` VALUES (118, '硬拉训练', '力量训练', 420);
INSERT INTO `sports` VALUES (119, '器械推胸', '力量训练', 300);
INSERT INTO `sports` VALUES (120, '高位下拉', '力量训练', 280);
INSERT INTO `sports` VALUES (121, '腿举机训练', '力量训练', 380);
INSERT INTO `sports` VALUES (122, '坐姿划船', '力量训练', 320);
INSERT INTO `sports` VALUES (123, '杠铃弯举', '力量训练', 250);
INSERT INTO `sports` VALUES (124, '三头下压', '力量训练', 230);
INSERT INTO `sports` VALUES (125, '史密斯机深蹲', '力量训练', 390);
INSERT INTO `sports` VALUES (126, '负重卷腹', '力量训练', 200);
INSERT INTO `sports` VALUES (127, '器械腿弯举', '力量训练', 270);
INSERT INTO `sports` VALUES (128, '跑步机慢跑', '有氧运动', 600);
INSERT INTO `sports` VALUES (129, '划船机训练', '有氧运动', 700);
INSERT INTO `sports` VALUES (130, '椭圆机训练', '有氧运动', 500);
INSERT INTO `sports` VALUES (131, '楼梯机攀爬', '有氧运动', 800);
INSERT INTO `sports` VALUES (132, '动感单车课程', '有氧运动', 750);
INSERT INTO `sports` VALUES (133, '跳绳训练', '有氧运动', 900);
INSERT INTO `sports` VALUES (134, '战绳训练', '有氧运动', 850);
INSERT INTO `sports` VALUES (135, '登山机训练', '有氧运动', 650);
INSERT INTO `sports` VALUES (136, '搏击操', '有氧运动', 720);
INSERT INTO `sports` VALUES (137, '高抬腿训练', '有氧运动', 680);
INSERT INTO `sports` VALUES (138, 'burpee跳', '有氧运动', 950);
INSERT INTO `sports` VALUES (139, '变速跑训练', '有氧运动', 780);
INSERT INTO `sports` VALUES (140, 'TRX核心训练', '功能性训练', 550);
INSERT INTO `sports` VALUES (141, '药球抛投', '功能性训练', 480);
INSERT INTO `sports` VALUES (142, '敏捷梯训练', '功能性训练', 420);
INSERT INTO `sports` VALUES (143, '平衡球训练', '功能性训练', 380);
INSERT INTO `sports` VALUES (144, '壶铃摇摆', '功能性训练', 600);
INSERT INTO `sports` VALUES (145, '跳箱训练', '功能性训练', 720);
INSERT INTO `sports` VALUES (146, '阻力带训练', '功能性训练', 350);
INSERT INTO `sports` VALUES (147, '悬垂举腿', '功能性训练', 450);
INSERT INTO `sports` VALUES (148, '熊爬训练', '功能性训练', 500);
INSERT INTO `sports` VALUES (149, '农夫行走', '功能性训练', 580);
INSERT INTO `sports` VALUES (150, '倒立撑训练', '功能性训练', 680);
INSERT INTO `sports` VALUES (151, '攀岩机训练', '功能性训练', 620);
INSERT INTO `sports` VALUES (152, '瑜伽课程', '团体课程', 280);
INSERT INTO `sports` VALUES (153, '普拉提课程', '团体课程', 320);
INSERT INTO `sports` VALUES (154, '尊巴舞课程', '团体课程', 650);
INSERT INTO `sports` VALUES (155, '杠铃操课程', '团体课程', 700);
INSERT INTO `sports` VALUES (156, 'body combat', '团体课程', 750);
INSERT INTO `sports` VALUES (157, '空中瑜伽', '团体课程', 300);
INSERT INTO `sports` VALUES (158, '泰拳课程', '团体课程', 800);
INSERT INTO `sports` VALUES (159, '芭蕾塑形', '团体课程', 350);
INSERT INTO `sports` VALUES (160, '核心循环课', '团体课程', 550);
INSERT INTO `sports` VALUES (161, '格斗体能课', '团体课程', 780);
INSERT INTO `sports` VALUES (162, '舞蹈有氧课', '团体课程', 600);
INSERT INTO `sports` VALUES (163, '太极课程', '团体课程', 250);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '欢迎新微信用户',
  `gender` enum('男','女','无') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '无',
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '/images/avatar.png',
  `height` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '身高（厘米）',
  `register_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `phone`(`phone` ASC) USING BTREE,
  CONSTRAINT `chk_phone` CHECK (regexp_like(`phone`,_utf8mb4'^[0-9]{1,12}$'))
) ENGINE = InnoDB AUTO_INCREMENT = 130 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, '13800138000', 'e10adc3949ba59abbe56e057f20f883e', '欢迎新微信用户', '无', '/images/avatar.png', 170, '2025-05-02 21:26:31');
INSERT INTO `users` VALUES (3, '123', '$2b$10$YYZZWJS7SakQNGRTUNljJ.T4w75ZkUUw2lXg4gsEpDBsf3sfjX46G', '太让人', '女', 'http://tmp/gdsQxZSCbvure131afdb17228de247383584f7d170f0.jpeg', 180, '2025-05-02 21:26:31');
INSERT INTO `users` VALUES (11, '12345', '$2b$10$npwIm04XxJjun5RoWZvAQejPymlYXXaBP45kvnX0RY0bjFEN.lw5W', '欢迎新微信用户', '无', '/images/avatar.png', 0, '2025-05-02 21:26:31');
INSERT INTO `users` VALUES (12, '12314141', '$2b$10$D5tg03SV856Z7NUZE2Fp3eN/61A.HXmjaxShRImQdBRWKm43SFxdq', '欢迎新微信用户', '无', '/images/avatar.png', 0, '2025-05-02 21:26:31');
INSERT INTO `users` VALUES (13, '123455', '$2b$10$cJgukEMmxgHsR6PZOJz69.uqN23RfizPCzc6/xt940JI007i./Ubq', '欢迎新微信用户', '无', '/images/avatar.png', 0, '2025-05-02 21:26:31');
INSERT INTO `users` VALUES (14, '131331', '$2b$10$DUg54pfcpIppXMBYS2T6O.622WT/.htM0zGaIHTpeX2a.jBcGsEBK', '欢迎新微信用户', '无', '/images/avatar.png', 0, '2025-05-02 21:26:31');
INSERT INTO `users` VALUES (15, '1234', '$2b$10$0hpe3LBIfz7j.cQlmew3X.NY5jzFzOhflVXLwQo5Q4RW6rYdXNwoG', '欢迎新微信用户', '无', '/images/avatar.png', 0, '2025-05-02 21:26:31');
INSERT INTO `users` VALUES (16, '123444', '$2b$10$uJNMtE8RD4daQmvaSG2j.uQwn8TY56CRZq/VdPLHKU2tfFPk8DUqK', '欢迎新微信用户', '无', '/images/avatar.png', 0, '2025-05-02 21:27:40');
INSERT INTO `users` VALUES (17, '123141', '$2a$10$IXNjumEVa65OXagkiUKNjeX.oBUQM.fC8HDyn1P9CjtvCIZjy0ZLi', '你好', '无', '/images/avatar.png', 80, '2025-05-02 22:25:59');
INSERT INTO `users` VALUES (18, '132425', '$2a$10$bUZWNdgQDuAzjTczo5WCF.CObHnw5dD8puDhQi0PdlMaNPBzgNple', '你好', '无', '/images/avatar.png', 80, '2025-05-03 17:04:27');
INSERT INTO `users` VALUES (26, '6666655', '$2a$10$Rs4GB7aWeeFfIShln26sO.Ijj1AoToSQ6fg8fCMgBDawgN/hUSqr2', '你好', '无', '/images/avatar.png', 150, '2025-05-03 17:34:42');
INSERT INTO `users` VALUES (27, '123141444', '$2a$10$G2YfI7RwMrujszTsw7j12OA6RyM7RaEUoJ29pFPRBpIoS4CsJULTm', '你好', '无', '/images/avatar.png', 150, '2025-05-03 18:58:59');
INSERT INTO `users` VALUES (28, '123141121', '$2a$10$8OgrkCketG7VTpYmIzy1teIsKr.oxNb4Rqk3tfqptwHIplbfN8.MK', '你好', '无', '/images/avatar.png', 80, '2025-05-03 21:03:54');
INSERT INTO `users` VALUES (29, '1000000001', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000001', '男', '/images/avatar.png', 172, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (30, '1000000002', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000002', '男', '/images/avatar.png', 170, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (31, '1000000003', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000003', '女', '/images/avatar.png', 162, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (32, '1000000004', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000004', '男', '/images/avatar.png', 173, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (33, '1000000005', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000005', '男', '/images/avatar.png', 156, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (34, '1000000006', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000006', '女', '/images/avatar.png', 171, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (35, '1000000007', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000007', '女', '/images/avatar.png', 165, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (36, '1000000008', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000008', '女', '/images/avatar.png', 167, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (37, '1000000009', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000009', '女', '/images/avatar.png', 164, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (38, '1000000010', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000010', '男', '/images/avatar.png', 150, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (39, '1000000011', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000011', '女', '/images/avatar.png', 152, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (40, '1000000012', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000012', '女', '/images/avatar.png', 158, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (41, '1000000013', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000013', '女', '/images/avatar.png', 168, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (42, '1000000014', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000014', '男', '/images/avatar.png', 150, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (43, '1000000015', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000015', '女', '/images/avatar.png', 154, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (44, '1000000016', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000016', '女', '/images/avatar.png', 158, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (45, '1000000017', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000017', '女', '/images/avatar.png', 151, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (46, '1000000018', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000018', '女', '/images/avatar.png', 155, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (47, '1000000019', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000019', '男', '/images/avatar.png', 158, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (48, '1000000020', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000020', '女', '/images/avatar.png', 168, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (49, '1000000021', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000021', '男', '/images/avatar.png', 160, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (50, '1000000022', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000022', '女', '/images/avatar.png', 159, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (51, '1000000023', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000023', '男', '/images/avatar.png', 179, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (52, '1000000024', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000024', '女', '/images/avatar.png', 164, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (53, '1000000025', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000025', '男', '/images/avatar.png', 162, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (54, '1000000026', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000026', '女', '/images/avatar.png', 162, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (55, '1000000027', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000027', '男', '/images/avatar.png', 152, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (56, '1000000028', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000028', '女', '/images/avatar.png', 171, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (57, '1000000029', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000029', '女', '/images/avatar.png', 153, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (58, '1000000030', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000030', '女', '/images/avatar.png', 175, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (59, '1000000031', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000031', '男', '/images/avatar.png', 155, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (60, '1000000032', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000032', '女', '/images/avatar.png', 150, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (61, '1000000033', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000033', '女', '/images/avatar.png', 174, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (62, '1000000034', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000034', '男', '/images/avatar.png', 160, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (63, '1000000035', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000035', '女', '/images/avatar.png', 154, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (64, '1000000036', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000036', '男', '/images/avatar.png', 170, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (65, '1000000037', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000037', '男', '/images/avatar.png', 173, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (66, '1000000038', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000038', '女', '/images/avatar.png', 170, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (67, '1000000039', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000039', '男', '/images/avatar.png', 150, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (68, '1000000040', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000040', '男', '/images/avatar.png', 157, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (69, '1000000041', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000041', '女', '/images/avatar.png', 175, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (70, '1000000042', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000042', '女', '/images/avatar.png', 170, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (71, '1000000043', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000043', '男', '/images/avatar.png', 164, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (72, '1000000044', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000044', '女', '/images/avatar.png', 175, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (73, '1000000045', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000045', '男', '/images/avatar.png', 155, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (74, '1000000046', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000046', '女', '/images/avatar.png', 161, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (75, '1000000047', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000047', '女', '/images/avatar.png', 178, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (76, '1000000048', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000048', '女', '/images/avatar.png', 166, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (77, '1000000049', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000049', '女', '/images/avatar.png', 172, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (78, '1000000050', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000050', '男', '/images/avatar.png', 154, '2025-05-07 14:03:14');
INSERT INTO `users` VALUES (79, '1000000051', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000051', '女', '/images/avatar.png', 152, '2025-05-05 14:03:14');
INSERT INTO `users` VALUES (80, '1000000052', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000052', '女', '/images/avatar.png', 160, '2025-04-23 14:03:14');
INSERT INTO `users` VALUES (81, '1000000053', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000053', '女', '/images/avatar.png', 152, '2025-04-24 14:03:14');
INSERT INTO `users` VALUES (82, '1000000054', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000054', '女', '/images/avatar.png', 151, '2025-04-09 14:03:14');
INSERT INTO `users` VALUES (83, '1000000055', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000055', '男', '/images/avatar.png', 166, '2025-04-16 14:03:14');
INSERT INTO `users` VALUES (84, '1000000056', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000056', '男', '/images/avatar.png', 158, '2025-04-16 14:03:14');
INSERT INTO `users` VALUES (85, '1000000057', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000057', '男', '/images/avatar.png', 176, '2025-04-08 14:03:14');
INSERT INTO `users` VALUES (86, '1000000058', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000058', '女', '/images/avatar.png', 153, '2025-04-08 14:03:14');
INSERT INTO `users` VALUES (87, '1000000059', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000059', '男', '/images/avatar.png', 172, '2025-05-02 14:03:14');
INSERT INTO `users` VALUES (88, '1000000060', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000060', '男', '/images/avatar.png', 169, '2025-04-28 14:03:14');
INSERT INTO `users` VALUES (89, '1000000061', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000061', '男', '/images/avatar.png', 165, '2025-04-22 14:03:14');
INSERT INTO `users` VALUES (90, '1000000062', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000062', '女', '/images/avatar.png', 163, '2025-04-29 14:03:14');
INSERT INTO `users` VALUES (91, '1000000063', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000063', '女', '/images/avatar.png', 156, '2025-05-06 14:03:14');
INSERT INTO `users` VALUES (92, '1000000064', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000064', '男', '/images/avatar.png', 174, '2025-04-29 14:03:14');
INSERT INTO `users` VALUES (93, '1000000065', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000065', '女', '/images/avatar.png', 161, '2025-04-16 14:03:14');
INSERT INTO `users` VALUES (94, '1000000066', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000066', '女', '/images/avatar.png', 150, '2025-04-13 14:03:14');
INSERT INTO `users` VALUES (95, '1000000067', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000067', '女', '/images/avatar.png', 170, '2025-04-27 14:03:14');
INSERT INTO `users` VALUES (96, '1000000068', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000068', '男', '/images/avatar.png', 165, '2025-04-25 14:03:14');
INSERT INTO `users` VALUES (97, '1000000069', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000069', '男', '/images/avatar.png', 169, '2025-04-24 14:03:14');
INSERT INTO `users` VALUES (98, '1000000070', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000070', '女', '/images/avatar.png', 151, '2025-04-23 14:03:14');
INSERT INTO `users` VALUES (99, '1000000071', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000071', '女', '/images/avatar.png', 177, '2025-04-16 14:03:14');
INSERT INTO `users` VALUES (100, '1000000072', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000072', '男', '/images/avatar.png', 158, '2025-04-16 14:03:14');
INSERT INTO `users` VALUES (101, '1000000073', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000073', '男', '/images/avatar.png', 173, '2025-04-22 14:03:14');
INSERT INTO `users` VALUES (102, '1000000074', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000074', '女', '/images/avatar.png', 176, '2025-04-22 14:03:14');
INSERT INTO `users` VALUES (103, '1000000075', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000075', '男', '/images/avatar.png', 151, '2025-04-22 14:03:14');
INSERT INTO `users` VALUES (104, '1000000076', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000076', '女', '/images/avatar.png', 176, '2025-04-12 14:03:14');
INSERT INTO `users` VALUES (105, '1000000077', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000077', '男', '/images/avatar.png', 179, '2025-04-16 14:03:14');
INSERT INTO `users` VALUES (106, '1000000078', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000078', '男', '/images/avatar.png', 179, '2025-04-08 14:03:14');
INSERT INTO `users` VALUES (107, '1000000079', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000079', '女', '/images/avatar.png', 158, '2025-05-02 14:03:14');
INSERT INTO `users` VALUES (108, '1000000080', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000080', '女', '/images/avatar.png', 158, '2025-04-09 14:03:14');
INSERT INTO `users` VALUES (109, '1000000081', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000081', '男', '/images/avatar.png', 169, '2025-04-23 14:03:14');
INSERT INTO `users` VALUES (110, '1000000082', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000082', '男', '/images/avatar.png', 152, '2025-04-11 14:03:14');
INSERT INTO `users` VALUES (111, '1000000083', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000083', '女', '/images/avatar.png', 150, '2025-04-15 14:03:14');
INSERT INTO `users` VALUES (112, '1000000084', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000084', '男', '/images/avatar.png', 152, '2025-04-26 14:03:14');
INSERT INTO `users` VALUES (113, '1000000085', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000085', '男', '/images/avatar.png', 179, '2025-05-04 14:03:14');
INSERT INTO `users` VALUES (114, '1000000086', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000086', '男', '/images/avatar.png', 172, '2025-04-11 14:03:14');
INSERT INTO `users` VALUES (115, '1000000087', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000087', '女', '/images/avatar.png', 161, '2025-04-30 14:03:14');
INSERT INTO `users` VALUES (116, '1000000088', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000088', '女', '/images/avatar.png', 172, '2025-04-22 14:03:14');
INSERT INTO `users` VALUES (117, '1000000089', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000089', '女', '/images/avatar.png', 169, '2025-04-21 14:03:14');
INSERT INTO `users` VALUES (118, '1000000090', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000090', '男', '/images/avatar.png', 163, '2025-04-14 14:03:14');
INSERT INTO `users` VALUES (119, '1000000091', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000091', '男', '/images/avatar.png', 162, '2025-04-24 14:03:14');
INSERT INTO `users` VALUES (120, '1000000092', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000092', '男', '/images/avatar.png', 168, '2025-05-04 14:03:14');
INSERT INTO `users` VALUES (121, '1000000093', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000093', '男', '/images/avatar.png', 166, '2025-04-24 14:03:14');
INSERT INTO `users` VALUES (122, '1000000094', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000094', '女', '/images/avatar.png', 153, '2025-05-04 14:03:14');
INSERT INTO `users` VALUES (123, '1000000095', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000095', '女', '/images/avatar.png', 150, '2025-05-02 14:03:14');
INSERT INTO `users` VALUES (124, '1000000096', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000096', '男', '/images/avatar.png', 159, '2025-04-20 14:03:14');
INSERT INTO `users` VALUES (125, '1000000097', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000097', '男', '/images/avatar.png', 179, '2025-05-03 14:03:14');
INSERT INTO `users` VALUES (126, '1000000098', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000098', '男', '/images/avatar.png', 169, '2025-04-16 14:03:14');
INSERT INTO `users` VALUES (127, '1000000099', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000099', '男', '/images/avatar.png', 164, '2025-05-03 14:03:14');
INSERT INTO `users` VALUES (128, '1000000100', '0d63031864eaeeab8baf66bee4e9c3b9', 'User_1000000100', '女', '/images/avatar.png', 163, '2025-05-05 14:03:14');
INSERT INTO `users` VALUES (129, '13003875060', '$2b$10$HCv6Qieepe2ranm6E48c/uDnX4INhUCeOmq9T8.vw7Q7yUsz/71Rq', '欢迎新微信用户', '无', '/images/avatar.png', 0, '2025-05-26 23:23:41');

-- ----------------------------
-- Procedure structure for InsertCommunityPosts
-- ----------------------------
DROP PROCEDURE IF EXISTS `InsertCommunityPosts`;
delimiter ;;
CREATE PROCEDURE `InsertCommunityPosts`()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE today DATETIME DEFAULT NOW();

    WHILE i <= 100 DO
        INSERT INTO community (phone, post_topic, content, post_time, comment_count, like_count, image_path)
        SELECT 
            u.phone,
            CONCAT('主题-', FLOOR(1 + RAND() * 10)),
            CONCAT('帖子内容详情-', UUID()),
            IF(i <= 70, today, DATE_SUB(today, INTERVAL FLOOR(RAND() * 7) DAY)), -- 大部分为今天
            FLOOR(0 + RAND() * 10),
            FLOOR(0 + RAND() * 100),
            ''
        FROM users u
        ORDER BY RAND()
        LIMIT 1;
        SET i = i + 1;
    END WHILE;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for InsertSportRecords
-- ----------------------------
DROP PROCEDURE IF EXISTS `InsertSportRecords`;
delimiter ;;
CREATE PROCEDURE `InsertSportRecords`()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE user_count INT;
    DECLARE today DATE DEFAULT CURDATE();
    
    -- 获取当前总用户数
    SELECT COUNT(*) INTO user_count FROM users;

    WHILE i <= 100 DO
        INSERT INTO sport_record (
            phone, sport_content, sport_duration, calorie_burned, 
            diet_record, calorie_intake, sleep_duration, sleep_quality, weight, height, record_time
        )
        SELECT 
            u.phone,
            CONCAT('运动内容-', FLOOR(1 + RAND() * 10)),
            FLOOR(20 + RAND() * 90), -- 运动时长 20~110分钟
            FLOOR(100 + RAND() * 500), -- 卡路里消耗
            CONCAT('饮食记录-', FLOOR(1 + RAND() * 5)),
            FLOOR(300 + RAND() * 800), -- 热量摄入
            FLOOR(5 + RAND() * 4),     -- 睡眠时长 5~8小时
            ELT(FLOOR(1 + RAND() * 4), '优秀', '良好', '一般', '差'),
            ROUND(60 + RAND() * 20, 2), -- 体重
            u.height,
            IF(i <= 70, today, DATE_SUB(today, INTERVAL FLOOR(RAND() * 7) DAY)) -- 大部分为今天
        FROM users u
        ORDER BY RAND()
        LIMIT 1
        ON DUPLICATE KEY UPDATE phone = VALUES(phone); -- 防止重复插入同一天记录
        SET i = i + 1;
    END WHILE;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for InsertUsers
-- ----------------------------
DROP PROCEDURE IF EXISTS `InsertUsers`;
delimiter ;;
CREATE PROCEDURE `InsertUsers`()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE base_phone BIGINT DEFAULT 1000000000; -- 起始手机号
    WHILE i <= 100 DO
        INSERT INTO users (phone, password, nickname, gender, avatar_url, height, register_time)
        SELECT 
            CAST(base_phone + i AS CHAR), 
            MD5('default_password'), 
            CONCAT('User_', base_phone + i),
            CASE WHEN RAND() > 0.5 THEN '男' ELSE '女' END,
            '/images/avatar.png',
            FLOOR(150 + RAND() * 30), -- 随机身高 150-180cm
            IF(i <= 50, NOW(), DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 30) DAY)); -- 前50条为今天注册
        SET i = i + 1;
    END WHILE;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table sport_record
-- ----------------------------
DROP TRIGGER IF EXISTS `sync_user_height`;
delimiter ;;
CREATE TRIGGER `sync_user_height` BEFORE INSERT ON `sport_record` FOR EACH ROW BEGIN
  DECLARE user_height INT DEFAULT 0;
  
  SELECT height INTO user_height 
  FROM users 
  WHERE phone = NEW.phone
  LIMIT 1;
  
  -- 处理用户不存在的情况
  IF user_height IS NULL THEN
    SET user_height = 0;
  END IF;
  
  SET NEW.height = user_height;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
