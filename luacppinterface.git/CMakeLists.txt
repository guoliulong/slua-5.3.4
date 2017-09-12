cmake_minimum_required (VERSION 2.6)

#project (LuaCppInterface)

include_directories("../src")

list( APPEND CMAKE_CXX_FLAGS "-std=c++0x ${CMAKE_CXX_FLAGS} -g -ftest-coverage -fprofile-arcs")

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