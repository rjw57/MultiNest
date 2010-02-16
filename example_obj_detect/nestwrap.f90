module nestwrapper

!  Nested sampling includes
   use Nested
   use params
   use like
   implicit none
   
 contains

!-----*-----------------------------------------------------------------

subroutine nest_Sample
   integer nclusters,context !total number of clusters found
   integer maxNode !variables used by the posterior routine
   
   call nestRun(nest_mmodal,nest_ceff,nest_nlive,nest_tol,nest_efr,sdim,nest_nPar, &
   nest_nClsPar,nest_maxModes,nest_updInt,nest_Ztol,nest_root,nest_rseed,nest_pWrap, &
   nest_fb,nest_resume,getLogLike,context)

end subroutine nest_Sample

!-----*-----------------------------------------------------------------

! Wrapper around Likelihood Function
! Cube(1:n_dim) has nonphysical parameters
! scale Cube(1:n_dim) & return the scaled parameters in Cube(1:n_dim) &
! additional parameters in Cube(n_dim+1:nPar)
! return the log-likelihood in lnew
subroutine getLogLike(Cube,n_dim,nPar,lnew,context)

   integer n_dim,nPar,context
   real*8 lnew,Cube(nPar)
   
   !call your loglike function here   
   !lnew=loglike(likeindx,Cube)
   call slikelihood(Cube,lnew)

end subroutine getLogLike

!-----*-----------------------------------------------------------------

end module nestwrapper
