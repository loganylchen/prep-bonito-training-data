rule get_ref_mmi:
    input:
        ref_fasta=config['reference']['transcriptome']
    output:
        ref_mmi='resources/reference.mmi'
    log:
        "logs/generate_ref_mmi.log"
    benchmark:
        "benchmarks/bm.generate_ref_mmi.txt"
    conda:
        "../envs/minimap2.yaml"
    resources:
        mem_mb=20480
    shell:
        "minimap2 -x map-ont -d {output.ref_mmi} {input.ref_fasta} 2> {log}"



