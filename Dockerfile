FROM codercom/code-server:latest

RUN sudo apt-get update && \
sudo apt-get -y install libasound2 libc6-i386 libc6-x32 libfreetype6 libxi6 libxrender1 libxtst6

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash - && \
sudo apt-get install -y nodejs && \
sudo corepack enable && \
curl -o jdk.deb https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.deb && \
sudo dpkg -i jdk.deb && \
rm jdk.deb && \
sudo apt-get autoclean && sudo apt-get clean
