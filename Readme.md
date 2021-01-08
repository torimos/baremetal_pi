# This is proof of concept to run bare metal app on raspberry pi

Prerequisites:
1. Install multipass to run ubuntu server for crosscompile https://multipass.run/
2. Run build server based on ubuntu image:\
multipass launch bionic -c 2 -m 2G -d 10G -n ubuntu
3. Mount/unmount shared folder\
multipass unmount ubuntu\
multipass mount p:\work ubuntu:\work

Build and Run:
1. ./make
2. copy files from boot and /build/kernel.img to SD card
3. reboot RPI
