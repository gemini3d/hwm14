cmake_minimum_required(VERSION 3.15...3.22)

file(STRINGS ${CMAKE_CURRENT_SOURCE_DIR}/VERSION PROJECT_VERSION
  REGEX "^([0-9]+\.[0-9]+\.[0-9]+)" LIMIT_INPUT 16 LENGTH_MAXIMUM 16 LIMIT_COUNT 1)

project(hwm14
LANGUAGES Fortran
VERSION ${PROJECT_VERSION}
)

include(CTest)

include(cmake/options.cmake)

# main library
add_library(hwm14 src/hwm14.f90)
set_target_properties(hwm14 PROPERTIES Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include)
target_include_directories(hwm14 PUBLIC
$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>
$<INSTALL_INTERFACE:include>
)
# suppress large amounts of warnings with modern compilers
target_compile_options(hwm14 PRIVATE -w)

install(TARGETS hwm14 EXPORT ${PROJECT_NAME}-targets)
install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include/
TYPE INCLUDE
FILES_MATCHING PATTERN "*.mod"
)
install(FILES data/dwm07b104i.dat data/gd2qd.dat data/hwm123114.bin
DESTINATION share/data/${PROJECT_NAME}
)

if(BUILD_TESTING)
  add_executable(hwm14test tests/checkhwm14.f90)
  target_link_libraries(hwm14test PRIVATE hwm14)

  add_test(NAME HWM14 COMMAND hwm14test WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/data)
endif()

include(cmake/install.cmake)
