help([[
Samtools: Tools (written in C using htslib) for Manipulating Next-Generation Sequencing Data
]])

local name = myModuleName()
local version = myModuleVersion()
whatis("Version: " .. version)
whatis("Keywords: sequencing")
whatis("URL: http://www.htslib.org/")
whatis("Description: Samtools is a suite of programs for interacting with high-throughput sequencing data.  Example: `samtools --version`")

load("cbc-devel")

local path = "/home/shared/cbc/software_cbc"
local home = path .. "/" .. name .. "-" .. version

prepend_path("PATH", home .. "/bin")
prepend_path("MANPATH", home .. "/share/man")

-- samtools (< 1.6):
prepend_path("PATH", home)
prepend_path("PATH", home .. "/bcftools")
prepend_path("PATH", home .. "/misc")

