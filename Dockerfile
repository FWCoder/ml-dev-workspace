FROM image-registry.openshift-image-registry.svc:5000/openshift/plugin-java8-rhel8:latest
USER root
ADD * /root/workdir/
WORKDIR /root/workdir
RUN microdnf install gcc gcc-c++ python3-devel redhat-rpm-config &&\
  sudo -u jboss sh setup.sh &&\
  curl -L https://github.com/openshift/source-to-image/releases/download/v1.3.0/source-to-image-v1.3.0-eed2850f-linux-amd64.tar.gz | tar -xz -C /home/jboss/.local/bin/ &&\
  echo "export PS1=\"\[\033[36m\][\[\033[m\]\[\033[34m\]\[\e[1m\u@\h \e[0m\] \[\033[32m\]\W\[\033[m\]\[\033[36m\]]\[\033[m\]$ \"" >> /home/jboss/.bashrc &&\
  echo "alias ls='ls --color=auto'" >> /home/jboss/.bashrc &&\
  for f in "/home/jboss"; do \
        chgrp -R 0 ${f} && \
        chmod -R g+rwX ${f}; \
    done
WORKDIR /projects
USER jboss
