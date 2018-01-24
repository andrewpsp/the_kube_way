
From ubuntu
LABEL vendor=Entercloud\ LLC \
      Hello-Api.Project=Hello-Api.0 \
      Hello-Api.Client="Hello-client" \
      Hello-Api.version="0.0.1" \
      Hello-Api.release-date="2018-6-1"


RUN apt-get update && apt-get install -y && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | && \
    sudo tee /etc/apt/sources.list.d/azure-cli.list && \
    apt-key adv --keyserver packages.microsoft.com --recv- \ 52E16F86FEE04B979B07E28DB02C46DF417A0893 && \
    apt-get install apt-transport-https && \
    apt-get update && sudo apt-get install azure-cli && \
    rm -rf /var/lib/apt/lists/* && \
    python get-pip.py && \
    pip install azure-cli && \
    pip install gcloud && \
    pip install python-openstackclient

COPY . /opt/hello-api
WORKDIR /opt/hello-api



