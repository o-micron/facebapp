export DISPLAY=192.168.1.2:0
export LIBGL_ALWAYS_INDIRECT=1
./build/cmake/linux/facebapp \
-f="/home/openvino/app/face-detection-adas-0001/FP32/face-detection-adas-0001.xml" \
-l="/home/openvino/app/facial-landmarks-35-adas-0002/FP32/facial-landmarks-35-adas-0002.xml" \
--facedevice=CPU \
--landmdevice=CPU \
--landmarks=true \
-b=true \
-p=false \
-s=false \
-i="/home/openvino/app/example-0001.jpg"