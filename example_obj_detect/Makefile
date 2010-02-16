FC = mpif90
FFLAGS +=  -w -O3 
CFLAGS +=  -I. -O3 
CXXFLAGS +=  -I. -O3 
 
LINKLIB = ld -shared  
LIBDIR = ..
NESTED_lib = ..
NESTED_inc = ..
LIBS=-L$(NESTED_lib) -lnest3 -llapack -lpthread
 
OBJFILES = params.o like.o nestwrap.o main.o

all: obj_detect 

%.o: %.f90
	$(FC) $(FFLAGS) -I$(NESTED_inc) -c $*.f90
 
obj_detect: $(OBJFILES)
	$(FC) -o ../obj_detect $(OBJFILES) \
	$(FFLAGS) $(LIBS)

clean:
	rm -f *.o *.mod ../obj_detect
