cmake_minimum_required(VERSION 2.8)
project(multinest Fortran)

file(GLOB MULTINEST_SOURCE *.f90 *.F90)

if(MULTINEST_USE_MPI)
    set(MPI_LIB "MPI_LIB-NOTFOUND")
    set(MPI_LIBRARY "MPI_LIB-NOTFOUND")
    set(MPI_FOUND)
    set(MPI_COMPILER mpif90)
    find_package(MPI)
    if(MPI_FOUND)
        include_directories(${MPI_INCLUDE_PATH})
        set(CMAKE_Fortran_COMPILER ${MPI_COMPILER})
        message(STATUS "NOTE: Set Fortran Compiler to " ${CMAKE_Fortran_COMPILER})
        set(CMAKE_Fortran_FLAGS ${CMAKE_Fortran_FLAGS})
    endif(MPI_FOUND)

    set(CMAKE_Fortran_FLAGS ${CMAKE_Fortran_FLAGS} " -DMPI ")

endif(MULTINEST_USE_MPI)

#find_package(LAPACK REQUIRED)
#include_directories(${LAPACK_INCLUDE_DIRS})

set(CMAKE_Fortran_FLAGS ${CMAKE_Fortran_FLAGS} " -O3 -fPIC -ffree-line-length-none")
add_library(nest3 ${MULTINEST_SOURCE})
SET_TARGET_PROPERTIES(multinest PROPERTIES LINKER_LANGUAGE Fortran)
target_link_libraries(multinest ${LAPACK_LIBRARIES} ${MPI_LIBRARY})
