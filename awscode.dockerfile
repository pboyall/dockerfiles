#FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine
FROM alpine:latest

USER root

RUN apk update
RUN apk add icu-libs
RUN apk add --no-cache --update python3 python3-dev git jq
RUN apk add curl
RUN apk add --no-cache aws-cli
RUN apk add kubectl
ENV ARCH=amd64
RUN curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_linux_amd64.tar.gz"
RUN tar -xzf eksctl_linux_amd64.tar.gz -C /tmp && rm eksctl_linux_amd64.tar.gz
RUN mv /tmp/eksctl /usr/local/bin
RUN apk update
RUN apk upgrade

#RUN apk add py3-pip
#RUN apk add py3-certifi

#RUN python -m pip install --upgrade certifi

#RUN apk add --no-cache ca-certificates less ncurses-terminfo-base krb5-libs libgcc libintl libssl3 libstdc++ tzdata userspace-rcu zlib 
#RUN  apk -X https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache lttng-ust
#RUN curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.4.3/powershell-7.4.3-linux-musl-x64.tar.gz -o /tmp/powershell.tar.gz
#RUN mkdir -p /opt/microsoft/powershell/7
#RUN  tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7
#RUN chmod +x /opt/microsoft/powershell/7/pwsh
#RUN ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh
#RUN eksctl completion powershell > C:\Users\Documents\WindowsPowerShell\Scripts\eksctl.ps1
#RUN cat ~/.aws/credentials
#CMD pwsh
CMD /bin/ash
