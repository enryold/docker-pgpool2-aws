# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

WORKDIR /


# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]


RUN apt-get -qy update && apt-get -qy upgrade && locale-gen en_US.UTF-8 && export LANG=en_US.UTF-8
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install nano wget curl software-properties-common build-essential
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install libpq-dev
RUN apt-get -qy update

RUN wget http://www.pgpool.net/mediawiki/images/pgpool-II-3.4.3.tar.gz


RUN tar -xvf pgpool-II-3.4.3.tar.gz && \
    cd pgpool-II-3.4.3 && \
    ./configure && \
    make && \
    make install



# AWS certificate
RUN wget http://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem && \
    mv rds-combined-ca-bundle.pem /usr/local/etc/rds-combined-ca-bundle.pem


# pgpool-service script at start
RUN mkdir /etc/service/pgpoolII
COPY ./init.sh /etc/service/pgpoolII/run
RUN chmod +x /etc/service/pgpoolII/run



# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#ssh service (remove phusion restriction)
RUN rm -f /etc/service/sshd/down


expose 5432


#ENTRYPOINT ["/sbin/my_init"]
