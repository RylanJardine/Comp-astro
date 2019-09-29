!Begin module
module solve
use flux
use flux_god
! use flux_god
  implicit none

! begin Subroutine ftcs
contains
  subroutine ftcs(nx,dt,dx,v,u_old,u,nu)

    !Define integers, parameters reals
    integer, intent(in) ::nx,nu
    integer ::i
    !set arrays of size 0 to nx+1, to allow for two buffer zones
    real,intent(in) ::u_old(nu,0:nx+1),dt,dx,v
    real,intent(out) ::u(nu,0:nx+1)



    !iterate in do loop
    do i=1,nx
      !set condition to 'solve'
        u(nu,i)=u_old(nu,i)-0.5*v*(dt/dx)*(u_old(nu,i+1)-u_old(nu,i-1))
    enddo
    !set buffer zones
    u(nu,0)=u(nu,nx)
    u(nu,nx+1)=u(nu,1)
  end subroutine

  !begin subroutine lax
  subroutine lax(nx,dt,dx,v,u_old,u,nu)

    !Define integers, parameters reals
    integer, intent(in) ::nx,nu
    integer ::i
    !set arrays of size 0 to nx+1, to allow for two buffer zones
    real,intent(in) ::u_old(nu,0:nx+1),dt,dx,v
    real,intent(out) ::u(nu,0:nx+1)



    !iterate over do loop
    do i=1,nx
      !set condition to 'solve'
      u(nu,i)=0.5*(u_old(nu,i-1)+u_old(nu,i+1))-v*(dt/(2*dx))*(u_old(nu,i+1)-u_old(nu,i-1))
    enddo
    !set buffer zones
    u(nu,0)=u(nu,nx)
    u(nu,nx+1)=u(nu,1)
  end subroutine

  !begin subroutine upwind
  subroutine upwind(nx,dt,dx,v,u_old,u,nu)

    !Define integers, parameters reals
    integer, intent(in) ::nx,nu
    integer ::i
    !set arrays of size 0 to nx+1, to allow for two buffer zones
    real,intent(in) ::u_old(nu,0:nx+1),dt,dx,v
    real,intent(out) ::u(nu,0:nx+1)

    !begin do loop
    do i=1,nx
      !set condition to 'solve'
      u(nu,i)=u_old(nu,i)-v*(dt/dx)*(u_old(nu,i)-u_old(nu,i-1))
    enddo

    !set buffer zones
    u(nu,0)=u(nu,nx)
    u(nu,nx+1)=u(nu,1)

  end subroutine

  !begin subroutine lax-wendroff
  subroutine laxwendroff(nx,u_old,u,c,nu)

    !Define integers, parameters reals
    integer, intent(in) ::nx,nu
    integer ::i
    !set arrays of size 0 to nx+1, to allow for two buffer zones
    real,intent(in) ::u_old(nu,0:nx+1),c
    real,intent(out) ::u(nu,0:nx+1)
    real:: ustar(nu,0:nx)

    !iterate first over the half integer steps
    do i=0,nx
      !condition to solve
      ustar(nu,i)=0.5*(u_old(nu,i+1)+u_old(nu,i))+c/2*(u_old(nu,i)-u_old(nu,i+1))
    enddo


    !iterate over full integer steps using half integer steps
    do i=1,nx
      !condittion to solve
      u(nu,i)=u_old(nu,i)+c*(ustar(nu,i-1)-ustar(nu,i))
    enddo

    !set buffer zones
    u(nu,0)=u(nu,nx)
    u(nu,nx+1)=u(nu,1)

  end subroutine

  subroutine finitevolume(nx,u_old,u,nu,dt,dx,dtnew,k)

    !Define integers, parameters reals


!begin subroutine for sine function
    !set variable types, pull in and o::nx,nu
    integer ::i,k
    !set arrays of size 0 to nx+1, to allow for two buffer zones
    real,intent(in) ::u_old(nu,0:nx+1),dx,dt
    real,intent(out) ::u(nu,0:nx+1)
    real :: fr(nu),fl(nu),ul(nu),ur(nu),dtnew,lambdamax(0:nx+1),lambdal,lambdar,f(nu)
    integer,intent(in) ::nx,nu

    !iterate first over the half integer steps

!second do loop for trial run
if (k==1) then
    do i=0,nx+1
      ul(nu)=u_old(nu,i)
      ur(nu)=u_old(nu,i+1)
      !condition to solve\
      call get_fluxgod(nu,ul,ur,f,lambdar)
      fr(nu)=f(nu)

      ul(nu)=u_old(nu,i-1)
      ur(nu)=u_old(nu,i)
      call get_fluxgod(nu,ul,ur,f,lambdal)
      fl(nu)=f(nu)
      lambdamax(i)=max(abs(lambdal),abs(lambdar))

      u(nu,i)=u_old(nu,i)-(dt/dx)*(fr(nu)-fl(nu))
    enddo
    call get_time_step(dtnew,lambdamax,dx,nx,nu)

    !set buffer zones
    u(nu,0)=u(nu,nx)
    u(nu,nx+1)=u(nu,1)

  else if (k==2) then

    do i=0,nx+1
      ul(nu)=u_old(nu,i)
      ur(nu)=u_old(nu,i+1)
      !condition to solve\
      call get_flux(nu,ul,ur,f,lambdar)
      fr(nu)=f(nu)

      ul(nu)=u_old(nu,i-1)
      ur(nu)=u_old(nu,i)
      call get_flux(nu,ul,ur,f,lambdal)
      fl(nu)=f(nu)
      lambdamax(i)=max(abs(lambdal),abs(lambdar))

      u(nu,i)=u_old(nu,i)-(dt/dx)*(fr(nu)-fl(nu))
    enddo
    call get_time_step(dtnew,lambdamax,dx,nx,nu)

    !set buffer zones
    u(nu,0)=u(nu,nx)
    u(nu,nx+1)=u(nu,1)
  end if

  end subroutine



!end module

end module
