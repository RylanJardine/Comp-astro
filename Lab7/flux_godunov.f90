module flux_god
  use physics
  implicit none

contains
  subroutine get_fluxgod(nu,ul,ur,f,lambda)
    integer,intent(in) ::nu
    real,intent(in) :: ul(nu),ur(nu)
    real,intent(out) :: f(nu)
    real,intent(inout) :: lambda
    real :: lambdal,lambdar
    real ::vs(nu),fl(nu),fr(nu)



    call get_f(nu,ul,fl,lambdal)
    call get_f(nu,ur,fr,lambdar)
        if (ur(nu)<ul(nu)) then
          vs(nu)=0.5*(ul(nu)+ur(nu))
          if (vs(nu)>0) then
            f(nu)=fl(nu)
            lambda=lambdal
          else
            f(nu)=fr(nu)
            lambda=lambdar
          end if
        else
          if (ul(nu)>0) then
            f(nu)=fl(nu)
            lambda=lambdal
          else if (ur(nu)<0) then
            f(nu)=fr(nu)
            lambda=lambdar
          else
            f(nu)=0
            lambda=0
          end if
        end if

  end subroutine
end module
