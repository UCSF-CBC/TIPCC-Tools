help([[
HISAT2: Graph-based Alignment of Next Generation Sequencing Reads to a Population of Genomes
]])

local name = myModuleName()
local version = myModuleVersion()
whatis("Version: " .. version)
whatis("Keywords: Programming, Statistics")
whatis("URL: https://ccb.jhu.edu/software/hisat2/")
whatis("Description: HISAT2 is a fast and sensitive alignment program for mapping next-generation sequencing reads (both DNA and RNA) to a population of human genomes (as well as to a single reference genome). Based on an extension of BWT for graphs [Sirén et al. 2014], we designed and implemented a graph FM index (GFM), an original approach and its first implementation to the best of our knowledge. In addition to using one global GFM index that represents a population of human genomes, HISAT2 uses a large set of small GFM indexes that collectively cover the whole genome (each index representing a genomic region of 56 Kbp, with 55,000 indexes needed to cover the human population). These small indexes (called local indexes), combined with several alignment strategies, enable rapid and accurate alignment of sequencing reads. This new indexing scheme is called a Hierarchical Graph FM index (HGFM).  Example: `hisat2 --version`.")

local path = os.getenv("SOFTWARE_ROOT_CBC")
local home = path .. "/" .. name .. "-" .. version
prepend_path("PATH", home)
