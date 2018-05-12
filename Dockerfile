FROM debian:stretch-slim
MAINTAINER weston bassler <wbassler23@gmail.com>

# Setting ENV Vars for the below Apps
ENV TERRAFORM_URL https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
ENV PACKER_URL https://releases.hashicorp.com/packer/1.2.3/packer_1.2.3_linux_amd64.zip
ENV AWS_CLI_URL https://s3.amazonaws.com/aws-cli/awscli-bundle.zip

# Install some goods.
RUN apt-get update -y \
  && apt-get install -y \
    python \
    python-pip \
    git \
    ansible \
    make \
    curl \
    wget \
    unzip \ 
    apt-transport-https \
    ca-certificates \
    gnupg2 \
    software-properties-common 

#Install Terraform
RUN curl -sL "${TERRAFORM_URL}"> terraform.zip \
  && unzip terraform.zip \
  && mv terraform /usr/local/bin \
  && rm -rf terraform.zip

#Install Packer
RUN curl -sL "${PACKER_URL}" > packer.zip \
  && unzip packer.zip \
  && mv packer /usr/local/bin \
  && rm -rf packer.zip

#Install AWS CLI
RUN curl -sL "${AWS_CLI_URL}" -o "awscli-bundle.zip" \
  && unzip awscli-bundle.zip \
  && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws \
  && rm -rf awscli-bundle.zip

#Install Docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
  && add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" \
  && apt-get update \
  && apt-get install -y \
    docker-ce \
    docker-compose \
  && apt-get clean
