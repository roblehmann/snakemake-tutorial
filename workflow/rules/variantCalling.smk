rule bcftools_call:
    input:
        ref= config["reference"]["refPath"] + "GCF_000005845.2_ASM584v2_genomic.fna",
        bam=expand(config["output"] + "sorted_reads/{sample}.bam", sample=SAMPLES),
        bai=expand(config["output"] + "sorted_reads/{sample}.bam.bai", sample=SAMPLES)
    output:
        config["output"] + "calls/all.vcf"
    conda: 
        "../envs/tutorial_env.yaml"
    shell:
        "bcftools mpileup -f {input.ref} {input.bam} | "
        "bcftools call -mv - > {output}"
