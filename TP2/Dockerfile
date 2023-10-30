FROM python:3.9.18-slim-bullseye

RUN apt update

RUN curl -fsSL https://get.docker.com | sh

RUN apt-get update && \
  apt-get install -y gcc python-dev libkrb5-dev && \
  apt-get install python3-pip -y && \
  pip3 install --upgrade pip && \
  pip3 install --upgrade virtualenv && \
  pip3 install pywinrm[kerberos] && \
  apt install krb5-user -y && \
  pip3 install pywinrm && \
  pip3 install ansible

COPY ansible/ .

RUN ansible-playbook -i inventory playbook.yml
