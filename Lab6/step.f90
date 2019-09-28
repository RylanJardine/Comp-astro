!Begin module
module solve

  implicit none

! begin Subroutine ftcs
contains
  subroutine ftcs(nx,dt,dx,v,u_old,u)

    !Define integers, parameters reals
    integer, intent(in) ::nx
    integer ::i
    !set arrays of size 0 to nx+1, to allow for two buffer zones
    real,intent(in) ::u_old(0:nx+1),dt,dx,v
    real,intent(out) ::u(0:nx+1)



    !iterate in do loop
    do i=1,nx
      !set condition to 'solve'
        u(i)=u_old(i)-0.5*v*(dt/dx)*(u_old(i+1)-u_old(i-1))
    enddo
    !set buffer zones
    u(0)=u(nx)
    u(nx+1)=u(1)
  end subroutine

  !begin subroutine lax
  subroutine lax(nx,dt,dx,v,u_old,u)

    !Define integers, parameters reals
    integer, intent(in) ::nx
    integer ::i
    !set arrays of size 0 to nx+1, to allow for two buffer zones
    real,intent(in) ::u_old(0:nx+1),dt,dx,v
    real,intent(out) ::u(0:nx+1)



    !iterate over do loop
    do i=1,nx
      !set condition to 'solve'
      u(i)=0.5*(u_old(i-1)+u_old(i+1))-v*(dt/(2*dx))*(u_old(i+1)-u_old(i-1))
    enddo
    !set buffer zones
    u(0)=u(nx)
    u(nx+1)=u(1)
  end subroutine

  !begin subroutine upwind
  subroutine upwind(nx,dt,dx,v,u_old,u)

    !Define integers, parameters reals
    integer, intent(in) ::nx
    integer ::i
    !set arrays of size 0 to nx+1, to allow for two buffer zones
    real,intent(in) ::u_old(0:nx+1),dt,dx,v
    real,intent(out) ::u(0:nx+1)

    !begin do loop
    do i=1,nx
      !set condition to 'solve'
      u(i)=u_old(i)-v*(dt/dx)*(u_old(i)-u_old(i-1))
    enddo

    !set buffer zones
    u(0)=u(nx)
    u(nx+1)=u(1)

  end subroutine

  !begin subroutine lax-wendroff
  subroutine laxwendroff(nx,u_old,u,c)

    !Define integers, parameters reals
    integer, intent(in) ::nx
    integer ::i
    !set arrays of size 0 to nx+1, to allow for two buffer zones
    real,intent(in) ::u_old(0:nx+1),c
    real,intent(out) ::u(0:nx+1)
    real:: ustar(0:nx)

    !iterate first over the half integer steps
    do i=0,nx
      !condition to solve
      ustar(i)=0.5*(u_old(i+1)+u_old(i))+c/2*(u_old(i)-u_old(i+1))
    enddo


    !iterate over full integer steps using half integer steps
    do i=1,nx
      !condittion to solve
      u(i)=u_old(i)+c*(ustar(i-1)-ustar(i))
    enddo

    !set buffer zones
    u(0)=u(nx)
    u(nx+1)=u(1)

  end subroutine


!end module

end module
