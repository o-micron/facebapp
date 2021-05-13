cmake_minimum_required(VERSION 3.1)
project(facebapp VERSION 1.0 DESCRIPTION "facebapp" LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

file(GLOB_RECURSE HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/../../include/*.hpp ${CMAKE_CURRENT_SOURCE_DIR}/../../include/*.h)
file(GLOB_RECURSE SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/../../src/*.cpp ${CMAKE_CURRENT_SOURCE_DIR}/../../src/*.c)

include_directories("/opt/intel/openvino/opencv/include")
link_directories("/opt/intel/openvino/opencv/lib")
link_libraries(
    opencv_calib3d
    opencv_core_parallel_tbb
    opencv_core
    opencv_dnn
    opencv_features2d
    opencv_flann
    opencv_gapi
    opencv_highgui
    opencv_imgcodecs
    opencv_imgproc
    opencv_ml
    opencv_objdetect
    opencv_photo
    opencv_stitching
    opencv_video
    opencv_videoio_ffmpeg
    opencv_videoio_gstreamer
    opencv_videoio_intel_mfx
    opencv_videoio
)

add_executable(facebapp ${HEADERS} ${SOURCES})

set(OPENCV_BINARY_DIRECTORY "/opt/intel/openvino/opencv/lib")
set(OPENCV_SHARED_LIBRARY
    libopencv_calib3d.so
    libopencv_core_parallel_tbb.so
    libopencv_core.so
    libopencv_dnn.so
    libopencv_features2d.so
    libopencv_flann.so
    libopencv_gapi.so
    libopencv_highgui.so
    libopencv_imgcodecs.so
    libopencv_imgproc.so
    libopencv_ml.so
    libopencv_objdetect.so
    libopencv_photo.so
    libopencv_stitching.so
    libopencv_video.so
    libopencv_videoio_ffmpeg.so
    libopencv_videoio_gstreamer.so
    libopencv_videoio_intel_mfx.so
    libopencv_videoio.so
)
FOREACH(SLF ${OPENCV_SHARED_LIBRARY})
    add_custom_command(
        TARGET facebapp POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy ${OPENCV_BINARY_DIRECTORY}/${SLF} ${CMAKE_CURRENT_BINARY_DIR}/${SLF}
    )
ENDFOREACH()

MESSAGE(STATUS "facebapp Build type: ${CMAKE_BUILD_TYPE}")