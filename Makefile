FC = mpif90
CC = mpicc
CXX = mpiCC
FFLAGS += -O3 -DMPI -w -ffree-line-length-none -fPIC
CFLAGS += -O3 -DMPI

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

default: libnest3.a libnest3.so

all: default obj_detect eggboxC eggboxC++ gaussian gauss_shell \
rosenbrock himmelblau ackley
 
libnest3.so: $(NSOBJECTS) 
	$(LINKLIB) -o $(LIBS) $@ $^ 
 
libnest3.a: $(NSOBJECTS) 
	$(AR) $@ $^ 
 
example_%:
	${MAKE} -C $<
 
clean: 
	-rm $(NESTLIBDIR)/libnest3.*  *.o *.mod

cleanall: clean_exec clean clean_obj_detect clean_gaussian clean_gauss_shell \
clean_example_eggbox_C clean_example_eggbox_C++ clean_rosenbrock clean_himmelblau \
clean_ackley

clean_exec:
	-rm example_*

clean_%:
	make -C example_$% clean
	
