FROM centos:latest

RUN yum update -y
RUN yum install -y epel-release && rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
RUN curl -o /etc/yum.repos.d/liquidsoap.repo http://download.opensuse.org/repositories/home:/radiorabe:/liquidsoap/CentOS_7/home:radiorabe:liquidsoap.repo
RUN yum install -y liquidsoap
RUN yum install -y file
RUN curl -o /etc/yum.repos.d/dab.repo http://download.opensuse.org/repositories/home:/radiorabe:/dab/CentOS_7/home:radiorabe:dab.repo
RUN yum install -y mk_liquidsoap_processing
RUN yum install -y alsa-utils
RUN yum install -y odr-audioenc

RUN mkdir -p /var/log/liquidsoap
RUN chown liquidsoap:liquidsoap /var/log/liquidsoap

RUN usermod -G audio -a liquidsoap
RUN mkdir -p /srv/archive
RUN chown liquidsoap /srv/archive
COPY src/*.liq /etc/liquidsoap/
COPY dabplus-on-air-processing.conf /etc/liquidsoap/dabplus-on-air-processing.conf

USER liquidsoap

CMD ["/usr/bin/liquidsoap", "--debug", "--verbose", "/etc/liquidsoap/dabplus-on-air-processing.liq"]
