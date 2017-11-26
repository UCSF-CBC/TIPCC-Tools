help([[
BLAST+: Basic Local Alignment Search Tool
]])

local name = myModuleName()
local version = myModuleVersion()
whatis("Version: " .. version)
whatis("Keywords: programming, scripting")
whatis("URL: https://blast.ncbi.nlm.nih.gov/Blast.cgi")
whatis("Description: BLAST finds regions of similarity between biological sequences. The program compares nucleotide or protein	sequences to sequence databases and calculates the statistical significance. Example: `blastx -version`")

-- Local variables
local cbc_shared = "/home/shared/cbc"
local cbc_software = cbc_shared .. "/software_cbc"

prepend_path("PATH", cbc_software .. "/ncbi-" .. name .. "-" .. version .. "+/bin")
