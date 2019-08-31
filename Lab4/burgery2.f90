!Begin module
  module burger
    !Remove all variable implicit types.
    implicit none
    !Components of module
  contains
    !Define a subroutine
    subroutine bg(tol,theta1,x,t)
      !Pass into module a real variable
      real(8), intent(in) :: tol
      !Pass out of module a real variable
      real(8), intent(out) :: theta1,x,t
      !Define real variables
      real(8) :: theta21,theta2
      !Define integer
      integer :: i

      !Print statement

      !Set initial x1
      theta1=0.
      !Initiialise i value
      i=1
      !Set initial difference
      theta21=abs(theta2-theta1)

      !x=1
      !t=0.2


      !Do loop, to stop when condition no longer satisifed
    do while(theta21>tol)
      !Iterate over i
      i=i+1
      !Define iteration of x-position
      !theta1=theta2-(cos(theta2)-(x-theta2)/t)/(-sin(theta2)+1/t)
      theta1=theta2-(cos(theta2)-(x-theta2)/t)/(-sin(theta2)+1/t)
      !Define difference criteria
      theta21=abs(theta2-theta1)

    !print statement of ith step
      print*,('step no(i):'),i-1
    !print statement of ith x-position
      print*,('x(i):'),theta1
    !print statement of error
      print*,('error:'),theta21
      !Redefine variable for further iteration
      theta2=theta1

    !End do loop
    enddo

    !End subroutine
  end subroutine bg
  !End module
end module
