FROM debian:testing

LABEL maintainer Diego Diez <diego10ruiz@gmail.com>

ENV VERSION=0.5.4

RUN apt-get update -y && \
    apt-get install -y \
      build-essential \
      git \
      python3 \
      python-setuptools \
      python-six \
      python3-pip && \
    # install python modules.
    pip3 install numpy && \
    pip3 install future && \
    pip3 install pandas && \
    pip3 install pysam && \
    pip3 install cython && \
    # install umi_tools.
    cd /tmp && git clone https://github.com/CGATOxford/UMI-tools.git umi_tools && \
    cd umi_tools && git checkout tags/$VERSION && \
    python3 setup.py install && \
    #python3 setup.py install --prefix /opt && \
    # clean up.
    rm -rf tmp/umi_tools && \
    apt-get clean -y && \
    apt-get purge -y \
      build-essential \
      git \
      python-pip && \
    apt-get autoremove -y

#ENV PATH /opt/bin:$PATH
#ENV PYTHONPATH /opt/lib/python2.7/site-packages:$PYTHONPATH

RUN useradd -ms /bin/bash biodev
RUN echo 'biodev:biodev' | chpasswd
USER biodev
WORKDIR /home/biodev
