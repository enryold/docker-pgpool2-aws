# docker-pgpool2-aws
Docker image with pgpool2. 

## Why 'aws'?
In todo-list I will make this image able to pull some info from AWS cli (new replicas, replication problems) and react by reloading pgpool configuration (for example)


## Config

- Use this image as base image.
- Create your pgpool configuration (pgpool.conf, pgpool_hba.conf, etc..)
- Create a file named pool_passwd_plain with you dbms username and password.
- If you dont use pool_passwd system, leave it blank.
- Copy your pgpool configuration files into docker folder /usr/local/etc/
- Start image
- 
## Remember

- If you use pgpool streaming_replication feature with check_period, remember to set right user and password in your pgpool.conf file

```
sr_check_user = 'my_user'
                                   # Streaming replication check user
                                   # This is neccessary even if you disable streaming
                                   # replication delay check by sr_check_period = 0
sr_check_password = 'my_password'
```


## Usage

```
FROM enryold/pgpool2-aws
COPY ./myconfigfolder/* /usr/local/etc/
```

