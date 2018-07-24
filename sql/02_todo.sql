create table todo(
	id int(8) NOT NULL AUTO_INCREMENT,
	userId VARCHAR(64) NOT NULL,
	doDate datetime NOT NULL,
	createDate long NOT NULL,
	deleteTime long DEFAULT NULL,
	doneTime long DEFAULT NULL,
	status int(1) DEFAULT NULL,
	priority int(1) DEFAULT NULL,
	keywords VARCHAR(64) DEFAULT NULL,
	thing VARCHAR(256) NOT NULL,
	how VARCHAR(4096) DEFAULT NULL,
	PRIMARY KEY (id)
)ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8