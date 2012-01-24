
FC = gfortran
CC = gcc
CXX = g++
FFLAGS += -O3 -w -ffree-line-length-none -fPIC
CFLAGS += -O3

ifneq ($(shell which mpif90),)
ifndef WITHOUT_MPI
FC = mpif90
CC = mpicc
CXX = mpiCC
FFLAGS += -DMPI
CFLAGS += -DMPI
endif
else
$(warning "mpif90 not found, so will compile without MPI!")
endif

LAPACKLIB = -llapack

NESTLIBDIR = ./

export FC CC CXX FFLAGS CFLAGS LAPACKLIB

AR = ar r  
LINKLIB = ld -shared
 
NSOBJECTS = utils.o utils1.o priors.o kmeans_clstr.o xmeans_clstr.o posterior.o nested.o

%.o: %.f90
	$(FC) $(FFLAGS) -c -o $@ $^ 

%.o: %.F90
	$(FC) $(FFLAGS) -c -o $@ $^ 

default: libnest3.a

all: libnest3.a obj_detect eggboxC eggboxC++ gaussian gauss_shell \
rosenbrock himmelblau ackley
 
libnest3.so: $(NSOBJECTS) 
	$(LINKLIB) -o $(LIBS) $@ $^ 
 
libnest3.a: $(NSOBJECTS) 
	$(AR) $@ $^ 
 
obj_detect:
	${MAKE} -C example_obj_detect
 
gaussian:
	${MAKE} -C example_gaussian
 
rosenbrock:
	${MAKE} -C example_rosenbrock
 
ackley:
	${MAKE} -C example_ackley
 
himmelblau:
	${MAKE} -C example_himmelblau
 
gauss_shell:
	${MAKE} -C example_gauss_shell
	
eggboxC:
	${MAKE} -C example_eggbox_C
	
eggboxC++:
	${MAKE} -C example_eggbox_C++

clean: 
	-rm $(NESTLIBDIR)/libnest3.*  *.o *.mod
	
cleanall: clean_exec clean clean_obj_detect clean_gaussian clean_gauss_shell \
clean_example_eggbox_C clean_example_eggbox_C++ clean_rosenbrock clean_himmelblau \
clean_ackley

clean_exec:
	-rm obj_detect gaussian rosenbrock ackley himmelblau gauss_shell eggboxC eggboxC++

clean_obj_detect:
	${MAKE} -C example_obj_detect clean
	
clean_gaussian:
	${MAKE} -C example_gaussian clean
	
clean_rosenbrock:
	${MAKE} -C example_rosenbrock clean
	
clean_ackley:
	${MAKE} -C example_ackley clean
	
clean_himmelblau:
	${MAKE} -C example_himmelblau clean
	
clean_gauss_shell:
	${MAKE} -C example_gauss_shell clean
	
clean_example_eggbox_C:
	${MAKE} -C example_eggbox_C clean
	
clean_example_eggbox_C++:
	${MAKE} -C example_eggbox_C++ clean
