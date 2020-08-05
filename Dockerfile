FROM jenkins/inbound-agent:4.3-8-jdk11

ARG TF_VERSION=0.12.29

USER root

RUN apt-get update \
  && apt-get upgrade -y \
  && curl -sL https://aka.ms/InstallAzureCLIDeb | bash \
  && curl -o /tmp/tf.zip https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip \
  && unzip /tmp/tf.zip -d /usr/local/bin \
  && rm /tmp/tf.zip \
  && wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb \
  && dpkg -i packages-microsoft-prod.deb \
  && apt-get update \
  && apt-get install -y powershell make \
  && rm -rf /var/lib/apt/lists/* \
  && /usr/bin/pwsh -Command "Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted; \
                            Install-Module -Name Az -Scope AllUsers -AllowClobber -Force;"

USER jenkins