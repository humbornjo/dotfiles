function debian 
  qemu-system-x86_64 -m 4G -smp 2 -accel tcg \
    -hda ~/Documents/Image/debian-12-nocloud-amd64.qcow2 \
    -net nic -net user,hostfwd=tcp::10022-:22 -daemonize -display none
end


