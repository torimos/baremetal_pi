multipass unmount ubuntu
multipass mount %cd% ubuntu:\temp
multipass exec ubuntu -- make -C temp %1
multipass unmount ubuntu