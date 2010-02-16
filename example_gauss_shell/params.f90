! Include file for example nested sampler program 'Gaussian Rings'

module params
implicit none

! Toy Model Parameters

	!dimensionality
      	integer sdim
      	parameter(sdim=10)
      
      	!no. of modes to generate
      	integer sModes 
	parameter(sModes=2)
      
      	!width of the Gaussian profile of each ring
	real*8 sw(sModes)
	data sw /0.1d0,0.1d0/
      
      	!width of the rings
      	real*8 sr(sModes)
	data sr /2.d0,2.d0/
      
      	!Center of the rings. 
      	!Centers in the 1st dimensions are set here while in 
      	!all the other dimensions, they are set to 0 in main.f90
      	real*8 sc(sModes,sdim)
	data sc(1,1),sc(2,1) /-3.5d0,3.5d0/
      
      	!priors on the parameters
      	!uniform priors (-6,6) are used for all dimensions & are set in main.f90
      	real*8 spriorran(sdim,2)
      


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
	parameter(nest_nPar=sdim)
      
      	!seed for nested sampler, -ve means take it from sys clock
	integer nest_rseed 
	parameter(nest_rseed=-1)
      
      	!evidence tolerance factor
      	real*8 nest_tol 
      	parameter(nest_tol=0.5)
      
      	!enlargement factor reduction parameter
      	real*8 nest_efr
      	parameter(nest_efr=0.5d0)
      
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
	integer nest_pWrap(sdim)
	
      	!feedback on the sampling progress?
      	logical nest_fb 
      	parameter(nest_fb=.true.)
!=======================================================================


end module params
