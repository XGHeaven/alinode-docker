FROM centos:7

RUN yum install wget -y
RUN wget -O- https://raw.githubusercontent.com/aliyun-node/tnvm/master/install.sh | bash

ENV HOME /root

RUN source $HOME/.bashrc && \
    tnvm install "alinode-v4.1.0" && \
    tnvm use "alinode-v4.1.0" && \
    npm install -g @alicloud/agenthub

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
