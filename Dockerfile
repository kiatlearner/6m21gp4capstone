FROM debian:bullseye-slim

# RUN is building into the image.

RUN apt update
RUN apt upgrade -y
RUN apt install curl -y
RUN apt install nano -y
RUN apt install apache2 -y
RUN apt install php -y
RUN apt install php-mysqli -y

RUN sed -i "s/Listen 80/Listen 8080/" /etc/apache2/ports.conf

# CMD instruction is executed after container spins up. There can only be 1 CMD.
# If run as BACKGROUND, the container will run and shutdown
CMD ["apache2ctl", "-D", "FOREGROUND"]

#copy git-repo codes to WORKDIR
WORKDIR /var/www/html
COPY index.html .
COPY *.php . 

