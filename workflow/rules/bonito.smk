rule get_bonito_models:
    output:
        rna_models = directory('models/rna002_70bps_hac@v3')
    params:
        output_dir= 'models/',
        bonito=config['bonito']['path']
    log:
        "logs/get_bonito_models.log"
    benchmark:
        "benchmarks/bm.get_bonito_models.txt"
    resources:
        mem_mb=1024*5
    shell:
        "{params.bonito} download --models --out_dir {params.output_dir} 2>{log}"



rule bonito_training_dataset_prep:
    input:
        raw_signal_directory = 'data/{sample}/pod5',
        raw_model = 'models/rna002_70bps_hac@v3',
        ref_mmi='resources/reference.mmi'
    output:
        output_bam="training_data/{sample}/basecalled.bam",
        chunks="training_data/{sample}/chunks.npy",
        references="training_data/{sample}/references.npy",
        reference_lengths="training_data/{sample}/reference_lengths.npy",
    log:
        "logs/bonito_training_dataset_prep_{sample}.log"
    benchmark:
        "benchmarks/bonito_training_dataset_prep_{sample}.txt"
    params:
        extra_param=config['bonito']['training_data_prep_ext'],
        bonito=config['bonito']['path']
    threads: config['bonito']['threads']
    shell:
        "{params.bonito} basecaller {input.raw_model} "
        "--alignment-threads {threads} "
        "--reference {input.ref_mmi} "
        "{params.extra_param} "
        "{input.raw_signal_directory} > {output.output_bam} 2>{log}"



