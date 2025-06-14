if(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")
  add_compile_options("$<$<CONFIG:Debug,RelWithDebInfo>:-Wall>"
  -fimplicit-none
  )
  # $<$<CONFIG:Debug>:-fcheck=all>  fails in line 1246 array bounds error
elseif(CMAKE_Fortran_COMPILER_ID MATCHES "^Intel")
  add_compile_options(-traceback -warn)
    #"$<$<CONFIG:Debug>:-check>" same as gfortran
endif()
