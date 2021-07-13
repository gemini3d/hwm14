cmake_minimum_required(VERSION 3.14...3.21)

project(HWM14
  LANGUAGES Fortran
  DESCRIPTION "Build and use HWM14 from Python"
  HOMEPAGE_URL https://map.nrl.navy.mil/map/pub/nrl/HWM/HWM14)

enable_testing()

# suppress large amounts of warnings with modern compilers
include(CheckFortranCompilerFlag)
check_fortran_compiler_flag(-w nowarn)
set(hwm14_flags)
if(nowarn)
  set(hwm14_flags -w)
endif()

add_library(hwm14 fortran/hwm14.f90)
set_target_properties(hwm14 PROPERTIES Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include)
target_include_directories(hwm14 INTERFACE ${CMAKE_CURRENT_BINARY_DIR}/include)
target_compile_options(hwm14 PRIVATE ${hwm14_flags})

install(TARGETS hwm14 EXPORT ${PROJECT_NAME}Targets)
install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include/
  TYPE INCLUDE
  FILES_MATCHING PATTERN "*.mod")

if(BUILD_TESTING)
  add_executable(hwm14test fortran/checkhwm14.f90)
  target_link_libraries(hwm14test PRIVATE hwm14)

  add_test(NAME HWM14 COMMAND $<TARGET_FILE:hwm14test> WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})
endif()

return()
# --- TODO: python driver
find_package(Python REQUIRED)

if(NOT Python_FOUND)
  return()
endif()
