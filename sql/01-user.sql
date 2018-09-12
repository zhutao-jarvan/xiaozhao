DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `username` VARCHAR (64) NOT NULL COMMENT '用户名',
  `nickname` VARCHAR (64) COMMENT '昵称',
  `password` VARCHAR (64) NOT NULL COMMENT '密码',
  `qq` VARCHAR (64) NOT NULL COMMENT 'qq',
  `telephone` VARCHAR (64) NOT NULL COMMENT '电话号码',
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `valid` tinyint(1) DEFAULT TRUE COMMENT '账户有效性',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `telephone` (`telephone`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;