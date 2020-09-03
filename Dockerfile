FROM jenkins/inbound-agent:4.3-8-jdk11

ARG TF_12_VERSION=0.12.29
ARG TF_13_VERSION=0.13.2
ARG TFENV_DIR=/opt/tfenv

USER root

RUN apt-get update \
  && apt-get upgrade -y \
  && git clone https://github.com/tfutils/tfenv.git ${TFENV_DIR} \
  && ln -s ${TFENV_DIR}/bin/* /usr/local/bin \
  && touch ${TFENV_DIR}/version \
  && chmod 777 ${TFENV_DIR}/version \
  && tfenv install ${TF_12_VERSION} \
  && tfenv install ${TF_13_VERSION} \
  && tfenv use 0.12.29 \
  && curl -sL https://aka.ms/InstallAzureCLIDeb | bash \
  && az extension add --name subscription \
  && wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb \
  && dpkg -i packages-microsoft-prod.deb \
  && apt-get update \
  && apt-get install -y powershell make \
  && rm -rf /var/lib/apt/lists/* \
  && /usr/bin/pwsh -Command "Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted; \
                            Install-Module -Name Az -Scope AllUsers -AllowClobber -Force; \
                            Install-Module -Name Az.Subscription -Scope AllUsers -AllowClobber -Force; \
                            Install-Module -Name Az.Security -Scope AllUsers -AllowClobber -Force; " 

USER jenkins