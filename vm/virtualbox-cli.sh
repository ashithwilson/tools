#!/bin/bash

vm_name="Ubuntu 20"

main() {
  if vm_running; then
    start_ssh
  else
    run_vm && start_ssh
  fi
  #On user exit,
  shutdown_prompt
}

vm_running() {
  VBoxManage showvminfo "$vm_name" --details |
    grep -q "running" &&
    return 0
}

start_ssh() {
  echo "--------------"
  echo "  Trying SSH"
  echo "--------------"
  ssh ashes@localhost -p2222
}

run_vm() {
  VBoxManage startvm "$vm_name" --type headless
}

shutdown_prompt() {
    echo "Hibernating VM '$vm_name' in background... "
    # Shutdown VM in background and return prompt ASAP
    VBoxManage controlvm "$vm_name" savestate > /dev/null 2>&1 & 
}

main "$@"
