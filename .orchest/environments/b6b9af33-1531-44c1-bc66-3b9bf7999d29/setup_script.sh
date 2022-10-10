#!/bin/bash

# Install any dependencies you have in this shell script,
# see https://docs.orchest.io/en/latest/fundamentals/environments.html#install-packages

spark_version="3.3.0"
hadoop_version="3"
spark_checksum="1e8234d0c1d2ab4462d6b0dfe5b54f2851dcd883378e0ed756140e10adfb5be4123961b521140f580e364c239872ea5a9f813a20b73c69cb6d4e95da2575c29c"
openjdk_version="17"

APACHE_SPARK_VERSION="${spark_version}"
HADOOP_VERSION="${hadoop_version}"

sudo apt-get update --yes && \
sudo apt-get install --yes --no-install-recommends \
"openjdk-${openjdk_version}-jre-headless" \
ca-certificates-java && \
sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

# Spark installation
cd /tmp

wget -qO "spark.tgz" "https://archive.apache.org/dist/spark/spark-${APACHE_SPARK_VERSION}/spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz"
echo "${spark_checksum} *spark.tgz" | sha512sum -c - && \
sudo tar xzf "spark.tgz" -C /usr/local --owner root --group root --no-same-owner && \
rm "spark.tgz"

# Configure Spark
SPARK_HOME="/usr/local/spark"
sudo ln -s "spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}" "${SPARK_HOME}"; \
# Add a link in the before_notebook hook in order to source automatically PYTHONPATH && \
sudo mkdir -p /usr/local/bin/before-notebook.d && \
sudo ln -s "${SPARK_HOME}/sbin/spark-config.sh" /usr/local/bin/before-notebook.d/spark-config.sh

echo "export SPARK_HOME=${SPARK_HOME}" >> /home/jovyan/.orchestrc
echo "export SPARK_OPTS=\"--driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info\"" >> /home/jovyan/.orchestrc
echo "export PATH=\"\${PATH}:\${SPARK_HOME}/bin\"" >> /home/jovyan/.orchestrc

# Install pip packages
pip install pyspark==3.3.0