# GitLab-ce docker image builder for arm64v8

Compatible with **arm64v8** architectural.

Images are built here: https://github.com/yrzr/gitlab-ce-arm64v8-docker

Docker image: https://hub.docker.com/r/yrzr/gitlab-ce-arm64v8

Old builds on gitlab-ci: https://git.yrzr.tk/docker/gitlab-ce-arm64

## How to use

The official image (AMD64 only) is [here](https://hub.docker.com/r/gitlab/gitlab-ce/).

The following is an example of how to use this image.

```bash
docker run \
  --detach \
  --restart unless-stopped \
  --name gitlab-ce \
  --privileged \
  --memory 8G \
  --publish 22:22 \
  --publish 80:80 \
  --publish 443:443 \
  --publish 127.0.0.1:8181:8181 \
  --hostname gitlab.example.com \
  --env GITLAB_ROOT_PASSWORD="YourPasswordHere" \
  --env GITLAB_OMNIBUS_CONFIG=" \
    registry['enable'] = false; \
    GITLAB_OMNIBUS[your_other_configs] = here; "\
  --volume /srv/gitlab-ce/conf:/etc/gitlab:z \
  --volume /srv/gitlab-ce/logs:/var/log/gitlab:z \
  --volume /srv/gitlab-ce/data:/var/opt/gitlab:z \
  yrzr/gitlab-ce-arm64v8:latest
```

Since `16.2.1-ce.0`, you can also use tags like `yrzr/gitlab-ce-arm64v8:16.2` and `yrzr/gitlab-ce-arm64v8:16`.

## Redis problem

Redis cannot start with its default config on ARM64, which stops gitlab-ce from starting. You have to change the setting manually on a fresh install or an upgrade and then restart gitlab-ce.

```bash
# change the path to your redis.conf
echo "ignore-warnings ARM64-COW-BUG" >> /srv/gitlab-ce/data/redis/redis.conf
# restart docker container
docker restart gitlab-ce
```
