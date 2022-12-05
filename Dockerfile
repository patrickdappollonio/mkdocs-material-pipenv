FROM alpine:3.17

# Install default apps like python, bash, sudo and git,
# then configure bash as the default shell, then add a
# "docker" user with passwordless sudo access.
RUN \
  apk add --no-cache bash python3=~3.10 sudo git && \
  sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd && \
  adduser -D -g "docker" docker && adduser docker wheel && \
  echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER docker
WORKDIR /mkdocs

# Define environment variables for Python inside the container
ENV PATH="${PATH}:/usr/lib/python3.10/site-packages:/home/docker/.local/bin" \
  PYTHONDONTWRITEBYTECODE=1 \
  PYTHONUNBUFFERED=1 \
  PYTHONPATH=/usr/bin/python3 \
  HOME="/home/docker" \
  LANG=en_US.UTF-8

# Install pip (if it wasn't installed) and install our deps
RUN python3 -m ensurepip && \
  python3 -m pip install --no-cache-dir --upgrade \
  pip pipenv \
  'mkdocs-material==8.4.*' \
  'mkdocs-awesome-pages-plugin==2.8.*' \
  'mkdocs-git-revision-date-localized-plugin==1.1.*' \
  'mdx_truly_sane_lists==1.3.*' \
  'mkdocs-glightbox==0.2.1'

CMD ["/bin/bash"]
