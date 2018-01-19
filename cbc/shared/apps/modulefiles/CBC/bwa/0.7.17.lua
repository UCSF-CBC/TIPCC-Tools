help([[
BWA: Burrows-Wheeler Aligner
]])

local name = myModuleName()
local version = myModuleVersion()
whatis("Version: " .. version)
whatis("Keywords: sequencing")
whatis("URL: http://bio-bwa.sourceforge.net/")
whatis("Description: Burrows-Wheeler Aligner (BWA) is a software package for mapping low-divergent sequences against a large reference genome, such as the human genome. Example: `bwa`.")

local path = os.getenv("SOFTWARE_ROOT_CBC")
local home = path .. "/" .. name .. "-" .. version
prepend_path("PATH", home)

local manpath = home
if isDir(manpath .. "/man1") then
  prepend_path("MANPATH", manpath)
end
