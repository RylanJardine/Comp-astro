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
    real ::vs(nu),fl(nu),fr(nu)


    ! if (u_old(un,i)<u_old(un,i+1)) then
    !   vs=0.5*(u_old(un,i)+u_old(un,i+1))
    !   if (vs>0) then
    !     call get_f(nu,u_old(i),f,lambda)
    !   else
    !     call get_f(nu,u_old(i+1),f,lambda)
    !   end if
    ! else
    !   if (u_old(i)>0) then
    !     call get_f(nu,u_old(i),f,lambda)
    !   else if (u_old(i+1)<0) then
    !     call get_f(nu,u_old(i+1),f,lambda)
    !   else
    !     f(un,i)=0
    !   end if
    ! end if

    call get_f(nu,ul,f,lambda)
      fl(nu)=f(nu)
      lambdal=lambda
    call get_f(nu,ur,f,lambda)
      fr(nu)=f(nu)
      lambdar=lambda
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
