FROM dcoxall/debian
MAINTAINER André Luís Lopes <andrelop@andrelop.org>
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get -y install openssh-server supervisor
RUN mkdir -p /var/run/sshd
ADD supervisord.conf /etc/supervisor/supervisord.conf
RUN echo "root:root" | chpasswd
EXPOSE 22
CMD ["/usr/bin/supervisord"]
