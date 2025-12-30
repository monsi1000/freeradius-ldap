FROM debian:stable-slim

ENTRYPOINT [ "/init" ]

# RADIUS Authentication Messages
EXPOSE 1812/udp

# RADIUS Accounting Messages
EXPOSE 1813/udp

# Install freeradius with ldap support
RUN apt-get update && \
    apt-get install -y freeradius-ldap  && \
    apt-get -y update && \
    apt-get -y clean all

# Install tini init
RUN curl -L https://github.com/krallin/tini/releases/download/v0.19.0/tini > /usr/bin/tini \
        && chmod +x /usr/bin/tini

# Copy our configuration
COPY ldap /etc/raddb/mods-available/
COPY init /