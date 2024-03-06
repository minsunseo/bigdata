FROM ubuntu:latest

RUN sed -i -e "s|http://archive.ubuntu.com|http://jp.archive.ubuntu.com|g" /etc/apt/sources.list \
 && apt-get -qq update  \
 && DEBIAN_FRONTEND=noninteractive apt-get -qq install --no-install-recommends \
      sudo \
      openjdk-8-jdk \
      vim \
      curl \
      gnupg \
      procps \
      python3 \
      python3-pip \
      python-is-python3 \
      coreutils \
      libc6-dev \
 && rm -rf /var/lib/apt/lists/*

ARG USERNAME=jupyter
ARG GROUPNAME=jupyter
ARG UID=1001
ARG GID=1001

RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
 && chmod 0440 /etc/sudoers.d/$USERNAME \
 && groupadd -g $GID $GROUPNAME \
 && useradd -m -s /bin/bash -u $UID -g $GID $USERNAME

USER $USERNAME

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

# Hadoop
ARG HADOOP_VERSION=3.3.4
# ARG HADOOP_URL=https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz               

ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_CONF_DIR=$HADOOP_HOME/conf

ADD hadoop-3.3.4.tar.gz $HADOOP_HOME

# RUN set -x \
#  && curl -fsSL https://archive.apache.org/dist/hadoop/common/KEYS -o /tmp/hadoop-KEYS \
#  && gpg --import /tmp/hadoop-KEYS \
#  && sudo mkdir $HADOOP_HOME  \
#  && sudo chown $USERNAME:$GROUPNAME -R $HADOOP_HOME \
#  && curl -fsSL $HADOOP_URL -o /tmp/hadoop.tar.gz \
#  && curl -fsSL $HADOOP_URL.asc -o /tmp/hadoop.tar.gz.asc \
#  && gpg --verify /tmp/hadoop.tar.gz.asc \
#  && tar -xf /tmp/hadoop.tar.gz -C $HADOOP_HOME --strip-components 1 \
#  && mkdir $HADOOP_HOME/logs \
#  && rm /tmp/hadoop* \
#  && mkdir -p /tmp/test

RUN set -x \
 && curl -fsSL https://archive.apache.org/dist/hadoop/common/KEYS -o /tmp/hadoop-KEYS \
 && gpg --import /tmp/hadoop-KEYS \
 && sudo mkdir -p $HADOOP_HOME  \
 && sudo chown $USERNAME:$GROUPNAME -R $HADOOP_HOME \
#  && curl -fsSL $HADOOP_URL -o /tmp/hadoop.tar.gz \
#  && curl -fsSL $HADOOP_URL.asc -o /tmp/hadoop.tar.gz.asc \
#  && gpg --verify /tmp/hadoop.tar.gz.asc \
#  && tar -xf /tmp/hadoop-3.3.4.tar.gz -C $HADOOP_HOME --strip-components 1 \
 && mkdir -p $HADOOP_HOME/logs \
 && rm /tmp/hadoop* \
 && mkdir -p /tmp \
 && mkdir -p /tmp/test10

RUN set -x \
 && mv $HADOOP_HOME/hadoop-3.3.4/* $HADOOP_HOME

ENV HADOOP_CONF_DIR=$HADOOP_HOME/conf
ENV PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH

# Spark
ARG SPARK_VERSION=3.3.1
# ARG SPARK_URL=https://archive.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop3.tgz
ENV SPARK_HOME=/opt/spark

ADD spark-3.3.1-bin-hadoop3.tgz $SPARK_HOME

# RUN set -x \
#  && curl -fsSL https://archive.apache.org/dist/spark/KEYS -o /tmp/spark-KEYS  \
#  && gpg --import /tmp/spark-KEYS \
#  && sudo mkdir $SPARK_HOME \
#  && sudo chown $USERNAME:$GROUPNAME -R $SPARK_HOME \
#  && curl -fsSL $SPARK_URL -o /tmp/spark.tgz \
#  && curl -fsSL $SPARK_URL.asc -o /tmp/spark.tgz.asc \
#  && gpg --verify /tmp/spark.tgz.asc \
#  && tar -xf /tmp/spark.tgz -C $SPARK_HOME --strip-components 1 \
#  && rm /tmp/spark* \
#  && curl -fsSL https://jdbc.postgresql.org/download/postgresql-42.3.2.jar -o $SPARK_HOME/jars/postgresql-42.3.2.jar

RUN set -x \
 && curl -fsSL https://archive.apache.org/dist/spark/KEYS -o /tmp/spark-KEYS  \
 && gpg --import /tmp/spark-KEYS \
 && sudo mkdir -p $SPARK_HOME \
 && sudo chown $USERNAME:$GROUPNAME -R $SPARK_HOME \
#  && curl -fsSL $SPARK_URL -o /tmp/spark.tgz \
#  && curl -fsSL $SPARK_URL.asc -o /tmp/spark.tgz.asc \
#  && gpg --verify /tmp/spark.tgz.asc \
#  && tar -xf /tmp/spark-3.3.1-bin-hadoop3.tgz -C $SPARK_HOME --strip-components 1 \
 && rm /tmp/spark* \
 && curl -fsSL https://jdbc.postgresql.org/download/postgresql-42.3.2.jar -o $SPARK_HOME/spark-3.3.1-bin-hadoop3/jars/postgresql-42.3.2.jar

RUN set -x \
 && mv $SPARK_HOME/spark-3.3.1-bin-hadoop3/* $SPARK_HOME

ENV PYTHONHASHSEED=1
ENV PYSPARK_PYTHON=python3
ENV SPARK_CONF_DIR=$SPARK_HOME/conf
ENV PATH=$SPARK_HOME/sbin:$SPARK_HOME/bin:$PATH

# Hive
ARG HIVE_VERSION=3.1.3
# ARG HIVE_URL=https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz
ENV HIVE_HOME=/opt/hive

ADD apache-hive-3.1.3-bin.tar.gz $HIVE_HOME

RUN set -x \
 && curl -fsSL https://archive.apache.org/dist/hive/KEYS -o /tmp/hive-KEYS  \
 && gpg --import /tmp/hive-KEYS \
 && sudo mkdir -p $HIVE_HOME \
 && sudo chown $USERNAME:$GROUPNAME -R $HIVE_HOME \
#  && curl -fsSL $HIVE_URL -o /tmp/hive.tar.gz \
#  && curl -fsSL $HIVE_URL.asc -o /tmp/hive.tar.gz.asc \
#  && gpg --verify /tmp/hive.tar.gz.asc \
#  && tar -xf /tmp/hive.tar.gz -C $HIVE_HOME --strip-components 1 \
 && rm /tmp/hive*

RUN set -x \
&& mv $HIVE_HOME/apache-hive-3.1.3-bin/* $HIVE_HOME

#RUN sudo rm $HIVE_HOME/lib/guava-*.jar \
# && sudo cp $HADOOP_HOME/share/hadoop/hdfs/lib/guava-*.jar $HIVE_HOME/lib/
#RUN mv /opt/hive/lib/log4j-slf4j-impl-2.6.2.jar /opt/hive/lib/log4j-slf4j-impl-2.6.2.jar.bak

ENV HIVE_CONF_DIR=$HIVE_HOME/conf
ENV PATH=$HIVE_HOME/sbin:$HIVE_HOME/bin:$PATH

# Config
COPY --chown=$USERNAME:$GROUPNAME conf/core-site.xml $HADOOP_CONF_DIR/
COPY --chown=$USERNAME:$GROUPNAME conf/hdfs-site.xml $HADOOP_CONF_DIR/
COPY --chown=$USERNAME:$GROUPNAME conf/yarn-site.xml $HADOOP_CONF_DIR/
COPY --chown=$USERNAME:$GROUPNAME conf/mapred-site.xml $HADOOP_CONF_DIR/
COPY --chown=$USERNAME:$GROUPNAME conf/log4j.properties $HADOOP_CONF_DIR/
COPY --chown=$USERNAME:$GROUPNAME conf/workers $HADOOP_CONF_DIR/
COPY --chown=$USERNAME:$GROUPNAME conf/spark-defaults.conf $SPARK_CONF_DIR/
COPY --chown=$USERNAME:$GROUPNAME conf/log4j.properties $SPARK_CONF_DIR/
COPY --chown=$USERNAME:$GROUPNAME conf/hive-site.xml $HIVE_CONF_DIR/

RUN ln $HADOOP_CONF_DIR/workers $SPARK_CONF_DIR/ \
 && ln $HIVE_CONF_DIR/hive-site.xml $SPARK_CONF_DIR/

# # Entry point
# COPY entrypoint.sh /usr/local/sbin/entrypoint.sh
# RUN sudo chmod 777 /usr/local/sbin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]