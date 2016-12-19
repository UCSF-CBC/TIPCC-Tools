# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# SOFTWARE: Programming languages
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Lua, LuaRocks and Lmod
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
prependPath ${SHARED_SOFTWARE}/lua-latest/bin
prependPath ${SHARED_SOFTWARE}/luarocks-latest/bin

## Find also Lua modules installed via luarocks install --local
ver=$(luarocks config --lua-ver)
export LUA_PATH="${HOME}/.luarocks/share/lua/5.3/?.lua;${HOME}/.luarocks/share/lua/5.3/?/init.lua;/home/shared/cbc/software_cbc/luarocks-2.4.2/share/lua/5.3/?.lua;/home/shared/cbc/software_cbc/luarocks-2.4.2/share/lua/5.3/?/init.lua;/usr/local/share/lua/5.3/?.lua;/usr/local/share/lua/5.3/?/init.lua;/usr/local/lib/lua/5.3/?.lua;/usr/local/lib/lua/5.3/?/init.lua;./?.lua;./?/init.lua"
export LUA_CPATH="${HOME}/.luarocks/lib/lua/5.3/?.so;/home/shared/cbc/software_cbc/luarocks-2.4.2/lib/lua/5.3/?.so;/usr/local/lib/lua/5.3/?.so;/usr/local/lib/lua/5.3/loadall.so;./?.so"


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Ruby
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
prependPath ${SHARED_SOFTWARE}_cbc/bin

prependPath ${SHARED_SOFTWARE}/valgrind-latest/coregrind
prependPath ${SHARED_SOFTWARE}/jdk-latest/bin
prependPath ${SHARED_SOFTWARE}/matlab-latest/bin
prependPath ${SHARED_SOFTWARE}/R-latest/bin

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# SOFTWARE: Containers
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
prependPath ${SHARED_SOFTWARE}/udocker-latest




# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Development, e.g. gcc
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#prependPath /opt/llvm/llvm-3.5.0/bin
export GCC_HOME=/opt/gcc/gcc-4.9.2
if test -d "${GCC_HOME}"; then
    prependPath ${GCC_HOME}/bin
    export LD_LIBRARY_PATH="${GCC_HOME}/lib64:${LD_LIBRARY_PATH}"
fi



# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# BUILDS
#
# ./configure --prefix=${SHARED_ROOT}/local/
# make
# make install
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export CPPFLAGS="-I${SHARED_ROOT}/local/include $CPPFLAGS"
export LDFLAGS="-L${SHARED_ROOT}/local/lib $LDFLAGS"

## TODO: Make available to all users /HB 2016-12-01
#if test $USER == "henrik" || test $USER == "cbctest"; then
#export LD_LIBRARY_PATH="${SHARED_ROOT}/local/lib:${LD_LIBRARY_PATH}"
#fi