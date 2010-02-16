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
LIBS =  -L$(LIBDIR) -lnest3 -lmkl_lapack -lmkl -lguide -lpthread
MCLIBS = -lstdc++
 
OBJFILES = cnest_c.o

all: eggbox 

%.o: %.cc
	$(CC) $(CFLAGS) -c $*.cc
 
eggbox: $(OBJFILES)
	$(FC) $(FFLAGS) -nofor_main -o ../eggbox $(OBJFILES) $(MCLIBS) $(LIBS)

clean:
	rm -f *.o *.mod ../eggbox
