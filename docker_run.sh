docker run --rm -it \
    -e DISPLAY=${DISPLAY} \
    --privileged \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --device=/dev/video0:/dev/video0 \
    --privileged -v /dev/bus/usb:/dev/bus/usb \
    --network="host" \
    facebapp-docker