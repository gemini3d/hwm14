# this enables CMake imported target HWM14::hwm14
include(ExternalProject)

set(hwm14_INCLUDE_DIRS ${CMAKE_INSTALL_FULL_INCLUDEDIR})

if(BUILD_SHARED_LIBS)
  if(WIN32)
    set(hwm14_LIBRARIES ${CMAKE_INSTALL_FULL_BINDIR}/${CMAKE_SHARED_LIBRARY_PREFIX}hwm14${CMAKE_SHARED_LIBRARY_SUFFIX})
  else()
    set(hwm14_LIBRARIES ${CMAKE_INSTALL_FULL_LIBDIR}/${CMAKE_SHARED_LIBRARY_PREFIX}hwm14${CMAKE_SHARED_LIBRARY_SUFFIX})
  endif()
else()
  set(hwm14_LIBRARIES $${CMAKE_INSTALL_FULL_LIBDIR}/${CMAKE_STATIC_LIBRARY_PREFIX}hwm14${CMAKE_STATIC_LIBRARY_SUFFIX})
endif()

set(hwm14_cmake_args
-DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_INSTALL_PREFIX}
-DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
-DCMAKE_BUILD_TYPE=Release
-DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER}
-DBUILD_TESTING:BOOL=false
)

ExternalProject_Add(hwm14
GIT_REPOSITORY ${hwm14_git}
GIT_TAG ${hwm14_tag}
CMAKE_ARGS ${hwm14_cmake_args}
BUILD_BYPRODUCTS ${hwm14_LIBRARIES}
TEST_COMMAND ""
CONFIGURE_HANDLED_BY_BUILD ON
)


set(hwm14_dat_files
${CMAKE_INSTALL_PREFIX}/share/data/hwm14/hwm123114.bin
${CMAKE_INSTALL_PREFIX}/share/data/hwm14/dwm07b104i.dat
${CMAKE_INSTALL_PREFIX}/share/data/hwm14/gd2qd.dat
)
ExternalProject_Add_Step(hwm14 hwm14_copy_data DEPENDEES install
COMMAND ${CMAKE_COMMAND} -E copy_if_different ${hwm14_dat_files} $<TARGET_FILE_DIR:gemini.bin>)
install(FILES ${hwm14_dat_files} TYPE BIN)


add_library(hwm14::hwm14 INTERFACE IMPORTED GLOBAL)
target_link_libraries(hwm14::hwm14 INTERFACE "${hwm14_LIBRARIES}")
target_include_directories(hwm14::hwm14 INTERFACE ${hwm14_INCLUDE_DIRS})

add_dependencies(hwm14::hwm14 hwm14)
