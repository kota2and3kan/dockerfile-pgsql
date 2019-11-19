FROM ubuntu:18.04 AS builder-pgsql-minimal
RUN apt update > /dev/null \
 && apt install -y make gcc libreadline-dev zlib1g-dev curl > /dev/null \
 && useradd -m -s /bin/bash postgres \
 && cd /usr/local/src \
 && curl -O https://ftp.postgresql.org/pub/source/v9.4.25/postgresql-9.4.25.tar.gz > /dev/null \
 && tar xzf postgresql-9.4.25.tar.gz \
 && chown -R postgres. postgresql-9.4.25/ \
 && su - postgres -c "cd /usr/local/src/postgresql-9.4.25/ && ./configure && make" > /dev/null \
 && cd /usr/local/src/postgresql-9.4.25/ \
 && make install > /dev/null 

FROM ubuntu:18.04
COPY --from=builder-pgsql-minimal /usr/local/pgsql /usr/local/pgsql
RUN apt update > /dev/null \
 && apt install -y vim-tiny libreadline7 libc6 > /dev/null \
 && apt-get -y clean > /dev/null \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /usr/local/pgsql/data \
 && useradd -m -s /bin/bash postgres \
 && chown postgres. /usr/local/pgsql/data/ \
 && chmod 700 /usr/local/pgsql/data/ \
 && echo "export PGDATA=/usr/local/pgsql/data" >> /home/postgres/.profile \
 && echo "export PATH=/usr/local/pgsql/bin:$PATH" >> /home/postgres/.profile \
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
