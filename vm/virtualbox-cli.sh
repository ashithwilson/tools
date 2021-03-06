#!/usr/bin/env bash
vm_name="Ubuntu 20"
ssh_command="ssh ashes@localhost -p2222"

main() {
  if vm_running; then
    start_ssh
  else
    run_vm && start_ssh
  fi
  #On SSH close,
  hibernate_vm
}

vm_running() {
  VBoxManage showvminfo "$vm_name" --details |
    grep -q "running" &&
    return 0
}

start_ssh() {
  echo "Trying SSH..."
  ${ssh_command}
}

run_vm() {
  VBoxManage startvm "$vm_name" --type headless
}

hibernate_vm() {
  echo "Hibernating VM '$vm_name' in background..."
  # hibernate VM in background and return prompt
  VBoxManage controlvm "$vm_name" savestate >/dev/null 2>&1 &
}

main "$@"

