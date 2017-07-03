help([[
SRA Toolkit
]])

local name = myModuleName()
local version = myModuleVersion()
whatis("Version: " .. version)
whatis("Keywords: sequencing")
whatis("URL: http://ncbi.github.io/sra-tools/")
whatis("GitHub: https://github.com/ncbi/sra-tools")
whatis("Description: The SRA Toolkit and SDK from NCBI is a collection of tools and libraries for using data in the INSDC Sequence Read Archives.")

-- Local variables
local cbc_shared = "/home/shared/cbc"
local cbc_software = cbc_shared .. "/software"

local path = cbc_software .. "/" .. name .. "." .. version .. "-centos_linux64"
prepend_path("PATH", path .. "/bin")