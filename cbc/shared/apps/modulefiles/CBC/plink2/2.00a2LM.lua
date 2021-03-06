help([[
PLINK2: Whole Genome Association Analysis Toolset
]])

local name = myModuleName()
local version = myModuleVersion()
whatis("Version: " .. version)
whatis("Keywords: genomics")
whatis("URL: https://www.cog-genomics.org/plink/2.0/")
whatis("Description: PLINK is a free, open-source whole genome association analysis toolset, designed to perform a range of basic, large-scale analyses in a computationally efficient manner. The focus of PLINK is purely on analysis of genotype/phenotype data, so there is no support for steps prior to this (e.g. study design and planning, generating genotype or CNV calls from raw data). Example: `plink2 --help`.")

-- Local variables
local root = os.getenv("SOFTWARE_ROOT_CBC")
local home = pathJoin(root, name .. "-" .. version)

prepend_path("PATH", home)
