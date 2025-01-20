FROM alpine:3.21

# Install default apps like python, bash, sudo and git,
# then configure bash as the default shell, then add a
# "docker" user with passwordless sudo access.
RUN apk add --no-cache bash python3 sudo git && \
  sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd && \
  adduser -D -g "docker" docker && adduser docker wheel && \
  echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
  mkdir -p /venv && chown -R docker:docker /venv

USER docker
WORKDIR /mkdocs
ADD Pipfile /mkdocs/Pipfile
ADD Pipfile.lock /mkdocs/Pipfile.lock

# Define environment variables for Python inside the container
ENV PYTHONDONTWRITEBYTECODE=1 \
  PYTHONUNBUFFERED=1 \
  PYTHONPATH=/usr/bin/python3 \
  HOME="/home/docker" \
  LANG=en_US.UTF-8 \
  PIPENV_SYSTEM=1

# Install pip (if it wasn't installed) and install our deps
RUN python3 -m venv /venv
ENV PATH="/venv/bin:${PATH}"
RUN pip install --no-cache-dir --upgrade pipenv && \
  pipenv --python=/usr/bin/python3 sync

CMD ["/bin/bash"]
