FC = mpif90 
FFLAGS +=  -fpp -w -O3
CXXFLAGS +=  -I. -O3
 
LINKLIB = ld -shared  
LIBDIR = ..
NESTED_lib = ..
NESTED_inc = ..
LIBS=-L$(NESTED_lib) -lnest3 -llapack -lpthread
 
OBJFILES = params.o like.o nestwrap.o main.o

all: gauss_shell 

%.o: %.f90
	$(FC) $(FFLAGS) -I$(NESTED_inc) -c $*.f90
 
gauss_shell: $(OBJFILES)
	$(FC) -o ../gauss_shell $(OBJFILES) \
	$(FFLAGS) $(LIBS)

clean:
	rm -f *.o *.mod ../gauss_shell
