FROM registry.access.redhat.com/ubi8
COPY *.sh /opt/
RUN /opt/reg.sh && \
    yum install -y yum-utils createrepo
