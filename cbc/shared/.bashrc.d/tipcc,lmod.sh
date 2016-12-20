# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Lua, LuaRocks and Lmod
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [[ -z "${MODULEPATH_LEGACY}" ]]; then
    export MODULEPATH_LEGACY="${MODULEPATH}"
fi


## WORKAROUND: When using Lmod, then `module avail` command will
## run in an end-less loop and consume huge amount of memory (leak?)
## iff we would keep /usr/share/Modules/modulefiles in MODULEPATH.
## TROUBLESHOOTING: File /usr/share/Modules/modulefiles/modules
## contains `module use /usr/share/Modules`, which seems to cause
## an infinite loop.  If commented out, the problem goes away.
## /HB 2016-12-11
if [[ -z "${MODULEPATH_DEFAULT}" ]]; then
    export MODULEPATH_DEFAULT="/etc/modulefiles:/opt/scyld/modulefiles"
fi
if [[ -z "${MODULEPATH_USER}" ]]; then
    if [[ -d "${HOME}/modulefiles" ]]; then
        export MODULEPATH_USER="${HOME}/modulefiles"
    fi
fi

use_lmod() {
    >&2 echo "[x] Using Lmod environment modules (BETA); see 'module avail'"
    >&2 echo "    https://github.com/UCSF-TI/TIPCC/wiki/Software-Environment-Modules-(BETA)"
    export MODULEPATH_ROOT=
    export MODULEPATH=
    source /home/shared/cbc/apps/lmod/lmod/init/profile
    export MODULEPATH="${MODULEPATH}:${MODULEPATH_DEFAULT}"

    if [[ -n "${MODULEPATH_USER}" ]]; then
        export MODULEPATH="${MODULEPATH_USER}:${MODULEPATH}"
    fi

    ## Default modules for all users, cf. ${MODULEPATH_ROOT}/Core/StdEnv.lua
    ## http://lmod.readthedocs.io/en/latest/070_standard_modules.html?highlight=MODULE%20DEFAULT
    if [ -z "$__Init_Default_Modules" ]; then
        export __Init_Default_Modules=1;
        ## ability to predefine elsewhere the default list
        LMOD_SYSTEM_DEFAULT_MODULES=${LMOD_SYSTEM_DEFAULT_MODULES:-"StdEnv"}
        export LMOD_SYSTEM_DEFAULT_MODULES
        module --initial_load restore 2> /dev/null
        module restore 2> /dev/null
    else
        module refresh
    fi

    ## WORKAROUND:
    ## 'module load StdEnv' may introduce :: in LD_LIBRARY_PATH
    ## (which e.g. Linux brew will complain about)
    export LD_LIBRARY_PATH=$(echo ${LD_LIBRARY_PATH} | sed -E 's/:$//')
}


## For BETA users
## (http://lmod.readthedocs.io/en/latest/045_transition.html?highlight=no-lmod)
if [[ -f "${HOME}/.lmod" && ! -f "${HOME}/.no.lmod" ]]; then
    use_lmod
fi
