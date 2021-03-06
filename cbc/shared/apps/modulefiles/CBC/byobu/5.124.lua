help([[
byobu: Elegant Enhancement of the Otherwise Functional, Plain, Practical GNU Screen
]])

local name = myModuleName()
local version = myModuleVersion()
whatis("Version: " .. version)
whatis("Keywords: terminal, SSHH")
whatis("URL: http://byobu.org, https://github.com/dustinkirkland/byobu")
whatis("Description: Byobu is an elegant enhancement of the otherwise functional, plain, practical GNU Screen. Byobu includes an enhanced profile, configuration utilities, and system status notifications for the GNU screen window manager as well as the Tmux terminal multiplexer. Example: `byobu --version`")

depends_on("tmux")

local path = os.getenv("SOFTWARE_ROOT_CBC")
local home = path .. "/" .. name .. "-" .. version
prepend_path("PATH",  home .. "/bin")
prepend_path("MANPATH",  home .. "/share/man")
