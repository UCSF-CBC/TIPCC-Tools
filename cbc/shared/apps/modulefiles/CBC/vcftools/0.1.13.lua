help([[
VCFtools - A set of tools written in Perl and C++ for working with VCF files, such as those generated by the 1000 Genomes Project.
]])

local name = myModuleName()
local version = myModuleVersion()
whatis("Version: " .. version)
whatis("Keywords: ")
whatis("URL: https://vcftools.github.io/")
whatis("Description: VCFtools is a program package designed for working with VCF files, such as those generated by the 1000 Genomes Project. The aim of VCFtools is to provide easily accessible methods for working with complex genetic variation data in the form of VCF files. Example: `vcftools --version`.")

load("cbc-devel")

-- Local variables
local cbc_shared = "/home/shared/cbc"
local cbc_software = cbc_shared .. "/software_cbc"

local path = cbc_software .. "/" .. name .. "-" .. version
prepend_path("PATH", path .. "/bin")
prepend_path("PERL5LIB", path .. "/lib/perl5/site_perl")
