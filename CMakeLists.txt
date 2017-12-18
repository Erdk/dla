cmake_minimum_required (VERSION 3.2)
project (dla CXX)
set (CMAKE_CXX_STANDARD 14)

find_package(Boost COMPONENTS program_options)
include_directories(${Boost_INCLUDE_DIRS})

add_executable (dla2d src/dla2d.cpp)
target_link_libraries(dla2d ${Boost_LIBRARIES})

add_executable (dla3d src/dla3d.cpp)
target_link_libraries(dla3d ${Boost_LIBRARIES})
