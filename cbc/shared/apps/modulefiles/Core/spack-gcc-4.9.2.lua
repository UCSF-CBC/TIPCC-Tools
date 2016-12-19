load("spack")
load("python")

local spack_root = os.getenv("SPACK_ROOT")

-- ADHOC: Hard coded for now /HB 2016-12-13
local spack_arch = "linux-rhel6-x86_64"  -- On head node == $(spack arch)
local compiler = pathJoin("gcc", "4.9.2")

local home = pathJoin(spack_root, "share/spack/lmod", spack_arch, compiler)
prepend_path("MODULEPATH", home)

-- These modules need to be loaded after this module is setup
load("binutils")