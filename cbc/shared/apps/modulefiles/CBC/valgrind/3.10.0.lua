help([[
Valgrind: A Programming Tool for Memory Debugging, Memory Leak Detection, and Profiling
]])

local name = myModuleName()
local version = myModuleVersion()
whatis("Version: " .. version)
whatis("Keywords: Programming")
whatis("URL: http://www.valgrind.org/")
whatis("Description: Valgrind is a programming tool for memory debugging, memory leak detection, and profiling. Example: `valgrind --help`.")

local path = os.getenv("SOFTWARE_ROOT_CBC")
local home = path .. "/" .. name .. "-" .. version
prepend_path("PATH", home .. "/bin")
