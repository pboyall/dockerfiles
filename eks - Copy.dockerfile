FROM ubuntu

USER root

RUN apt-get update && apt-get -y install curl unzip
# apts-transport-https ca-certificates curl gnupg kubectl
RUN apt-get -y install -y apt-transport-https ca-certificates curl gnupg

RUN curl -sS -o /usr/local/bin/aws-iam-authenticator https://s3.us-west-2.amazonaws.com/amazon-eks/1.22.6/2022-03-09/bin/linux/amd64/aws-iam-authenticator 
RUN curl -sS -o /usr/local/bin/kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.22.6/2022-03-09/bin/linux/amd64/kubectl 
RUN curl -sS -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest 
RUN  curl -sS -L https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz | tar xz -C /usr/local/bin 
#RUN mv /tmp/eksctl /usr/local/bin
RUN chmod +x /usr/local/bin/kubectl /usr/local/bin/aws-iam-authenticator /usr/local/bin/ecs-cli /usr/local/bin/eksctl
   
RUN mkdir -p -m 755 /etc/apt/keyrings
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
RUN chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg 
# allow unprivileged APT programs to read this keyring 

RUN echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
RUN chmod 644 /etc/apt/sources.list.d/kubernetes.list
# helps tools such as command-not-found to work correctly
RUN apt-get update
RUN apt-get -y install kubectl

RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o /tmp/awscliv2.zip \
    && unzip -q /tmp/awscliv2.zip -d /opt \
    && /opt/aws/install --update -i /usr/local/aws-cli -b /usr/local/bin \
    && rm /tmp/awscliv2.zip \
    && rm -rf /opt/aws \
    && aws --version

#RUN tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
#RUN apt install -y equivs
#RUN equivs-control libicu72
#COPY . /app
#RUN equivs-build libicu72
#RUN dpkg -i libicu72_1.0_all.deb

RUN apt-get -y install wget

RUN wget https://mirror.it.ubc.ca/ubuntu/pool/main/i/icu/libicu72_72.1-3ubuntu3_amd64.deb
RUN dpkg -i libicu72_72.1-3ubuntu3_amd64.deb
RUN apt-get install -f

#RUN apt-get ca-certificates less ncurses-terminfo-base krb5-libs libgcc libintl libssl3 libstdc++ tzdata userspace-rcu zlib 
#RUN  apt-get -X https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache lttng-ust
#RUN apt-get -y install libicu74 wget

RUN wget https://github.com/PowerShell/PowerShell/releases/download/v7.4.3/powershell_7.4.3-1.deb_amd64.deb
RUN dpkg -i powershell_7.4.3-1.deb_amd64.deb
RUN apt-get install -f

# Delete the downloaded package file
#RUN curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.4.3/powershell_7.4.3-1.deb_amd64.deb -o /tmp/powershell.tar.gz
#RUN rm powershell_7.4.3-1.deb_amd64.deb
#RUN mkdir -p /opt/microsoft/powershell/7
#RUN tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7
#RUN chmod +x /opt/microsoft/powershell/7/pwsh
#RUN ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh


#ARG POWERSHELL_VERSION=7.2.11
#ARG POWERSHELL_DOWNLOAD_URL=https://github.com/PowerShell/PowerShell/releases/download/v$POWERSHELL_VERSION/powershell-$POWERSHELL_VERSION-linux-x64.tar.gz
#ARG POWERSHELL_DOWNLOAD_SHA=9D6F798461D172391B508FCF27F9CBBB4BEF307EBFD6886ED50860C322C7D1B3

#RUN set -ex \
#    && curl -SL $POWERSHELL_DOWNLOAD_URL --output powershell.tar.gz \
#    && echo "$POWERSHELL_DOWNLOAD_SHA powershell.tar.gz" | sha256sum -c - \
#    && mkdir -p /opt/microsoft/powershell/$POWERSHELL_VERSION \
#    && tar zxf powershell.tar.gz -C /opt/microsoft/powershell/$POWERSHELL_VERSION \
#    && rm powershell.tar.gz \
#    && ln -s /opt/microsoft/powershell/$POWERSHELL_VERSION/pwsh /usr/bin/pwsh

