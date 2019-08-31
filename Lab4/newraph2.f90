!Begin module
  module newboi
    !Remove all variable implicit types.
    implicit none
    !Components of module
  contains
    !Define a subroutine
    subroutine NR(epsilon,x1)
      !Pass into module a real variable
      real(8), intent(in) :: epsilon
      !Pass out of module a real variable
      real(8), intent(out) :: x1
      !Define real variables
      real(8) :: x2,x21
      !Define integer
      integer :: i

      !Print statement
      print*, "Select starting position"
      !Read statement for initial position
      read*,x2
      !Set initial x1
      x1=0.
      !Initiialise i value
      i=1
      !Set initial difference
      x21=abs(x2-x1)
      !Do loop, to stop when condition no longer satisifed
    do while(x21>epsilon)

      !Iterate over i
      i=i+1
      !Define iteration of x-position
      x1=x2+(cos(x2)-x2)/(sin(x2)+1)
      !Define difference criteria
      x21=abs(x2-x1)

    !print statement of ith step
      print*,('step no(i):'),i-1
    !print statement of ith x-position
      print*,('x(i):'),x1
    !print statement of error
      print*,('error:'),x21
      !Redefine variable for further iteration
      x2=x1

    !End do loop
    enddo

    !End subroutine
  end subroutine NR
  !End module
end module
