FROM       i386/ubuntu:12.04

RUN apt-get update

RUN apt-get install -y openssh-server
RUN apt-get install vim fakeroot build-essential flex bison automake \
	libncurses5-dev lzma-dev liblzma-dev lzma binutils-dev libtool \
	liblzo2-dev uuid-dev zlib1g-dev dos2unix automake1.7 libstdc++5 gawk
	
RUN	apt-get install git

RUN mkdir -p /var/run/sshd

RUN echo 'root:1234' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir -p /root/.ssh
RUN mkdir -p /opt/trendchip

#RUN apt-get clean && \
#    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22:22

CMD    ["/usr/sbin/sshd", "-D", "-d"]
