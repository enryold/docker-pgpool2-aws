# docker-pgpool2-aws
Docker image with pgpool2


## Config

- Use this image as base image.
- Create your pgpool configuration (pgpool.conf, pgpool_hba.conf, etc..)
- Create a file named pool_passwd_plain with you dbms username and password.
- If you dont use pool_passwd system, leave it blank.
- Copy your pgpool configuration files into docker folder /usr/local/etc/
- Start image


## Usage

```
FROM enryold/docker-pgpool2-aws
COPY ./myconfigfolder/* /usr/local/etc/


