
# Run Mirrors

## Yum/RPM - RHEL/CentOS
* CentOS Mirroring
```
docker run \
  -it --rm \
  -v `pwd`:/opt \
  -v `pwd`/mirrors:/mirrors \
  --dns=1.1.1.1 \
  centos:7 \
  bash /opt/bin/centos-cache.sh
```

* RHEL7

* RHEL8

## Apt/Deb - Debian/Ubuntu

```
docker run \
  -it --rm \
  -v `pwd`:/opt \
  -v `pwd`/mirrors:/mirrors \
  --dns=1.1.1.1 \
  debian \
  bash /opt/bin/apt-cache.sh
```

## Apk - Alpine

```
```

## Rsync

## Others

* PyPI - Full Mirrors

```
docker run \
  -it --rm \
  -v /mirrors/pypi:/srv/pypi \
  chiefware/bandersnatch \
  bandersnatch mirror

```

# Start Web Server

```
docker run -d \
  --restart=always \
  --name httpd \
  -p 8080:80 \
  -v /mirrors/:/usr/share/nginx/html:ro \
  jrelva/nginx-autoindex
```

