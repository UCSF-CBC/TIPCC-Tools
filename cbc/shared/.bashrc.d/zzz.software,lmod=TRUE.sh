## mecho MODULEPATH=$(echo $MODULEPATH | tr : '\n')
if [[ $(using_lmod) -eq 1 ]]; then
    module load cbc-shared
    if [[ $CBC_DEVEL == "true" ]]; then
	module load cbc-devel
    fi
fi
