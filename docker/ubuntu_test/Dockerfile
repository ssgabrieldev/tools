FROM ubuntu

WORKDIR /root

RUN apt update
RUN apt install build-essential -y
RUN apt install vim -y
RUN apt install curl -y
RUN apt install git -y
RUN apt install unzip -y
RUN apt install snapd -y

EXPOSE 80

CMD ["/bin/bash"]
