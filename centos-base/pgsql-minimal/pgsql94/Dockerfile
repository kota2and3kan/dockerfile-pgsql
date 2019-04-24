FROM centos:7.6.1810 AS builder-pgsql-minimal
RUN yum install -y make gcc readline-devel zlib-devel > /dev/null \
 && useradd postgres \
 && cd /usr/local/src \
 && curl -O https://ftp.postgresql.org/pub/source/v9.4.21/postgresql-9.4.21.tar.gz > /dev/null \
 && tar xzf postgresql-9.4.21.tar.gz \
 && chown -R postgres. postgresql-9.4.21/ \
 && su - postgres -c "cd /usr/local/src/postgresql-9.4.21/ && ./configure && make" > /dev/null \
 && cd /usr/local/src/postgresql-9.4.21/ \
 && make install > /dev/null 

FROM centos:7.6.1810
COPY --from=builder-pgsql-minimal /usr/local/pgsql /usr/local/pgsql/
RUN yum install -y glibc > /dev/null \
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
 && sed -i s/"127.0.0.1\/32"/"0.0.0.0\/0"/g /usr/local/pgsql/data/pg_hba.conf \
 && sed -i s/"::1\/128"/"::\/0"/g /usr/local/pgsql/data/pg_hba.conf
CMD ["/bin/bash"]
