!begin module
module grid
  implicit none

!subroutine
contains
  subroutine set_grid(nx,dx,x,xmin)
    !Define parameters in and out
    integer,intent(in) :: nx
    real,intent(in) :: dx,xmin
    real,intent(out) :: x(1:nx)
    integer :: i

    !set initial x
    x(1)=xmin


    !iterate over all i for x to create a grid of positions
    do i=2,nx

      x(i)=x(i-1)+dx


    enddo
    

    !end subroutine
  end subroutine
end module
