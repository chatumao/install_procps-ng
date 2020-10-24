#!/bin/zsh


function "run_${$(basename "$(readlink -f "${(%):-%x}")")%%.*}"(){
  
  local script_dir_func="script_dir_${${(%):-%N}%%.*}"
  local declare "${script_dir_func}"="$(cd "$(dirname "$(readlink -f "${(%):-%x}")")" >/dev/null 2>&1 && pwd)"

  . "${(P)script_dir_func}/zsh_ar18_lib/ar18.sh"

  local vars_needed=(\
    module_name\
    working_dir_path\
    git_backup_path\
  )
    
  ar18__script__check_vars_needed "${vars_needed[@]}"
  
  ar18__log__info "Uninstalling" "$((${funcsourcetrace[-1]#*:} + LINENO))" "${"$(readlink -f "${(%):-%x}" | awk -F/ '{print $(NF-1) "/" $NF}')"}" 
  
  ar18__log__fatal "nothing to do" "$((${funcsourcetrace[-1]#*:} + LINENO))" "${"$(readlink -f "${(%):-%x}" | awk -F/ '{print $(NF-1) "/" $NF}')"}" 
  
  ar18__log__info "Finished uninstalling" "$((${funcsourcetrace[-1]#*:} + LINENO))" "${"$(readlink -f "${(%):-%x}" | awk -F/ '{print $(NF-1) "/" $NF}')"}" 

}


"run_${$(basename "$(readlink -f "${(%):-%x}")")%%.*}"
