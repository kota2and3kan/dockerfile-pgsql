# dockerfile-pgsql
Dockerfile for local test of PostgreSQL.

## Note
For test local or development envronment.  
Not for production.


This repository includes EoL version of PostgreSQL.  
Please refer the [Versioning Policy](https://www.postgresql.org/support/versioning/) page of the PostgreSQL Global Development Group for details of EoL version.

## Description 

#### Use CentOS base image.
- centos-base/pgsql-minimal/
	- Build by `./configure && make` and install by `make install`.
- centos-base/pgsql-ssl/
	- Build by `./configure --with-openssl && make` and install by `make install`.
- centos-base/pgsql-contribs/
	- Build by `./configure --with-openssl && make world` and install by `make install-world`. (*1)

#### Use Ubuntu base image.
- ubuntu-base/pgsql-minimal/
	- Build by `./configure && make` and install by `make install`.
- ubuntu-base/pgsql-ssl/
	- Build by `./configure --with-openssl && make` and install by `make install`.
- ubuntu-base/pgsql-contribs/
	- Build by `./configure --with-openssl && make world` and install by `make install-world`. (*1)

#### Matrix
|name | SSL/TLS | Contrib modules |
|:---|:---:|:---:|
|pgsql-minimal |x |x |
|pgsql-ssl |o |x |
|pgsql-contribs (*1) |o |o |


(*1) It does not include /usr/local/pgsql/share/doc and /usr/local/pgsql/share/man directories to reduce the image size.

## Build

Clone this repository.
```
$ git clone https://github.com/kota2and3kan/dockerfile-pgsql.git
```

Run the script in the directory that you want to use.
```
$ cd ubuntu-base/pgsql-contribs
$ sudo ./build-pgsql-contribs.sh
```

Or build by `docker build`.
```
$ cd ubuntu-base/pgsql-contribs
$ sudo docker build -f pgsql11/Dockerfile -t <image-name>:<tag-name> ./pgsql11
```

## Usage
After build image, you can start PostgreSQL container by the following command.
```
$ sudo docker run -it pgsql-contribs:v11
```

Example
```
$ sudo docker run -it pgsql-contribs:v11
[sudo] password for local-user: 
root@abb841bf60d9:/# 
root@abb841bf60d9:/# su - postgres
postgres@abb841bf60d9:~$ 
postgres@abb841bf60d9:~$ pg_ctl start       
waiting for server to start....2019-04-23 15:09:30.813 UTC [21] LOG:  00000: listening on IPv4 address "0.0.0.0", port 5432
2019-04-23 15:09:30.813 UTC [21] LOCATION:  StreamServerPort, pqcomm.c:593
2019-04-23 15:09:30.813 UTC [21] LOG:  00000: listening on IPv6 address "::", port 5432
2019-04-23 15:09:30.813 UTC [21] LOCATION:  StreamServerPort, pqcomm.c:593
2019-04-23 15:09:30.822 UTC [21] LOG:  00000: listening on Unix socket "/tmp/.s.PGSQL.5432"
2019-04-23 15:09:30.822 UTC [21] LOCATION:  StreamServerPort, pqcomm.c:587
2019-04-23 15:09:30.841 UTC [21] LOG:  00000: redirecting log output to logging collector process
2019-04-23 15:09:30.841 UTC [21] HINT:  Future log output will appear in directory "log".
2019-04-23 15:09:30.841 UTC [21] LOCATION:  SysLogger_Start, syslogger.c:667
 done
server started
postgres@abb841bf60d9:~$ 
postgres@abb841bf60d9:~$ psql
psql (11.2)
Type "help" for help.

postgres=# 
postgres=# select version();
                                               version                                                
------------------------------------------------------------------------------------------------------
 PostgreSQL 11.2 on x86_64-pc-linux-gnu, compiled by gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0, 64-bit
(1 row)

postgres=# 
```

## Environment infomation
Environment variable
```
PGDATA = /usr/local/pgsql/data
```

Other environmet info (pg_confg excerpt)
```
BINDIR = /usr/local/pgsql/bin
INCLUDEDIR = /usr/local/pgsql/include
PKGINCLUDEDIR = /usr/local/pgsql/include
INCLUDEDIR-SERVER = /usr/local/pgsql/include/server
LIBDIR = /usr/local/pgsql/lib
PKGLIBDIR = /usr/local/pgsql/lib
LOCALEDIR = /usr/local/pgsql/share/locale
SHAREDIR = /usr/local/pgsql/share
SYSCONFDIR = /usr/local/pgsql/etc
```

## License
Please refer the [LICENSE](https://github.com/kota2and3kan/dockerfile-pgsql/blob/master/LICENSE).
