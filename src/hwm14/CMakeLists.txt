# suppress large amounts of warnings with modern compilers
include(CheckFortranCompilerFlag)
check_fortran_compiler_flag(-w nowarn)
set(hwm14_flags)
if(nowarn)
  set(hwm14_flags -w)
endif()

add_library(hwm14 fortran/hwm14.f90)
set_target_properties(hwm14 PROPERTIES Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include)
target_include_directories(hwm14 PUBLIC
$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>
$<INSTALL_INTERFACE:include>
)
target_compile_options(hwm14 PRIVATE ${hwm14_flags})

install(TARGETS hwm14 EXPORT ${PROJECT_NAME}-targets)
install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include/
TYPE INCLUDE
FILES_MATCHING PATTERN "*.mod"
)
install(FILES dwm07b104i.dat gd2qd.dat hwm123114.bin
DESTINATION share/data/${PROJECT_NAME})

if(BUILD_TESTING)
  add_executable(hwm14test fortran/checkhwm14.f90)
  target_link_libraries(hwm14test PRIVATE hwm14)

  add_test(NAME HWM14 COMMAND $<TARGET_FILE:hwm14test> WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
endif()

include(${CMAKE_CURRENT_SOURCE_DIR}/../../cmake/install.cmake)
