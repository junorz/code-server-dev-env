FROM codercom/code-server:latest

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash - && \
sudo apt-get install -y nodejs && \
sudo corepack enable