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
      real(8), intent(out) :: theta1
      !Define real variables
      real(8) :: theta21,theta2,x,t

      !set initial guess for theta2
      theta2=-1.

      !Set initial difference
      theta21=abs(theta2-theta1)


      !do while loop to iterate until condition theta21<tol is reached
    do while(theta21>tol)

      !Find theta1
      theta1=theta2-(cos(theta2)-(x-theta2)/t)/(-sin(theta2)+1/t)
      !define error
      theta21=abs(theta2-theta1)
      !set theta2=theta1
      theta2=theta1

    !End do loop
    enddo

    !End subroutine
  end subroutine bg
  !End module
end module
