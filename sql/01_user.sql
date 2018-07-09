create table user(
	id VARCHAR(64) NOT NULL,
	username VARCHAR(20) DEFAULT NULL,
	password VARCHAR(20) DEFAULT NULL,
	headerPic VARCHAR(60) DEFAULT NULL,
	email VARCHAR(60) DEFAULT NULL,
	sex VARCHAR(2) DEFAULT NULL,
	create_time datetime DEFAULT NULL,
	update_time timestamp,
	is_delete int(1) DEFAULT NULL,
	address VARCHAR(200) DEFAULT NULL,
	telephone VARCHAR(15) DEFAULT NULL,
	PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;
