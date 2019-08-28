FROM alpine:latest

# Replace 1000 with your user / group id
#RUN export uid=1000 gid=1000 && \
#    mkdir -p /home/developer && \
#    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
#    echo "developer:x:${uid}:" >> /etc/group && \
#    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
#    chmod 0440 /etc/sudoers.d/developer && \
#    chown ${uid}:${gid} -R /home/developer

ARG SERVICE_USER=developer
ARG SERVICE_HOME=/home/developer

RUN \
  adduser -h ${SERVICE_HOME} -s /sbin/nologin -u 1000 -D ${SERVICE_USER} && \
  apk add --no-cache \
    dbus-x11 \
    dumb-init \
    firefox-esr \
    mesa-gl \
    mesa-dri-swrast \
    ttf-freefont

USER    ${SERVICE_USER}
WORKDIR ${SERVICE_HOME}
VOLUME  ${SERVICE_HOME}


CMD /usr/bin/firefox
