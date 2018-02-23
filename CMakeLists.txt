cmake_minimum_required(VERSION 3.6)

PROJECT(slua)

INCLUDE_DIRECTORIES(./src)

AUX_SOURCE_DIRECTORY(./src LUA_SRC_LIST)
AUX_SOURCE_DIRECTORY(./luasocket.git/src LUASOCKET_SRC_LIST)
AUX_SOURCE_DIRECTORY(./lua-cjson.git LUACJSON_SRC_LIST)

IF(ANDROID)
	SET(CMAKE_SYSTEM_NAME Linux)
	LIST(REMOVE_ITEM LUA_SRC_LIST ./src/lua.c ./src/luac.c)
	LIST(REMOVE_ITEM 
		LUASOCKET_SRC_LIST 
		./luasocket.git/src/wsocket.c
		 )

	LIST(REMOVE_ITEM 
		LUACJSON_SRC_LIST
		./lua-cjson.git/g_fmt.c
		./lua-cjson.git/dtoa.c
		)

	ADD_LIBRARY(slua SHARED ${LUA_SRC_LIST} ${LUASOCKET_SRC_LIST} ${LUACJSON_SRC_LIST} ./luaxml.git/LuaXML_lib.c )
	#TARGET_LINK_LIBRARIES(slua m)
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D \"log2(x)=(log(x)/1.4426950408889634)\" -D \"lua_getlocaledecpoint()=(\'.\')\" ")
	
ELSEIF(WIN32) #
	LIST(REMOVE_ITEM LUA_SRC_LIST ./src/lua.c ./src/luac.c)
	LIST(REMOVE_ITEM 
		LUASOCKET_SRC_LIST 
		./luasocket.git/src/serial.c
		./luasocket.git/src/unixdgram.c
		./luasocket.git/src/unixstream.c
		./luasocket.git/src/usocket.c
		./luasocket.git/src/unix.c
		 )

	LIST(REMOVE_ITEM 
		LUACJSON_SRC_LIST
		./lua-cjson.git/g_fmt.c
		./lua-cjson.git/dtoa.c
		)

	ADD_LIBRARY(slua SHARED ${LUA_SRC_LIST} ${LUASOCKET_SRC_LIST} ${LUACJSON_SRC_LIST} ./luaxml.git/LuaXML_lib.c )
	TARGET_LINK_LIBRARIES(slua ws2_32.lib)
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DLUA_BUILD_AS_DLL -DLUA_LIB")

	ADD_EXECUTABLE(lua ${LUA_SRC_LIST} ./src/lua.c ${LUASOCKET_SRC_LIST} ${LUACJSON_SRC_LIST} ./luaxml.git/LuaXML_lib.c )
	ADD_EXECUTABLE(luac ${LUA_SRC_LIST} ./src/luac.c )
	
	TARGET_LINK_LIBRARIES(lua ws2_32.lib)
ENDIF(ANDROID)

add_subdirectory(./luacppinterface.git)
