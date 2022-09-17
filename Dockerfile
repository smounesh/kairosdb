FROM ubuntu:jammy
LABEL Description="A docker image to run kairosdb"

# Stop dpkg-reconfigure tzdata from prompting for input
ENV DEBIAN_FRONTEND=noninteractive

# Install openjdk-8 and kairosdb
RUN apt-get update && \
    apt-get -y install --no-install-recommends \
        openjdk-8-jre \
        wget && \
    wget -O /tmp/kairosdb_1.3.0-1_all.deb https://github.com/kairosdb/kairosdb/releases/download/v1.3.0/kairosdb_1.3.0-1_all.deb  && \
    dpkg -i /tmp/kairosdb_1.3.0-1_all.deb && \
# Removing wget and kairosdb.deb binaries
    rm -f /tmp/kairosdb_1.3.0-1_all.deb && \
    dpkg --purge wget && \
    apt-get -y autoremove && \
# Clean up apt setup files
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

EXPOSE 8080 4242

ENTRYPOINT ["/opt/kairosdb/bin/kairosdb.sh", "run"]


