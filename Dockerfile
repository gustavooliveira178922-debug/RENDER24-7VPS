 # Usa uma imagem base leve
FROM ubuntu:22.04

# Evita perguntas durante instalação
ENV DEBIAN_FRONTEND=noninteractive

# Atualiza e instala dependências
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    git \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Cria usuário (boa prática)
RUN useradd -m vscode && echo "vscode:vscode" | chpasswd && adduser vscode sudo

# Instala o code-server (VS Code no browser)
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Define usuário
USER vscode
WORKDIR /home/vscode

# Expõe porta padrão
EXPOSE 8080

# Comando padrão para iniciar o VS Code
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none"]
