FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

COPY ./conf/sources.list /etc/apt/sources.list

RUN apt update -y
RUN apt upgrade -y
RUN apt install -y --fix-missing software-properties-common curl wget bzip2 zip htop ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 git openssh-server maven krb5-user vim iputils-ping unzip rsync pkg-config build-essential libfreetype6-dev libzmq3-dev python python-dev


# Install Java
RUN add-apt-repository -y ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    openjdk-8-jdk openjdk-8-jre-headless
    
COPY ./conf/settings.xml /etc/maven/settings.xml

# Install Hadoop
ENV HADOOP_VERSION=2.7.7
RUN curl -O https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/core/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz
RUN tar xfz ./hadoop-${HADOOP_VERSION}.tar.gz
RUN rm ./hadoop-${HADOOP_VERSION}.tar.gz
RUN mv ./hadoop-${HADOOP_VERSION} /usr/local/hadoop/

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME /usr/local/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin
ENV HADOOP_INSTALL /usr/local/hadoop
ENV HADOOP_HDFS_HOME $HADOOP_INSTALL
ENV HADOOP_COMMON_LIB_NATIVE_DIR $HADOOP_INSTALL/lib/native
ENV HADOOP_OPTS "-Djava.library.path=$HADOOP_INSTALL/lib/native"
ENV HADOOP_CONF_DIR $HADOOP_HOME/etc/hadoop
ENV HADOOP_PREFIX $HADOOP_HOME
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:$JAVA_HOME/jre/lib/amd64/server
ENV CLASSPATH /usr/local/hadoop/etc/hadoop:/usr/local/hadoop/share/hadoop/common/lib/httpcore-4.2.5.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-configuration-1.6.jar:/usr/local/hadoop/share/hadoop/common/lib/jackson-xc-1.9.13.jar:/usr/local/hadoop/share/hadoop/common/lib/gson-2.2.4.jar:/usr/local/hadoop/share/hadoop/common/lib/snappy-java-1.0.4.1.jar:/usr/local/hadoop/share/hadoop/common/lib/jaxb-api-2.2.2.jar:/usr/local/hadoop/share/hadoop/common/lib/paranamer-2.3.jar:/usr/local/hadoop/share/hadoop/common/lib/apacheds-kerberos-codec-2.0.0-M15.jar:/usr/local/hadoop/share/hadoop/common/lib/netty-3.6.2.Final.jar:/usr/local/hadoop/share/hadoop/common/lib/hadoop-annotations-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/common/lib/api-asn1-api-1.0.0-M20.jar:/usr/local/hadoop/share/hadoop/common/lib/xz-1.0.jar:/usr/local/hadoop/share/hadoop/common/lib/java-xmlbuilder-0.4.jar:/usr/local/hadoop/share/hadoop/common/lib/jetty-util-6.1.26.jar:/usr/local/hadoop/share/hadoop/common/lib/slf4j-api-1.7.10.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-cli-1.2.jar:/usr/local/hadoop/share/hadoop/common/lib/servlet-api-2.5.jar:/usr/local/hadoop/share/hadoop/common/lib/jsp-api-2.1.jar:/usr/local/hadoop/share/hadoop/common/lib/protobuf-java-2.5.0.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-io-2.4.jar:/usr/local/hadoop/share/hadoop/common/lib/curator-recipes-2.7.1.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-compress-1.4.1.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-beanutils-1.7.0.jar:/usr/local/hadoop/share/hadoop/common/lib/mockito-all-1.8.5.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-lang-2.6.jar:/usr/local/hadoop/share/hadoop/common/lib/curator-client-2.7.1.jar:/usr/local/hadoop/share/hadoop/common/lib/jersey-json-1.9.jar:/usr/local/hadoop/share/hadoop/common/lib/jackson-jaxrs-1.9.13.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-httpclient-3.1.jar:/usr/local/hadoop/share/hadoop/common/lib/zookeeper-3.4.6.jar:/usr/local/hadoop/share/hadoop/common/lib/curator-framework-2.7.1.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-net-3.1.jar:/usr/local/hadoop/share/hadoop/common/lib/xmlenc-0.52.jar:/usr/local/hadoop/share/hadoop/common/lib/avro-1.7.4.jar:/usr/local/hadoop/share/hadoop/common/lib/jettison-1.1.jar:/usr/local/hadoop/share/hadoop/common/lib/jackson-mapper-asl-1.9.13.jar:/usr/local/hadoop/share/hadoop/common/lib/api-util-1.0.0-M20.jar:/usr/local/hadoop/share/hadoop/common/lib/activation-1.1.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-codec-1.4.jar:/usr/local/hadoop/share/hadoop/common/lib/stax-api-1.0-2.jar:/usr/local/hadoop/share/hadoop/common/lib/apacheds-i18n-2.0.0-M15.jar:/usr/local/hadoop/share/hadoop/common/lib/jersey-server-1.9.jar:/usr/local/hadoop/share/hadoop/common/lib/jackson-core-asl-1.9.13.jar:/usr/local/hadoop/share/hadoop/common/lib/hadoop-auth-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/common/lib/jetty-6.1.26.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-beanutils-core-1.8.0.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-collections-3.2.2.jar:/usr/local/hadoop/share/hadoop/common/lib/junit-4.11.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-digester-1.8.jar:/usr/local/hadoop/share/hadoop/common/lib/hamcrest-core-1.3.jar:/usr/local/hadoop/share/hadoop/common/lib/jersey-core-1.9.jar:/usr/local/hadoop/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar:/usr/local/hadoop/share/hadoop/common/lib/jsch-0.1.42.jar:/usr/local/hadoop/share/hadoop/common/lib/jaxb-impl-2.2.3-1.jar:/usr/local/hadoop/share/hadoop/common/lib/guava-11.0.2.jar:/usr/local/hadoop/share/hadoop/common/lib/httpclient-4.2.5.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-logging-1.1.3.jar:/usr/local/hadoop/share/hadoop/common/lib/htrace-core-3.1.0-incubating.jar:/usr/local/hadoop/share/hadoop/common/lib/asm-3.2.jar:/usr/local/hadoop/share/hadoop/common/lib/jsr305-3.0.0.jar:/usr/local/hadoop/share/hadoop/common/lib/commons-math3-3.1.1.jar:/usr/local/hadoop/share/hadoop/common/lib/jets3t-0.9.0.jar:/usr/local/hadoop/share/hadoop/common/lib/log4j-1.2.17.jar:/usr/local/hadoop/share/hadoop/common/hadoop-common-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/common/hadoop-common-${HADOOP_VERSION}-tests.jar:/usr/local/hadoop/share/hadoop/common/hadoop-nfs-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/hdfs:/usr/local/hadoop/share/hadoop/hdfs/lib/commons-daemon-1.0.13.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/netty-3.6.2.Final.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/xercesImpl-2.9.1.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jetty-util-6.1.26.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/commons-cli-1.2.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/servlet-api-2.5.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/netty-all-4.0.23.Final.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/protobuf-java-2.5.0.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/commons-io-2.4.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/leveldbjni-all-1.8.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/commons-lang-2.6.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/xmlenc-0.52.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jackson-mapper-asl-1.9.13.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/commons-codec-1.4.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jersey-server-1.9.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jackson-core-asl-1.9.13.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jetty-6.1.26.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jersey-core-1.9.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/guava-11.0.2.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/commons-logging-1.1.3.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/htrace-core-3.1.0-incubating.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/asm-3.2.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/jsr305-3.0.0.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/xml-apis-1.3.04.jar:/usr/local/hadoop/share/hadoop/hdfs/lib/log4j-1.2.17.jar:/usr/local/hadoop/share/hadoop/hdfs/hadoop-hdfs-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/hdfs/hadoop-hdfs-${HADOOP_VERSION}-tests.jar:/usr/local/hadoop/share/hadoop/hdfs/hadoop-hdfs-nfs-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/yarn/lib/jackson-xc-1.9.13.jar:/usr/local/hadoop/share/hadoop/yarn/lib/jaxb-api-2.2.2.jar:/usr/local/hadoop/share/hadoop/yarn/lib/jersey-client-1.9.jar:/usr/local/hadoop/share/hadoop/yarn/lib/netty-3.6.2.Final.jar:/usr/local/hadoop/share/hadoop/yarn/lib/xz-1.0.jar:/usr/local/hadoop/share/hadoop/yarn/lib/aopalliance-1.0.jar:/usr/local/hadoop/share/hadoop/yarn/lib/jetty-util-6.1.26.jar:/usr/local/hadoop/share/hadoop/yarn/lib/commons-cli-1.2.jar:/usr/local/hadoop/share/hadoop/yarn/lib/servlet-api-2.5.jar:/usr/local/hadoop/share/hadoop/yarn/lib/protobuf-java-2.5.0.jar:/usr/local/hadoop/share/hadoop/yarn/lib/commons-io-2.4.jar:/usr/local/hadoop/share/hadoop/yarn/lib/commons-compress-1.4.1.jar:/usr/local/hadoop/share/hadoop/yarn/lib/javax.inject-1.jar:/usr/local/hadoop/share/hadoop/yarn/lib/leveldbjni-all-1.8.jar:/usr/local/hadoop/share/hadoop/yarn/lib/commons-lang-2.6.jar:/usr/local/hadoop/share/hadoop/yarn/lib/jersey-json-1.9.jar:/usr/local/hadoop/share/hadoop/yarn/lib/jackson-jaxrs-1.9.13.jar:/usr/local/hadoop/share/hadoop/yarn/lib/zookeeper-3.4.6.jar:/usr/local/hadoop/share/hadoop/yarn/lib/jersey-guice-1.9.jar:/usr/local/hadoop/share/hadoop/yarn/lib/jettison-1.1.jar:/usr/local/hadoop/share/hadoop/yarn/lib/jackson-mapper-asl-1.9.13.jar:/usr/local/hadoop/share/hadoop/yarn/lib/zookeeper-3.4.6-tests.jar:/usr/local/hadoop/share/hadoop/yarn/lib/activation-1.1.jar:/usr/local/hadoop/share/hadoop/yarn/lib/commons-codec-1.4.jar:/usr/local/hadoop/share/hadoop/yarn/lib/stax-api-1.0-2.jar:/usr/local/hadoop/share/hadoop/yarn/lib/guice-3.0.jar:/usr/local/hadoop/share/hadoop/yarn/lib/guice-servlet-3.0.jar:/usr/local/hadoop/share/hadoop/yarn/lib/jersey-server-1.9.jar:/usr/local/hadoop/share/hadoop/yarn/lib/jackson-core-asl-1.9.13.jar:/usr/local/hadoop/share/hadoop/yarn/lib/jetty-6.1.26.jar:/usr/local/hadoop/share/hadoop/yarn/lib/commons-collections-3.2.2.jar:/usr/local/hadoop/share/hadoop/yarn/lib/jersey-core-1.9.jar:/usr/local/hadoop/share/hadoop/yarn/lib/jaxb-impl-2.2.3-1.jar:/usr/local/hadoop/share/hadoop/yarn/lib/guava-11.0.2.jar:/usr/local/hadoop/share/hadoop/yarn/lib/commons-logging-1.1.3.jar:/usr/local/hadoop/share/hadoop/yarn/lib/asm-3.2.jar:/usr/local/hadoop/share/hadoop/yarn/lib/jsr305-3.0.0.jar:/usr/local/hadoop/share/hadoop/yarn/lib/log4j-1.2.17.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-server-tests-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-api-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-server-nodemanager-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-server-applicationhistoryservice-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-server-common-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-registry-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-server-sharedcachemanager-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-client-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-applications-unmanaged-am-launcher-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-server-resourcemanager-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-applications-distributedshell-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-common-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/yarn/hadoop-yarn-server-web-proxy-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/snappy-java-1.0.4.1.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/paranamer-2.3.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/netty-3.6.2.Final.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/hadoop-annotations-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/xz-1.0.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/aopalliance-1.0.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/protobuf-java-2.5.0.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/commons-io-2.4.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/commons-compress-1.4.1.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/javax.inject-1.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/leveldbjni-all-1.8.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/jersey-guice-1.9.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/avro-1.7.4.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/jackson-mapper-asl-1.9.13.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/guice-3.0.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/guice-servlet-3.0.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/jersey-server-1.9.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/jackson-core-asl-1.9.13.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/junit-4.11.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/hamcrest-core-1.3.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/jersey-core-1.9.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/asm-3.2.jar:/usr/local/hadoop/share/hadoop/mapreduce/lib/log4j-1.2.17.jar:/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-hs-plugins-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-hs-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-common-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-app-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-${HADOOP_VERSION}-tests.jar:/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-core-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-${HADOOP_VERSION}.jar:/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-shuffle-${HADOOP_VERSION}.jar:/contrib/capacity-scheduler/*.jar


# Install Spark
RUN curl -O https://mirrors.tuna.tsinghua.edu.cn/apache/spark/spark-2.3.4/spark-2.3.4-bin-hadoop2.7.tgz
RUN tar xzvf ./spark-2.3.4-bin-hadoop2.7.tgz
RUN rm ./spark-2.3.4-bin-hadoop2.7.tgz
RUN mv ./spark-2.3.4-bin-hadoop2.7 /usr/local/spark/
ENV SPARK_HOME /usr/local/spark/

# Install Hive
ENV HIVE_VERSION 2.3.6
RUN curl -O https://mirrors.tuna.tsinghua.edu.cn/apache/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz
ENV HIVE_HOME /usr/local/hive-${HIVE_VERSION}
ENV PATH $PATH:${HIVE_HOME}/bin

RUN tar -xzvf apache-hive-${HIVE_VERSION}-bin.tar.gz && mv apache-hive-${HIVE_VERSION}-bin $HIVE_HOME
COPY ./conf/hive-site.xml $SPARK_HOME/conf/hive-site.xml
COPY ./conf/hive-site.xml $HIVE_HOME/conf/hive-site.xml

ENV PATH $PATH:$HADOOP_HOME/bin:$SPARK_HOME/bin:$HIVE_HOME/bin
ENV HADOOP_USER_NAME work


# Setup sshd
RUN mkdir -p /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ADD ./external_jars/ /external_jars/
ADD ./local_hadoop_conf/ /usr/local/hadoop/etc/hadoop/
ADD ./scripts/ /scripts/
ADD ./examples/ /examples/

# Setup Python
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN curl -o anaconda.sh https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-2019.10-Linux-x86_64.sh 
RUN /bin/bash ./anaconda.sh -b -p /opt/conda && \
    rm ./anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN mkdir -p ~/.config/pip
COPY ./conf/pip.conf ~/.config/pip/pip.conf
RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/

# RUN pip install -i http://mirrors.aliyun.com/pypi/simple/  --trusted-host mirrors.aliyun.com ptpython pyspark
RUN pip install -i http://mirrors.aliyun.com/pypi/simple/  --trusted-host mirrors.aliyun.com ptpython
RUN mkdir ~/.ptpython
COPY ./conf/config.py  ~/.ptpython

# Setup bash
COPY ./conf/.bashrc .bashrc_extra
RUN cat .bashrc_extra >> ~/.bashrc

# Setup vim
RUN git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh

CMD ["bash"]
