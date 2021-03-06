#!/usr/bin/env bash

###################################################################
# Author: Henrik Bengtsson <hb@biostat.ucsf.edu>
###################################################################

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Useful functions
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function error() {
    tput setaf 1 2> /dev/null ## red
    >&2 echo "ERROR: $*"
    tput sgr0 2> /dev/null    ## reset
#  exit 1
}

function decho() {
    tput setaf 8 2> /dev/null ## gray
    >&2 echo "$*"
    tput sgr0 2> /dev/null    ## reset
}

function timestamp() {
  local flavor="$1"
  if test -z "${flavor}"; then
    flavor="full"
  fi

  if test "${flavor}" == "date"; then
    echo `date +%Y%m%d`
  elif test "${flavor}" == "time"; then
    echo `date +%H%M%S`
  else
    echo `date +%Y%m%d-%H%M%S`
  fi
} # timestamp()

function today() {
  timestamp date
} # today()

function resetPath() {
  export PATH0=${SYSTEM_PATH}
}


function uniquePath() {
  export PATH=`echo ${PATH} | sed -e 's/:/\n/g' | uniq | paste -s -d ':'`
}

function uniqueManPath() {
  export MANPATH=`echo ${MANPATH} | sed -e 's/:/\n/g' | uniq | paste -s -d ':'`
}

function uniquePerl5Lib() {
  export PERL5LIB=`echo ${PERL5LIB} | sed -e 's/:/\n/g' | uniq | paste -s -d ':'`
}

function appendPath() {
  if test -z "$1"; then
    echo "appendPath(): Path is missing."
    return;
  fi
  if ! test -d "$1"; then
    error "No such path: $1"
  fi
  export PATH="${PATH}:$1"
  uniquePath
} # appendPath()

function prependPath() {
  if test -z "$1"; then
    echo "prependPath(): Path is missing."
    return;
  fi
  if ! test -d "$1"; then
    error "No such path: $1"
  fi
  export PATH="$1:${PATH}"
  uniquePath
} # prependPath()

function prependLdLibraryPath() {
  if test -z "$1"; then
    echo "prependLdlibraryPath(): Path is missing."
    return;
  fi
  if ! test -d "$1"; then
    error "No such path: $1"
  fi
  export LD_LIBRARY_PATH="$1:${LD_LIBRARY_PATH}"
  uniquePath
} # prependLdLibraryPath()

function module_load() {
    ## mecho module_load $*
    local name=$1
    local version=latest
    if [[ $name == *"/"* ]]; then
      version=$(echo $name | sed 's|.*/||g')
      name=$(echo $name | sed 's|/.*||g')
    fi
##      mecho "module_load ${name}/${version} (fake)"
    local subdir=$2
    if [[ $# == 1 ]]; then subdir="/bin"; fi
    local path=${SHARED_SOFTWARE}/${name}-${version}${subdir}
##    mecho path=$path
    prependPath $path
}

function prependManPath() {
  if test -z "$1"; then
    echo "prependManPath(): Path is missing."
    return;
  fi
  if ! test -d "$1"; then
    error "No such path: $1"
  fi
  export MANPATH="$1:${MANPATH}"
  uniqueManPath
} # prependManPath()


function prependPerl5Lib() {
  if test -z "$1"; then
    echo "prependPerl5Lib(): Path is missing."
    return;
  fi
  if ! test -d "$1"; then
    error "No such path: $1"
  fi
  export PERL5LIB="$1:${PERL5LIB}"
  uniquePerl5Lib
} # prependPerl5Lib()


function assertUserOnlyPermissions() {
  local path=$1

  ## Nothing to do?
  if ! test -e ${path}; then return; fi

  local d=$(dirname ${path})
  local f=$(basename ${path})
  
  ## Permissions already correct?
  local perms=$(ls -al ${d} | grep -F $f | cut -c 1-10)
  local permsGO=$(echo $perms | cut -c 5-10)
  if test "${permsGO}" == "------"; then return; fi
  
  ## Fix permissions
  chmod go-rwx ${path}

  ## Assert fix
  local permsT=$(ls -al ${d} | grep -F $f | cut -c 1-10)
  permsGO=$(echo $permsT | cut -c 5-10)
  if test "${permsGO}" != "------"; then
    tput setaf 1 2> /dev/null ## red
    >&2 echo "SECURITY ERROR: Detected that ${path} was accessible by others (ugo=$perms). Tried to reset permissions (chmod go-rwx ${path}), but failed. They are still accessible by others; ugo=${permsT}"
    tput sgr0 2> /dev/null    ## reset
    return
  fi

  tput setaf 3 2> /dev/null ## yellow
  >&2 echo "SECURITY WARNING: Detected that ${path} was accessible by others (ugo=$perms). Permissions were reset (chmod go-rwx ${path}) such only you can access it. New permissions: ugo=${permsT}"
  tput sgr0 2> /dev/null    ## reset
}


# Command prompt
function setPrompt() {
  export PS1="$1"

  local res=
  # If on the head node...
  if test "$HOSTNAME" == "cclc01.som.ucsf.edu"; then
    # If not already done...
    res=`echo "$PS1" | grep "[*][*][*]"`
    if test -z "$res"; then
      # Prepend command line prompt on head node if not already done.
      export PS1="*****************\n*** HEAD NODE ***\n*****************\n$PS1"
    fi
  fi
} # setPrompt()



# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## Backward compatibility with /home/shared/cbc/tipcc/.bashrc
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [[ -n "${BASHRC_DEBUG}" && -z "${STARTUP_DEBUG}" ]]; then
    decho "WARNING: BASHRC_DEBUG=true is deprecated. Please use STARTUP_DEBUG=true"
    STARTUP_DEBUG=${BASHRC_DEBUG}
fi


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Useful system variables
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if test -n "${SHARED_ROOT}"; then
  mkdir -p "${SHARED_ROOT}"
  export SHARED_BIN=${SHARED_ROOT}/bin
  mkdir -p "${SHARED_BIN}"
  export SHARED_LOCAL=${SHARED_ROOT}/local
  mkdir -p "${SHARED_LOCAL}"

  export SHARED_SOFTWARE_FROZEN=${SHARED_ROOT}/software_frozen
  mkdir -p "${SHARED_SOFTWARE_FROZEN}"

  # DEFUNCT /HB 2018-01-03
  export SHARED_SOFTWARE=${SHARED_ROOT}/software_defunct_use_modules
  mkdir -p "${SHARED_SOFTWARE}"
  
  # GNU compiler variables
  export SHARED_PREFIX=${SHARED_LOCAL}
#  export SHARED_PKG_CONFIG_PATH=${SHARED_PREFIX}/lib/pkgconfig
  export PKG_CONFIG_PATH=${SHARED_PREFIX}/lib/pkgconfig:${SHARED_PREFIX}/lib64/pkgconfig
fi


###################################################################
# HISTORY:
# 2014-10-13
# o Added SHARED_SOFTWARE_FROZEN.
# 2014-01-07
# o Added setPrompt().
# 2012-04-30
# o Added uniquePath().
# o Extracted includes.bash.
# 2012-04-28
# o Extracted and shared.
###################################################################
