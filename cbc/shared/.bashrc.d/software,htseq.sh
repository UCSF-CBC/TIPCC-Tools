# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# SOFTWARE: HT-Seq
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
prependPath ${SHARED_SOFTWARE}/BamUtil-latest/bamUtil/bin

if [[ $(using_lmod) -eq 0 ]]; then
module_load bedops
## prependPath ${SHARED_SOFTWARE}/bedops-latest/bin

module_load bedtools2
## prependPath ${SHARED_SOFTWARE}/bedtools2-latest/bin

module_load blast ""
## prependPath ${SHARED_SOFTWARE}/blast-latest

module_load bowtie2 ""
## prependPath ${SHARED_SOFTWARE}/bowtie2-latest

module_load bwa ""
## prependPath ${SHARED_SOFTWARE}/bwa-latest

module_load Control-FREEC
## prependPath ${SHARED_SOFTWARE}/Control-FREEC-latest/bin

module_load cufflinks ""
## prependPath ${SHARED_SOFTWARE}/cufflinks-latest

module_load FastQC ""
##prependPath ${SHARED_SOFTWARE}/FastQC-latest

module_load GeneTorrent
## prependPath ${SHARED_SOFTWARE}/GeneTorrent-latest/bin
prependManPath ${SHARED_SOFTWARE}/GeneTorrent-latest/share/man

module_load HTSeq "/scripts"
## prependPath ${SHARED_SOFTWARE}/HTSeq-latest/scripts

module_load sratoolkit
## prependPath ${SHARED_SOFTWARE}/sratoolkit-latest/bin

module_load samtools ""
## prependPath ${SHARED_SOFTWARE}/samtools-latest

module_load bcftools ""
## prependPath ${SHARED_SOFTWARE}/bcftools-latest

module_load tophat ""
## prependPath ${SHARED_SOFTWARE}/tophat-latest

module_load vcftools
## prependPath ${SHARED_SOFTWARE}/vcftools-latest/bin

module_load wordspy ""
## prependPath ${SHARED_SOFTWARE}/wordspy-latest

module_load IGVTools ""
## prependPath ${SHARED_SOFTWARE}/IGVTools-latest

module_load IGV ""
## prependPath ${SHARED_SOFTWARE}/IGV-latest
alias igv=${SHARED_SOFTWARE}/IGV-latest/igv.sh

module_load htslib
##prependPath ${SHARED_SOFTWARE}/htslib-latest/bin
export HTSLIB_HOME=/home/shared/cbc/software/htslib-latest
fi

export PICARD_HOME=${SHARED_SOFTWARE}/picard-tools-latest
export GATK_HOME=${SHARED_SOFTWARE}/GATK-latest

