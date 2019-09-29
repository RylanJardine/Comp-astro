module flux
  use physics
  implicit none

contains
  subroutine get_flux(nu,ul,ur,f,lambda)
    integer,intent(in) ::nu
    real,intent(in) :: ul(nu),ur(nu)
    real,intent(out) :: f(nu)
    real,intent(inout) :: lambda
    real :: lambdal,lambdar
    real ::fl(nu),fr(nu)



    call get_f(nu,ul,fl,lambdal)
    call get_f(nu,ur,fr,lambdar)
    lambda=max(abs(lambdal),abs(lambdar))
    f(nu)=0.5*(fl(nu)+fr(nu)-lambda*(ur(nu)-ul(nu)))

  end subroutine
end module
