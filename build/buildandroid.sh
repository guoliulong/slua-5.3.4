CMAKE_PATH=./../cmake/3.6.3155560/bin/
NDK_PATH=/c/android-ndk-r14b
#NDK_PATH=c:/android-ndk-r14b
${CMAKE_PATH}/cmake .. -DCMAKE_BUILD_TYPE=Debug -DANDROID_PIE=TRUE -DANDROID_ABI="armeabi-v7a with NEON" -DCMAKE_TOOLCHAIN_FILE=${NDK_PATH}/build/cmake/android.toolchain.cmake -DANDROID=TRUE -G"Unix Makefiles"

make

mkdir armeabi-v7a

mv libslua.so armeabi-v7a/libslua.so

make clean

${CMAKE_PATH}/cmake .. -DCMAKE_BUILD_TYPE=Debug -DANDROID_PIE=TRUE -DANDROID_ABI=x86 -DCMAKE_TOOLCHAIN_FILE=${NDK_PATH}/build/cmake/android.toolchain.cmake -DANDROID=TRUE -G"Unix Makefiles"

make

mkdir x86
mv libslua.so x86/libslua.so

make clean
