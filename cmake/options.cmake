include(GNUInstallDirs)

message(STATUS "${PROJECT_NAME} ${PROJECT_VERSION}  CMake ${CMAKE_VERSION} Toolchain ${CMAKE_TOOLCHAIN_FILE}")

option(${PROJECT_NAME}_BUILD_TESTING "Build tests" ${PROJECT_IS_TOP_LEVEL})

# Necessary for shared library with Visual Studio / Windows oneAPI
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS true)
