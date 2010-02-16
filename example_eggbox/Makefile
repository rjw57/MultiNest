FC = mpif90 
CC = mpicc
CXX = CC 
FFLAGS +=  -w -O3
CFLAGS +=  -I. -O3
CXXFLAGS +=  -I. -O3
 
LINKLIB = ld -shared  
LIBDIR = ..
NESTED_lib = ..
NESTED_inc = ..
LIBS =  -L$(LIBDIR) -lnest3 -llapack -lpthread
MCLIBS = -lstdc++
 
OBJFILES = cnest_c.o

all: eggbox 

%.o: %.cc
	$(CC) $(CFLAGS) -c $*.cc
 
eggbox: $(OBJFILES)
	$(FC) $(FFLAGS) -o ../eggbox $(OBJFILES) $(MCLIBS) $(LIBS)

clean:
	rm -f *.o *.mod ../eggbox
