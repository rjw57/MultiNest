! Include file for example nested sampler program

module params
implicit none

! Toy Model Parameters
	integer sdim
      	integer snpix !no. of pixels in the grid (generate a grid with snpix X snpix pixels)
      	integer snclstr !no. of objects to generate, should be a square no.
	parameter (snpix=200,snclstr=8)
      	logical autopos !position clusters uniformly in the field?
      	parameter (autopos=.false.)
	real*8 sodata(snpix,snpix)
      	real*8 spos(2*snclstr) !cluster position coordinates
      	data spos /0.7, 110.5, 68.2, 166.4, 75.3, 117.0, 78.6, &
      	12.6, 86.8, 41.6, 113.7, 43.1, 124.5, 54.2, 192.3, 150.2/
	real*8 samp(snclstr) !amplitude of each object
      	data samp /0.71, 0.91, 0.62, 0.60, 0.63, 0.56, 0.60, 0.90/
	real*8 ssig(snclstr) !width of each object
      	data ssig /5.34, 5.40, 5.66, 7.06, 8.02, 6.11, 9.61, 9.67/
	real*8 snoise !gaussian noise rms
      	data snoise / 2. /
      	integer dseed!seed for creating mock data,-ve means take it from sys clock
	parameter(dseed=12)
      	real*8 spriorran(4,2) !priors on the parameters
      	!uniform prior on x position
	data spriorran(1,1),spriorran(1,2) / 0. , 200. /
      	!uniform prior on y position
	data spriorran(2,1),spriorran(2,2) / 0. , 200. /
      	!uniform prior on amplitude
	data spriorran(3,1),spriorran(3,2) / 0. , 2. /
      	!uniform prior on sigma
	data spriorran(4,1),spriorran(4,2) / 3. , 12. /

! Parameters for Nested Sampler
	
      	!whether to do multimodal sampling
	logical nest_mmodal 
 	parameter(nest_mmodal=.true.)
	
      	!sample with constant efficiency
	logical nest_ceff
 	parameter(nest_ceff=.false.)
	
      	!max no. of live points
      	integer nest_nlive
	parameter(nest_nlive=1000)
      
      	!tot no. of parameters, should be sdim in most cases but if you need to
      	!store some additional parameters with the actual parameters then
      	!you need to pass them through the likelihood routine
	integer nest_nPar 
      
      	!seed for nested sampler, -ve means take it from sys clock
	integer nest_rseed 
	parameter(nest_rseed=-1)
      
      	!evidence tolerance factor
      	real*8 nest_tol 
      	parameter(nest_tol=0.5)
      
      	!enlargement factor reduction parameter
      	real*8 nest_efr
      	parameter(nest_efr=0.8d0)
      
      	!root for saving posterior files
      	character*100 nest_root
	parameter(nest_root='chains/2-')
	
	!no. of iterations after which the ouput files should be updated
	integer nest_updInt
	parameter(nest_updInt=100)
	
	!null evidence (set it to very high negative no. if null evidence is unknown)
	real*8 nest_Ztol
	parameter(nest_Ztol=-1.d90)
      
      	!max modes expected, for memory allocation
      	integer nest_maxModes 
      	parameter(nest_maxModes=10)
      
      	!no. of parameters to cluster (for mode detection)
      	integer nest_nClsPar
      	parameter(nest_nClsPar=2)
      
      	!whether to resume from a previous run
      	logical nest_resume
      	parameter(nest_resume=.true.)
	
	!parameters to wrap around (0 is F & non-zero T)
	integer nest_pWrap(4)
	
      	!feedback on the sampling progress?
      	logical nest_fb 
      	parameter(nest_fb=.true.)
!=======================================================================


end module params
