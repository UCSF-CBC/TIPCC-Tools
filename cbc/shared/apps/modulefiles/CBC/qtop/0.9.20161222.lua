help([[
qtop: Monitor the State of Queueing Systems, Along with Related Information Relevant on HPC & Grid Clusters
]])

local name = myModuleName()
local version = myModuleVersion()
whatis("Version: " .. version)
whatis("Keywords: system, utility")
whatis("URL: https://github.com/qtop/qtop")
whatis("Description: `qtop` (pronounced queue-top) is a tool written in order to monitor the state of Queueing Systems, along with related information relevant on HPC & grid clusters. At present it supports PBS, SGE & OAR families. Please help to increase that list in the Python version of the tool, qtop.py! Examples: `qtop` and `qtop -FGW`.")

local path = os.getenv("SOFTWARE_ROOT_CBC")
local home = path .. "/" .. name .. "-" .. version

prepend_path("PATH", home)
append_path("PYTHONPATH", home)
