FROM ubuntu:latest

WORKDIR /home/ubuntu

# Install base packages
RUN apt-get update && apt-get install -y \
  curl \
  wget \
  unzip \
  software-properties-common \
  gnupg \
  vim \
  && rm -rf /var/lib/apt/lists/*

CMD ["bash"]
