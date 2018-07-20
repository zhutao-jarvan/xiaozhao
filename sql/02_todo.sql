create table todo(
	username VARCHAR(64) NOT NULL,
	doDate datetime NOT NULL,
	createDate long NOT NULL,
	deleteTime long DEFAULT NULL,
	status int(1) DEFAULT NULL,
	priority int(1) DEFAULT NULL,
	keywords VARCHAR(64) DEFAULT NULL,
	thing VARCHAR(256) NOT NULL,
	how VARCHAR(4096) DEFAULT NULL
) DEFAULT CHARSET=utf8