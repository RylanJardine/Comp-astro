!open module
module init
  !use module
  use grid
  use physics
  implicit none

!begin subroutine for step function
contains
  subroutine set_init(x,nx,u,nu)
    !set variable types
    integer,intent(in) :: nx,nu
    real,intent(in):: x(1:nx)
    real :: prim(nu,0:nx+1)
    real,intent(out):: u(nu,0:nx+1)
    integer :: i



        !iterate over initial boundary conditions
        do i=1,nx
          !define regions for initial conditions
          if (x(i) .LE. 0.25 .or. x(i) > 0.75) then
            !initial condition
            prim(nu,i)=0
          !otherwise other initial condition
          else
            prim(nu,i)=1
        call prim2cons(nu,u(nu,i),nx,prim(nu,i))
          endif


        enddo
        !set buffer zones
        prim(nu,0)=prim(nu,nx)

        call prim2cons(nu,u(nu,0),nx,prim(nu,0))

        prim(nu,nx+1)=prim(nu,1)

        call prim2cons(nu,u(nu,nx+1),nx,prim(nu,nx+1))



  end subroutine

!begin subroutine for sine function
  subroutine set_init2(x,nx,u,nu)
    !set variable types, pull in and out required variables
    integer,intent(in) :: nx,nu
    real,intent(in):: x(1:nx)
    real :: prim(nu,0:nx+1)
    real,intent(out) :: u(nu,0:nx+1)
    real,parameter :: pi=4.*atan(1.)
    integer :: i

        !do loop to iterate over initial condition for all x
        do i=1,nx
          prim(nu,i)=sin(2*pi*x(i))
          call prim2cons(nu,u(nu,i),nx,prim(nu,i))

        enddo
        !set buffer zones
        prim(nu,0)=prim(nu,nx)

        call prim2cons(nu,u(nu,0),nx,prim(nu,0))

        prim(nu,nx+1)=prim(nu,1)

        call prim2cons(nu,u(nu,nx+1),nx,prim(nu,nx+1))

  end subroutine

!end module

end module
