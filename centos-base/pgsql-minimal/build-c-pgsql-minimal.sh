#/bin/bash
docker build -f pgsql90/Dockerfile -t c-pgsql-minimal:v90 ./pgsql90
docker build -f pgsql91/Dockerfile -t c-pgsql-minimal:v91 ./pgsql91
docker build -f pgsql92/Dockerfile -t c-pgsql-minimal:v92 ./pgsql92
docker build -f pgsql93/Dockerfile -t c-pgsql-minimal:v93 ./pgsql93
docker build -f pgsql94/Dockerfile -t c-pgsql-minimal:v94 ./pgsql94
docker build -f pgsql95/Dockerfile -t c-pgsql-minimal:v95 ./pgsql95
docker build -f pgsql96/Dockerfile -t c-pgsql-minimal:v96 ./pgsql96
docker build -f pgsql10/Dockerfile -t c-pgsql-minimal:v10 ./pgsql10
docker build -f pgsql11/Dockerfile -t c-pgsql-minimal:v11 ./pgsql11
docker build -f pgsql12/Dockerfile -t c-pgsql-minimal:v12 ./pgsql12
docker build -f pgsql13/Dockerfile -t c-pgsql-minimal:v13 ./pgsql13
