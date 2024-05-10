include(GNUInstallDirs)

message(STATUS "${PROJECT_NAME} ${PROJECT_VERSION}  CMake ${CMAKE_VERSION} Toolchain ${CMAKE_TOOLCHAIN_FILE}")

if(CMAKE_VERSION VERSION_LESS 3.21)
  get_property(not_top DIRECTORY PROPERTY PARENT_DIRECTORY)
  if(not_top)
    set(${PROJECT_NAME}_IS_TOP_LEVEL false)
  else()
    set(${PROJECT_NAME}_IS_TOP_LEVEL true)
  endif()
endif()

option(${PROJECT_NAME}_BUILD_TESTING "Build tests" ${${PROJECT_NAME}_IS_TOP_LEVEL})

# Necessary for shared library with Visual Studio / Windows oneAPI
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS true)
