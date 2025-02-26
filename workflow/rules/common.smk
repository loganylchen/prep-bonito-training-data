import glob
import pandas as pd
import sys
import os
from snakemake.utils import validate
from snakemake.logging import logger



# loading samples
samples = (
    pd.read_csv(config["samples"], sep="\t", dtype={"SampleName": str}, comment="#")
    .set_index("SampleName", drop=False)
    .sort_index()
)


def get_final_output():
    final_output = expand("training_data/{sample}/basecalled.bam",sample=samples.index.to_list())
    return final_output