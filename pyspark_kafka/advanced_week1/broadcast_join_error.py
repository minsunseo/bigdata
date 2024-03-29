from pyspark.sql import SparkSession
from pyspark.sql.functions import broadcast

"""
spark-submit --driver-memory 500M --master "local[*]" broadcast_join_error.py
"""

spark = SparkSession \
    .builder \
    .appName("Broadcast Join Demo") \
    .master("local[3]") \
    .config("spark.sql.shuffle.partitions", 3) \
    .config("spark.sql.adaptive.enabled", False) \
    .getOrCreate()

df_large = spark.read.json("large_data/")
df_small = spark.read.json("broadcast.json")

join_expr = df_large.id == df_small.id
join_df = df_large.join(broadcast(df_small), join_expr, "inner")

join_df.collect()
input("Waiting ...")

spark.stop()
