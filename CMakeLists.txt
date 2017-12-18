cmake_minimum_required (VERSION 3.2)
project (dla CXX)
set (CMAKE_CXX_STANDARD 14)

find_package(Boost COMPONENTS program_options)
include_directories(${Boost_INCLUDE_DIRS})
add_executable (o1 src/o1.cpp)
target_link_libraries(o1 ${Boost_LIBRARIES})

add_executable (o3 src/o3.cpp)
target_link_libraries(o3 ${Boost_LIBRARIES})
