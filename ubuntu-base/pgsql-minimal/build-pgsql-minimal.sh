#/bin/bash
docker build -f pgsql90/Dockerfile -t pgsql-minimal:v90 ./pgsql90
docker build -f pgsql91/Dockerfile -t pgsql-minimal:v91 ./pgsql91
docker build -f pgsql92/Dockerfile -t pgsql-minimal:v92 ./pgsql92
docker build -f pgsql93/Dockerfile -t pgsql-minimal:v93 ./pgsql93
docker build -f pgsql94/Dockerfile -t pgsql-minimal:v94 ./pgsql94
docker build -f pgsql95/Dockerfile -t pgsql-minimal:v95 ./pgsql95
docker build -f pgsql96/Dockerfile -t pgsql-minimal:v96 ./pgsql96
docker build -f pgsql10/Dockerfile -t pgsql-minimal:v10 ./pgsql10
docker build -f pgsql11/Dockerfile -t pgsql-minimal:v11 ./pgsql11
