help([[
Pandoc: A Universal Document Converter
]])

local name = myModuleName()
local version = myModuleVersion()
whatis("Version: " .. version)
whatis("Keywords: documentation, conversion")
whatis("URL: http://pandoc.org/")
whatis("Description: Pandoc is a Haskell library for converting from one markup format to another, and a command-line tool that uses this library. Example: `pandoc --version`.")

local path = os.getenv("SOFTWARE_ROOT_CBC")
local home = path .. "/" .. name .. "-" .. version
prepend_path("PATH", home .. "/bin")

