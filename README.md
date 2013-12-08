Short Description
=================

Basic Debian Wheezy container using supervisord to start sshd.

Full Description
================

Basic Debian Wheezy container using supervisord to start sshd.
Built based on dcoxall/debian. It's already exposing port 22 so it could be ran using :

	# docker pull andrelop/docker-debian
	# docker run -p 2222:22 -d andrelop/docker-debian

One could connect to the container via ssh from within the Docker host using :

	# ssh root@127.0.0.1 -p 2222

Default root password is "root".

The supervisord.conf file copied to the container during "docker build" was :

	[supervisord]
	nodaemon=true
	
	[program:sshd]
	command=/usr/sbin/sshd -D
	autorestart=true
	Dockerfile*

This is the Dockerfile that was used to build this repo


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
