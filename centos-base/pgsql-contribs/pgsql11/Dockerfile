FROM centos:7.6.1810 AS builder-pgsql-contribs
RUN yum install -y make gcc readline-devel zlib-devel openssl-devel > /dev/null \
 && useradd postgres \
 && cd /usr/local/src \
 && curl -O https://ftp.postgresql.org/pub/source/v11.14/postgresql-11.14.tar.gz > /dev/null \
 && tar xzf postgresql-11.14.tar.gz \
 && chown -R postgres. postgresql-11.14/ \
 && su - postgres -c "cd /usr/local/src/postgresql-11.14/ && ./configure --with-openssl && make world" > /dev/null \
 && cd /usr/local/src/postgresql-11.14/ \
 && make install-world > /dev/null \
 && rm -rf /usr/local/pgsql/share/doc \
 && rm -rf /usr/local/pgsql/share/man

FROM centos:7.6.1810
COPY --from=builder-pgsql-contribs /usr/local/pgsql /usr/local/pgsql
RUN yum install -y openssl glibc > /dev/null \
 && yum clean all > /dev/null \
 && rm -rf /var/cache/yum/* \
 && mkdir -p /usr/local/pgsql/data \
 && useradd postgres \
 && chown postgres. /usr/local/pgsql/data/ \
 && chmod 700 /usr/local/pgsql/data/ \
 && echo "export PGDATA=/usr/local/pgsql/data" >> /home/postgres/.bashrc \
 && echo "export PATH=/usr/local/pgsql/bin:$PATH" >> /home/postgres/.bashrc \
 && su - postgres -c "initdb --encoding=utf8 --no-local" > /dev/null \
 && echo "" >> /usr/local/pgsql/data/postgresql.conf \
 && echo "# Add user configuration" >> /usr/local/pgsql/data/postgresql.conf \
 && echo "listen_addresses = '*'" >> /usr/local/pgsql/data/postgresql.conf \
 && echo "logging_collector = on" >> /usr/local/pgsql/data/postgresql.conf \
 && echo "log_filename = 'postgresql-%Y-%m-%d.log'" >> /usr/local/pgsql/data/postgresql.conf \
 && echo "log_error_verbosity = verbose" >> /usr/local/pgsql/data/postgresql.conf \
 && echo "ssl = on" >> /usr/local/pgsql/data/postgresql.conf \
 && sed -i s/"127.0.0.1\/32"/"0.0.0.0\/0"/g /usr/local/pgsql/data/pg_hba.conf \
 && sed -i s/"::1\/128"/"::\/0"/g /usr/local/pgsql/data/pg_hba.conf \
 && su - postgres -c 'yes "" | openssl req -new -x509 -days 365 -nodes -text -out /usr/local/pgsql/data/server.crt -keyout /usr/local/pgsql/data/server.key -subj "/CN=dbhost.example.com"' \
 && chmod 600 /usr/local/pgsql/data/server.key
CMD ["/bin/bash"]
