cmake_minimum_required(VERSION 3.11...3.25)

project(hwm14
LANGUAGES Fortran
VERSION 1.2.4
)

enable_testing()

include(cmake/options.cmake)
include(cmake/compilers.cmake)

# --- hwm14 library
add_library(hwm14 src/hwm14.f90)
target_include_directories(hwm14 PUBLIC
$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>
$<INSTALL_INTERFACE:include>
)
# suppress large amounts of warnings with modern compilers
target_compile_options(hwm14 PRIVATE -w)

target_compile_definitions(hwm14 INTERFACE
$<BUILD_INTERFACE:DATADIR="${CMAKE_CURRENT_SOURCE_DIR}/data/">
$<INSTALL_INTERFACE:DATADIR="${CMAKE_INSTALL_PREFIX}/share/data/${PROJECT_NAME}/">
)

set(RESOURCE_FILES data/dwm07b104i.dat data/gd2qd.dat data/hwm123114.bin)

install(TARGETS hwm14 EXPORT ${PROJECT_NAME}-targets
LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include/
DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
FILES_MATCHING PATTERN "*.mod"
)
install(FILES ${RESOURCE_FILES}
DESTINATION share/data/${PROJECT_NAME}
)

# --- hwm14 interface
add_library(hwm_ifc src/hwm_interface.f90)
target_link_libraries(hwm_ifc PRIVATE hwm14)
target_include_directories(hwm_ifc PUBLIC
$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>
$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

install(TARGETS hwm_ifc EXPORT ${PROJECT_NAME}-targets
LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/include/hwm_interface.mod
DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

# --- tests

if(BUILD_TESTING)
  add_executable(hwm14check test/checkhwm14.f90)
  target_link_libraries(hwm14check PRIVATE hwm14)
  add_test(NAME HWM14check COMMAND hwm14check)

  add_executable(hwm14test test/test_hwm.f90)
  target_link_libraries(hwm14test PRIVATE hwm_ifc)
  add_test(NAME HWM14test COMMAND hwm14test)

  set_property(TEST HWM14test HWM14check PROPERTY WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/data)
endif()

include(cmake/install.cmake)
