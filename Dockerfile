FROM debian:testing

LABEL maintainer Diego Diez <diego10ruiz@gmail.com>

RUN apt-get update -y && \
    apt-get install -y \
      build-essential \
      git \
      python \
      python-setuptools \
      python-six \
      python-pip && \

    pip install numpy && \
    pip install future && \
    pip install pandas && \
    pip install pysam && \
    pip install cython && \

    # install umi_tools.
    cd /tmp && git clone https://github.com/CGATOxford/UMI-tools.git umi_tools && \
    cd umi_tools && git checkout tags/0.4.3 && \
    python setup.py install && \
    #python setup.py install --prefix /opt && \

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
