FROM ubuntu:18.04 AS builder-pgsql-contribs
RUN apt update > /dev/null \
 && apt install -y make gcc libreadline-dev zlib1g-dev curl libssl-dev > /dev/null \
 && useradd -m -s /bin/bash postgres \
 && cd /usr/local/src \
 && curl -O https://ftp.postgresql.org/pub/source/v10.19/postgresql-10.19.tar.gz > /dev/null \
 && tar xzf postgresql-10.19.tar.gz \
 && chown -R postgres. postgresql-10.19/ \
 && su - postgres -c "cd /usr/local/src/postgresql-10.19/ && ./configure --with-openssl && make world" > /dev/null \
 && cd /usr/local/src/postgresql-10.19/ \
 && make install-world > /dev/null \
 && rm -rf /usr/local/pgsql/share/doc \
 && rm -rf /usr/local/pgsql/share/man

FROM ubuntu:18.04
COPY --from=builder-pgsql-contribs /usr/local/pgsql /usr/local/pgsql
RUN apt update > /dev/null \
 && apt install -y vim-tiny libreadline7 openssl libc6 > /dev/null \
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
 && echo "ssl = on" >> /usr/local/pgsql/data/postgresql.conf \
 && su - postgres -c 'yes "" | openssl req -new -x509 -days 365 -nodes -text -out /usr/local/pgsql/data/server.crt -keyout /usr/local/pgsql/data/server.key -subj "/CN=dbhost.example.com"' \
 && chmod 600 /usr/local/pgsql/data/server.key \
 && sed -i s/"127.0.0.1\/32"/"0.0.0.0\/0"/g /usr/local/pgsql/data/pg_hba.conf \
 && sed -i s/"::1\/128"/"::\/0"/g /usr/local/pgsql/data/pg_hba.conf 
CMD ["/bin/bash"]
