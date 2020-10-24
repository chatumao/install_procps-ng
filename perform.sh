#!/bin/zsh

err_log=/tmp/errlog

script_dir_func="script_dir_${${(%):-%N}%%.*}"
declare "${script_dir_func}"="$(cd "$(dirname "$(readlink -f "${(%):-%x}")")" >/dev/null 2>&1 && pwd)"

. "${(P)script_dir_func}/zsh_ar18_lib/ar18__log__fatal.sh"


function on_error(){
  ar18__log__fatal "There was an error at or near line [$1] in file [$2]" "$((${funcsourcetrace[-1]#*:} + LINENO))" "${"$(readlink -f "${(%):-%x}" | awk -F/ '{print $(NF-1) "/" $NF}')"}"
}


trap 'on_error ${LINENO} "${"$(readlink -f "${(%):-%x}" | awk -F/ '\''{print $(NF-1) "/" $NF}'\'')"}"' ERR

if [[ "$(whoami)" != "root" ]]; then
  ar18__log__fatal "Must be root" $LINENO "${"$(readlink -f "${(%):-%x}" | awk -F/ '{print $(NF-1) "/" $NF}')"}" "" 256
fi

if [[ -f "${(P)script_dir_func}/vars.sh" ]]; then
  . "${(P)script_dir_func}/vars.sh"
fi

if [[ $# == 0 ]]; then
  ar18__log__fatal "Specify script to be executed as only parameter (just the basename without extension)" $LINENO "${"$(readlink -f "${(%):-%x}" | awk -F/ '{print $(NF-1) "/" $NF}')"}" "" 128
else
  . "./$1.sh"
fi
