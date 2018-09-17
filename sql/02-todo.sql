DROP TABLE IF EXISTS `todo`;
CREATE TABLE `todo` (
  `todo_id` INT (11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` INT (11) NOT NULL COMMENT '与用户编号关联',
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `do_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '计划处理时间',
  `dead_time` TIMESTAMP NULL COMMENT '完成时间或者删除时间',
  `status` tinyint(1) DEFAULT 0 COMMENT '当前状态，1、未处理，2、已完成，3、已删除',
  `keyword` VARCHAR(32) NOT NULL COMMENT '项目关键词',
  `todo` VARCHAR(32) NOT NULL COMMENT '项目标题',
  `description` VARCHAR(1024) NOT NULL COMMENT '项目描述',
  PRIMARY KEY (`todo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;