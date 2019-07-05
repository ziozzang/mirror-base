#!/bin/bash
docker rm -f pypi
docker run \
  --name pypi --rm -v /mirrors/pypi:/srv/pypi \
  chiefware/bandersnatch bandersnatch mirror
