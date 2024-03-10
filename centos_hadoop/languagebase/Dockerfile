FROM centos

MAINTAINER cattmerry@gmail.com

RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum install -y wget
RUN yum -y groupinstall "Development Tools"
RUN yum -y install openssl-devel bzip2-devel libffi-devel

ENV PYTHON_VERSION=3.7.6
ENV PYTHON_URL=https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz

# python install
RUN wget $PYTHON_URL
RUN tar -xvzf Python-$PYTHON_VERSION.tgz && rm Python-$PYTHON_VERSION.tgz
RUN /Python-$PYTHON_VERSION/configure --enable-optimizations
RUN make altinstall
RUN ln -s /usr/local/bin/python3.7 /usr/bin/python3
RUN ln -s /usr/local/bin/python3.7 /usr/bin/python

#jupyter install
RUN dnf makecache
RUN dnf install -y python3-pip
RUN pip3 install --upgrade setuptools
RUN pip3 install --upgrade pip
RUN pip3 install jupyter 
RUN ln -s /usr/local/bin/pip3 /usr/bin/pip

RUN pip install -U pip &&\
    pip install --no-cache-dir \
    openpyxl \
    pyspark \
    findspark \
    # tensorflow-serving-api \
    pandas 

## RUN jupyter notebook --allow-root

# java install
RUN yum install -y java-1.8.0-openjdk.x86_64
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.312.b07-2.el8_5.x86_64/jre
