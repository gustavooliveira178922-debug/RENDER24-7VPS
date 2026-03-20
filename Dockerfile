FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Instala dependências
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    git \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Define senha do root
RUN echo "root:root" | chpasswd

# Cria usuário vscode com sudo
RUN useradd -m vscode && echo "vscode:vscode" | chpasswd && adduser vscode sudo

# Permite sudo sem senha (opcional)
RUN echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Instala o code-server (VS Code no navegador)
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Define usuário padrão
USER vscode
WORKDIR /home/vscode

EXPOSE 8080

CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none"]
