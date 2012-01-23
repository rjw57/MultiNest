#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>


#ifdef __INTEL_COMPILER 			// if the MultiNest library was compiled with ifort
       #define NESTRUN nested_mp_nestrun_
#elif defined __GNUC__ 				// if the MultiNest library was compiled with gfortran
       #define NESTRUN __nested_MOD_nestrun
#else
       #error Don't know how to link to Fortran libraries, check symbol table for your platform (nm libnest3.a | grep nestrun) & edit example_eggbox_C/eggbox.c
#endif


/***************************************** C Interface to MultiNest **************************************************/

extern void __nested_MOD_nestrun(int *, int *, int *, double *, double *, int *, int *, int *, int *, int *, double *, 
char *, int *, int *, int *, int *, void (*Loglike)(double *, int *, int *, double *), void (*dumper)(int *, int *, 
int *, double **, double **, double *, double *, double *), int *context);

void run(int mmodal, int ceff, int nlive, double tol, double efr, int ndims, int nPar, int nClsPar,  int maxModes,
int updInt, double Ztol, char root[], int seed, int *pWrap, int fb, int resume, void (*LogLike)(double *, int *, 
int *, double *), void (*dumper)(int *, int *, int *, double **, double **, double *, double *, double *), int context)
{
	int i;
	for (i = strlen(root); i < 100; i++) root[i] = ' ';
	
        NESTRUN(&mmodal, &ceff, &nlive, &tol, &efr, &ndims, &nPar, &nClsPar, &maxModes, &updInt, &Ztol,
        root, &seed, pWrap, &fb, &resume, LogLike, dumper, &context);
}

/***********************************************************************************************************************/




/******************************************** loglikelihood routine ****************************************************/

// Now an example, sample an egg box likelihood

// Input arguments
// ndim 						= dimensionality (total number of free parameters) of the problem
// npars 						= total number of free plus derived parameters
//
// Input/Output arguments
// Cube[npars] 						= on entry has the ndim parameters in unit-hypercube
//	 						on exit, the physical parameters plus copy any derived parameters you want to store with the free parameters
//	 
// Output arguments
// lnew 						= loglikelihood

void LogLike(double *Cube, int *ndim, int *npars, double *lnew)
{
	double chi = 1.0;
	int i;
	for(i = 0; i < *ndim; i++)
	{
		double x = Cube[i]*10.0*M_PI;
		chi *= cos(x/2.0);
		Cube[i] = x;
	}
	*lnew = powf(chi + 2.0, 5.0);
}

/***********************************************************************************************************************/




/************************************************* dumper routine ******************************************************/

// The dumper routine will be called every updInt*10 iterations
// MultiNest doesn not need to the user to do anything. User can use the arguments in whichever way he/she wants
//
//
// Arguments:
//
// nSamples 						= total number of samples in posterior distribution
// nlive 						= total number of live points
// nPar 						= total number of parameters (free + derived)
// physLive[1][nlive * (nPar + 1)] 			= 2D array containing the last set of live points (physical parameters plus derived parameters) along with their loglikelihood values
// posterior[1][nSamples * (nPar + 2)] 			= posterior distribution containing nSamples points. Each sample has nPar parameters (physical + derived) along with the their loglike value & posterior probability
// paramConstr[4*nPar]:
//	paramConstr[0] to paramConstr[nPar - 1] 	= mean values of the parameters
//	paramConstr[nPar] to paramConstr[2*nPar - 1] 	= standard deviation of the parameters
//	paramConstr[nPar*2] to paramConstr[3*nPar - 1] 	= best-fit (maxlike) parameters
//	paramConstr[nPar*4] to paramConstr[4*nPar - 1] 	= MAP (maximum-a-posteriori) parameters
// maxLogLike						= maximum loglikelihood value
// logZ							= log evidence value

void dumper(int *nSamples, int *nlive, int *nPar, double **physLive, double **posterior, double *paramConstr, double *maxLogLike, double *logZ)
{
	// convert the 2D Fortran arrays to C arrays
	
	
	// the posterior distribution
	// postdist will have nPar parameters in the first nPar columns & loglike value & the posterior probability in the last two columns
	
	int i, j;
	
	double postdist[*nSamples][*nPar + 2];
	for( i = 0; i < *nPar + 2; i++ )
		for( j = 0; j < *nSamples; j++ )
			postdist[j][i] = posterior[0][i * (*nSamples) + j];
	
	
	
	// last set of live points
	// pLivePts will have nPar parameters in the first nPar columns & loglike value in the last column
	
	double pLivePts[*nlive][*nPar + 1];
	for( i = 0; i < *nPar + 1; i++ )
		for( j = 0; j < *nlive; j++ )
			pLivePts[j][i] = physLive[0][i * (*nlive) + j];
}

/***********************************************************************************************************************/




/************************************************** Main program *******************************************************/



int main(int argc, char *argv[])
{
	// set the MultiNest sampling parameters
	
	
	int mmodal = 1;					// do mode separation?
	
	int ceff = 0;					// run in constant efficiency mode?
	
	int nlive = 1000;				// number of live points
	
	double efr = 1.0;				// set the required efficiency
	
	double tol = 0.5;				// tol, defines the stopping criteria
	
	int ndims = 2;					// dimensionality (no. of free parameters)
	
	int nPar = 2;					// total no. of parameters including free & derived parameters
	
	int nClsPar = 2;				// no. of parameters to do mode separation on
	
	int updInt = 100;				// after how many iterations feedback is required & the output files should be updated
							// note: posterior files are updated & dumper routine is called after every updInt*10 iterations
	
	double Ztol = -1.e90;				// all the modes with logZ < Ztol are ignored
	
	int maxModes = 100;				// expected max no. of modes (used only for memory allocation)
	
	int pWrap[] = {0, 0};				// which parameters to have periodic boundary conditions?
	
	char root[100] = "chains/eggboxC-";		// root for output files
	
	int seed = -1;					// random no. generator seed, if < 0 then take the seed from system clock
	
	int fb = 1;					// need feedback on standard output?
	
	int resume = 0;					// resume from a previous job?
	
	int context = 0;				// not required by MultiNest, any additional information user wants to pass

	
	
	// calling MultiNest
	
	
	run(mmodal, ceff, nlive, tol, efr, ndims, nPar, nClsPar, maxModes, updInt, Ztol, root, seed, pWrap, fb, resume, LogLike, dumper, context);
}

/***********************************************************************************************************************/
