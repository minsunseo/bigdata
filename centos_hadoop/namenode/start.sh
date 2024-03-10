#!/bin/bash

# 네임스페이스 디렉토리를 입력받아서 
NAME_DIR=$1
echo $NAME_DIR

# # 비어있지 않다면 이미 포맷된 것이므로 건너뛰고
# if [ "$(ls -A $NAME_DIR)" ]; then
#   echo "NameNode is already formatted."
# # 비어있다면 포맷을 진행
# else
#   echo "Format NameNode."
#   $HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode -format
# fi

# $HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode -format
# echo "Y"

echo 'Y' | $HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode -format

# NameNode 기동
$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode

echo "Starting jupyter notebook..."
# jupyter notebook --allow-root --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token='' --notebook-dir=/notebook
jupyter notebook --allow-root --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token='' 


