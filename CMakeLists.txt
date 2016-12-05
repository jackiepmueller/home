cmake_minimum_required (VERSION 2.6)
project (foo)
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -g")
add_executable(foo foo.cpp)
