rule bwa_map:
    input:
        ref = config["reference"]["refPath"] + "GCF_000005845.2_ASM584v2_genomic.fna",
        ind = config["reference"]["refPath"] + "GCF_000005845.2_ASM584v2_genomic.fna.bwt",
        in1 = config["reads"]["path"] + "{sample}R1.fq.gz",
        in2 = config["reads"]["path"] + "{sample}R2.fq.gz"
    output:
        config["output"] + "mapped_reads/{sample}.bam"
    conda: 
        "../envs/tutorial_env.yaml"
    shell:
        "bwa mem {input.ref} {input.in1} {input.in2} | samtools view -Sb - > {output}"


rule samtools_sort:
    input:
        config["output"] + "mapped_reads/{sample}.bam"
    output:
        config["output"] + "sorted_reads/{sample}.bam"
    conda: 
        "../envs/tutorial_env.yaml"
    shell:
        "samtools sort -T sorted_reads/{wildcards.sample} "
        "-O bam {input} > {output}"

rule samtools_index:
    input:
        config["output"] + "sorted_reads/{sample}.bam"
    output:
        config["output"] + "sorted_reads/{sample}.bam.bai"
    conda: 
        "../envs/tutorial_env.yaml"
    shell:
        "samtools index {input}"
