#!/bin/zsh


function "run_${$(basename "$(readlink -f "${(%):-%x}")")%%.*}"(){
    
  local script_dir_func="script_dir_${${(%):-%N}%%.*}"
  local declare "${script_dir_func}"="$(cd "$(dirname "$(readlink -f "${(%):-%x}")")" >/dev/null 2>&1 && pwd)"
  . "${(P)script_dir_func}/zsh_ar18_lib/ar18.sh"
  
  local vars_needed=(\
    module_name\
    working_dir_path\
  )
    
  ar18__script__check_vars_needed "${vars_needed[@]}"
  
  ar18__log__info "Installing" "$((${funcsourcetrace[-1]#*:} + LINENO))" "${"$(readlink -f "${(%):-%x}" | awk -F/ '{print $(NF-1) "/" $NF}')"}" 
  
  pushd
  
  apt install libtool-bin -y

  rm -rf "${working_dir_path}/${module_name}"

  cd "${working_dir_path}"

  git clone https://gitlab.com/procps-ng/procps

  cd "./${module_name}"

  ./autogen.sh

  #auto-apt ./configure
  ./configure

  make

  #base_name="$(basename "$(cd "$(dirname "$(readlink -f "${(%):-%x}")")" >/dev/null 2>&1 && pwd)")"
  #version="12345"
  #mkdir -p /tmp/man/doc-pak
  #doc_dir_path="/tmp/man"
  #checkinstall -D --install=yes --pkgname="${base_name}" \
  #--pkgversion="${version}" --docdir="${doc_dir_path}" \
  #--showinstall=no
  #strace -f -t -e trace=file
  make install

  ldconfig

  cd "${working_dir_path}"

  rm -rf "${working_dir_path}/${module_name}"
  
  popd
  
  ar18__log__info "Finished installing" "$((${funcsourcetrace[-1]#*:} + LINENO))" "${"$(readlink -f "${(%):-%x}" | awk -F/ '{print $(NF-1) "/" $NF}')"}" 

}


"run_${$(basename "$(readlink -f "${(%):-%x}")")%%.*}"