FROM debian:testing

LABEL maintainer Diego Diez <diego10ruiz@gmail.com>

RUN apt-get -y update && \
    apt-get -y install python && \
    apt-get -y install python-pip && \
    pip install --install-option="--prefix=/opt" umi_tools && \
    apt-get clean -y && \
    apt-get purge -y python-pip && \
    apt-get autoremove -y

ENV PATH /opt/bin:$PATH
ENV PYTHONPATH /opt/lib/python2.7/site-packages:$PYTHONPATH

RUN useradd -ms /bin/bash biodev
RUN echo 'biodev:biodev' | chpasswd
USER biodev
WORKDIR /home/biodev
