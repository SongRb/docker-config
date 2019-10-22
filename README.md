# OpenSpark

## Introduction

The open environment to run any Spark applications.

* Docker image to run in Linux/MacOS/Windows
* Install Hadoop, Spark, Hive within one minute
* Submit job to local and remote Yarn clusters
* Repeatable examples of PySpark/Spark streaming/
* A comfortable development toolset with ptpython/vim installed

## Usage

Run the container.

```
docker run -it --net=host -v /:/host songrb/openspark bash
```

Setup the cluster.

```
/scripts/setup.sh
```

Run the examples.

```
git clone https://github.com/tobegit3hub/spark_examples
cd ./spark_examples/dataframe_examples/
./create_dataframe_from_memory.sh
```

## Examples

### Run PySpark

```
/examples/read_json_dataframe.py
```

### Submit Yarn Jobs

```
cd ./spark_examples/dataframe_examples/
./create_dataframe_from_memory.sh
```

If you are using yarn-client mode, make sure you have run container with `--net=host` and set `spark.driver.host` with host's IP for Spark session.

```

val conf = new SparkConf()
             .setMaster("yarn")
             .setAppName("foo")
             .set("spark.driver.host", "$HOST_IP")
```

## Hadoop Cluster

We can use external Hadoop cluster by copying its configuration files in the container.

```bash
cp /host/my_hadoop_conf/* /usr/local/hadoop/etc/hadoop/
```

## Spark Version

OpenSpark have supported latest Spark and Hive version:

* spark-2.3.4-bin-hadoop2.7
* hive-2.3.6-bin-hadoop2.7

