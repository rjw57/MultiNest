FC = mpif90 -DMPI 
FFLAGS +=  -w -O3 -ffree-line-length-none -fPIC

 
AR = ar r  
LINKLIB = ld -shared  
LIBDIR = ./
 
NSOBJECTS = utils.o utils1.o priors.o kmeans_clstr.o xmeans_clstr.o posterior.o nested.o

%.o: %.f90
	$(FC) $(FFLAGS) -c -o $@ $^ 

%.o: %.F90
	$(FC) $(FFLAGS) -c -o $@ $^ 

 
all: libnest3.a libnest3.so obj_detect eggbox gauss_shell 
 
libnest3.so: $(NSOBJECTS) 
	$(LINKLIB) -o $(LIBS) $@ $^ 
 
libnest3.a: $(NSOBJECTS) 
	$(AR) $@ $^ 
 
obj_detect:
	cd example_obj_detect; $(MAKE);
 
gauss_shell:
	cd example_gauss_shell; $(MAKE);
	
eggbox:
	cd example_eggbox; $(MAKE);

clean: 
	-rm $(LIBDIR)/libnest3.*  *.o *.mod
	
cleanall: clean_exec clean clean_obj_detect clean_gauss_shell clean_example_eggbox

clean_exec:
	-rm gauss_mix gauss_shell egg_box

clean_obj_detect:
	cd example_obj_detect; $(MAKE) clean;
	
clean_gauss_shell:
	cd example_gauss_shell; $(MAKE) clean;
	
clean_example_eggbox:
	cd example_eggbox; $(MAKE) clean;

