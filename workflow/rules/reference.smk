rule retrieve_ref:
    output:
          config["reference"]["refPath"] + "GCF_000005845.2_ASM584v2_genomic.fna.gz"
    params:
          reflink = config["reference"]["refLink"],
          path = config["reference"]["refPath"]
    shell:
         "wget -P {params.path} {params.reflink} "

rule uncompress_ref:
    input:
         config["reference"]["refPath"] + "GCF_000005845.2_ASM584v2_genomic.fna.gz"
    output:
         config["reference"]["refPath"] + "GCF_000005845.2_ASM584v2_genomic.fna"
    shell:
        "gunzip {input}"

rule bwa_index:
    input:
        config["reference"]["refPath"] + "GCF_000005845.2_ASM584v2_genomic.fna"
    output:
        multiext(config["reference"]["refPath"] + "GCF_000005845.2_ASM584v2_genomic.fna", ".bwt",".sa",".amb",".ann",".pac")
    conda: 
        "../envs/tutorial_env.yaml"
    shell:
        "bwa index {input}"
