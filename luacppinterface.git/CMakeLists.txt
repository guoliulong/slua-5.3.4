cmake_minimum_required (VERSION 2.6)

#project (LuaCppInterface)

include_directories("../src")

#list( APPEND CMAKE_CXX_FLAGS "-std=c++0x ${CMAKE_CXX_FLAGS} -g -ftest-coverage -fprofile-arcs")
include(CheckCXXCompilerFlag)  
CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)  
CHECK_CXX_COMPILER_FLAG("-std=c++0x" COMPILER_SUPPORTS_CXX0X)  
if(COMPILER_SUPPORTS_CXX11)  
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")  
elseif(COMPILER_SUPPORTS_CXX0X)  
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")  
else()  
     message(STATUS "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support. Please use a different C++ compiler.")  
endif()  
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -ftest-coverage -fprofile-arcs") 

add_library(LuaCppInterface STATIC 
	LuaCppInterface/luacoroutine.cpp
	LuaCppInterface/luareference.cpp
	LuaCppInterface/luacppinterface.cpp
	LuaCppInterface/luatable.cpp
	LuaCppInterface/luafunction.cpp
	LuaCppInterface/luaerror.cpp
	LuaCppInterface/luastringconversion.cpp
)

target_link_libraries(LuaCppInterface slua)

include_directories("./LuaCppInterface")
add_executable(LuaInterfaceTest1 tests/luacpp.cpp)
target_link_libraries(LuaInterfaceTest1 LuaCppInterface slua)
