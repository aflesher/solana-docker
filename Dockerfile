FROM rockylinux:8.5

ARG NODE_VERSION=16.14.0

ENV NVM_DIR="/root/.nvm"
ENV NODE_VERSION=$NODE_VERSION

RUN yum update -y && \
	yum install -y curl && \
	yum install -y git && \
	yum install -y gcc && \
	yum install -y which

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
RUN sh -c "$(curl -sSfL https://release.solana.com/v1.9.7/install)"

ENV PATH="/root/.local/share/solana/install/active_release/bin:${PATH}"

RUN [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
	&& nvm install $NODE_VERSION \
	&& nvm alias defaul $NODE_VERSION \
	&& nvm use default

WORKDIR /home/solana