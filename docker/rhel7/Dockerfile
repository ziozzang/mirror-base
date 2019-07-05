FROM registry.access.redhat.com/rhel
COPY *.sh /opt/
RUN /opt/reg.sh && \
    yum install -y yum-utils createrepo
