!open module
module init
  !use module
  use grid
  implicit none

!begin subroutine for step function
contains
  subroutine set_init(x,nx,u)
    !set variable types
    integer,intent(in) :: nx
    real,intent(in):: x(1:nx)
    real,intent(out) :: u(0:nx+1)
    integer :: i



        !iterate over initial boundary conditions
        do i=1,nx
          !define regions for initial conditions
          if (x(i) .LE. 0.25 .or. x(i) > 0.75) then
            !initial condition
            u(i)=0
          !otherwise other initial condition
          else
            u(i)=1
          endif


        enddo
        !set buffer zones
        u(0)=u(nx)
        u(nx+1)=u(1)


  end subroutine

!begin subroutine for sine function
  subroutine set_init2(x,nx,u)
    !set variable types, pull in and out required variables
    integer,intent(in) :: nx
    real,intent(in):: x(1:nx)
    real,intent(out) :: u(0:nx+1)
    real,parameter :: pi=4.*atan(1.)
    integer :: i

        !do loop to iterate over initial condition for all x
        do i=1,nx
          u(i)=sin(2*pi*x(i))
        enddo
        !set buffer zones
        u(0)=u(nx)
        u(nx+1)=u(1)

  end subroutine

!end module

end module
