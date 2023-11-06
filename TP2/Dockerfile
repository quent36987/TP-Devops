# Utiliser une image de base Python slim pour un conteneur léger
FROM python:3.9-slim-bullseye

# Installer les dépendances nécessaires
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-utils \
    gcc \
    python3-dev \
    libffi-dev \
    libssl-dev \
    libkrb5-dev \
    curl \
    ssh \
    && rm -rf /var/lib/apt/lists/*

# Installer Ansible via pip
RUN pip3 install --no-cache-dir --upgrade pip cffi && \
    pip3 install --no-cache-dir ansible pywinrm[kerberos]

# Installer Docker CLI pour interagir avec le daemon Docker de l'hôte
RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    rm get-docker.sh

# Installer les collections Ansible nécessaires
# RUN ansible-galaxy collection install community.docker

# Copier les playbooks Ansible dans le conteneur
#COPY ansible/ /ansible/
COPY .vault_pass.txt .
RUN cat .vault_pass.txt > pass
# Définir le répertoire de travail

COPY requirements.yml .

RUN ansible-galaxy install -r requirements.yml

WORKDIR /ansible

CMD ["tail", "-f", "/dev/null"]
# Exécuter le playbook Ansible en utilisant l'inventaire par défaut
#CMD ["ansible-playbook", "-i", "localhost/hosts", "playbook.yml", "--vault-password-file", "pass"]
