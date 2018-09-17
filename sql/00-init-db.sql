/*
  创建用户和数据库
*/
REVOKE ALL ON *.* FROM xiaozhao;
DELETE FROM mysql.user WHERE user='xiaozhao';
DROP DATABASE xiaozhao;

CREATE DATABASE xiaozhao DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE user 'xiaozhao'@'localhost' identified by 'zhutao';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP ON xiaozhao.*  TO 'xiaozhao'@'localhost' IDENTIFIED BY 'zhutao';
FLUSH PRIVILEGES;
