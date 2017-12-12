help([[
The R Programming Language
]])

local name = myModuleName()
local version = myModuleVersion()
whatis("Version: " .. version)
whatis("Keywords: Programming, Statistics")
whatis("URL: https://www.r-project.org/")
whatis("Description: The R programming language. Example: `R --version`.")

-- Local variables
local cbc_shared = "/home/shared/cbc"
local path = cbc_shared .. "/software_cbc/R/R-3.4.3patched-20171209"
prepend_path("PATH", path .. "/bin")
prepend_path("MANPATH", path .. "/share/man")