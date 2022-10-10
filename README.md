# Orchest: Hello Spark

[![Open in Orchest](https://github.com/orchest/orchest-examples/raw/main/imgs/open_in_orchest.svg)](https://cloud.orchest.io/?import_url=https://github.com/ricklamers/orchest-hello-spark/)

This repo shows how to run (Py)Spark in Orchest (locally).

For details on how Spark is installed check out [setup_script.sh](.orchest/environments/b6b9af33-1531-44c1-bc66-3b9bf7999d29/setup_script.sh). The actual Spark code is a minimal example of how to count words in a Python LICENSE text file. Checkout the [notebook](pyspark.ipynb) with code.

To connect to a cluster instead use a different PySpark context initializer:
```python3
conf = pyspark.SparkConf()
conf.setMaster('spark://head_node:7077')
conf.set('spark.authenticate', True)
conf.set('spark.authenticate.secret', 'secret-key')
sc = pyspark.SparkContext(conf=conf)
```

### Pipeline
![PySpark pipeline](https://pviz.orchest.io/?pipeline=https://github.com/ricklamers/orchest-hello-spark/blob/master/main.orchest)
