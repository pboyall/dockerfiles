FROM ubuntu

USER root

RUN apt-get update && apt-get -y install curl unzip
# apts-transport-https ca-certificates curl gnupg kubectl
RUN apt-get -y install -y apt-transport-https ca-certificates curl gnupg

RUN apt-get -y install wget

RUN wget https://mirror.it.ubc.ca/ubuntu/pool/main/i/icu/libicu72_72.1-3ubuntu3_amd64.deb
RUN dpkg -i libicu72_72.1-3ubuntu3_amd64.deb
RUN apt-get install -f

RUN wget https://github.com/PowerShell/PowerShell/releases/download/v7.4.3/powershell_7.4.3-1.deb_amd64.deb
RUN dpkg -i powershell_7.4.3-1.deb_amd64.deb
RUN apt-get install -f

RUN curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc
RUN curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | tee /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y mssql-tools18 unixodbc-dev
RUN echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bash_profile

#/opt/mssql-tools/bin/sqlcmd -S localhost -U username -P 'djdjddkd'
