create table todo(
	username VARCHAR(64) NOT NULL,
	doDate datetime NOT NULL,
	createDate timestamp NOT NULL,
	keywords VARCHAR(64) DEFAULT NULL,
	thing VARCHAR(256) NOT NULL,
	how VARCHAR(4096) DEFAULT NULL,
	PRIMARY KEY (doDate)
) DEFAULT CHARSET=utf8;