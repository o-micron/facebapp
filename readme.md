# Why does this repository exist
This repo is trying to run some example using the openvino/ubuntu18 docker image \
I had some issues building openvino from source on windows and I decided to go with a docker image, there are some bugs at the moment, the windows builds crash and I wanted to pass that problem. \
I explored that option in 24 hours, it seems to work fine now. \
This is not maintained, I put it there in case you wanted to cheat or steal some hacked solution .. 

# Useful links
```bash
# Check main opencv repository for the code
https://github.com/opencv/opencv/tree/master/samples/cpp/tutorial_code/gapi/face_beautification

# Check the opencv docs for more explanation regarding the code
https://docs.opencv.org/master/d4/d48/tutorial_gapi_face_beautification.html

# Check the models from open model zoo
# I used "face-detection-adas-0001" and "facial-landmarks-35-adas-0002"
https://github.com/opencv/open_model_zoo
```

# How to use
1. Build and run the docker image
    ```bash
    chmod +x ./docker_create.sh
    chmod +x ./docker_run.sh
    ./docker_create.sh
    ./docker_run.sh
    ```

2. Build the code inside docker
    ```bash
    cp -r /home/openvino/facebapp /home/openvino/app
    cd /home/openvino/app
    mkdir build && cd build && cmake .. && make && cd ..
    ```

3. Run the app inside docker
    ```bash
    chmod +x ./run.sh
    ./run.sh
    ```
    now check `./run.sh` to modify app arguments if you want, here is the args list
    ```bash
        -b, --boxes (value:false)
                set true to draw face Boxes in the "Input" window.
        -f, --facepath
                a path to a Face detection model file (.xml).
        --facedevice (value:GPU)
                the face detection computation device.
        -h, --help
                print the help message.
        -i, --input
                a path to an input. Skip to capture from a camera.
        -l, --landmpath
                a path to a Landmarks detection model file (.xml).
        --landmarks, -m (value:false)
                set true to draw landMarks in the "Input" window.
        --landmdevice (value:CPU)
                the landmarks detection computation device.
        -p, --performance (value:false)
                set true to disable output displaying.
        -s, --streaming (value:true)
                set false to disable stream pipelining.
    ```

# Details
This is an app that uses opencv and gapi with intel openvino backend and some pre trained models to detect face features like the eyes and mouth location in order to 
mask them from specific operations (blur in our case). \
We can use CPU or GPU in order to process the frames, I use CPU for now, if we go for GPU we then have to find a way to let docker access GPU and we will probably need to do some more stuff to make it work faster ... Let's be simple for now ..

Since this is an opencv app, and we happen to call imshow() which basically shows some image in a new window ... we need to see that window .. we need gui support and we run it inside docker. To do that we need to expose the X11 ip and port to docker along the ability to capture data from the camera ..
Long story short, always remember that the app needs access to some of the host hardware, if something ever breaks remember that.


- We need to run X11 in windows, that's a way to let the docker app forward the gui calls to our X11 server ...
- Download and install vcxsrv on windows using powershell and choco package manager
```bash
choco install vcxsrv
```

- We need to expose X11 server ip to docker, In my case my host local ip was that, you will probably have a different one, replace it in order for it to work for you.
You can find that in the first line of `run.sh` \
Make sure `run.sh` has first line `export DISPLAY=192.168.1.2:0` \
replace that with your host's ip address, on windows run the following to know your ip
```bash
ipconfig
# you should get a result looking like the following
# IPv4 Address. . . . . . . . . . . : 192.168.1.2
```
