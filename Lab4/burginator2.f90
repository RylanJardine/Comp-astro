!Begin Program
program burgersolver
  !use module
  use burger
  !Remove all variable implicit types.
  implicit none
  !Define real parameter, set value of convergence limit
  real(8), parameter :: tol=1.e-5
  !Define real variable
  real(8) :: theta1,epsilon,v
  real(8) :: tmax, xlower, xupper,x,t,dx
  real(8), parameter :: pi=4.*atan(1.)
  real(8):: theta2,guess
  integer :: i,j

  tmax=1.4
  epsilon=0.01
  xlower=-pi/2
  xupper=pi/2

  x=1
  t=0.2

  dx=(pi-2*epsilon)/100
  !Call subroutine NR

  print*, "Select starting position"
  !Read statement for initial position
  read*,theta2




    ! do j=1,101
    !   x=pi/2+epsilon+dx*(i-1)
    !   do i=1,8
    !     t=tmax*(i-1)
    !     if i==0 .and. j==0
    !       call bg(tol,theta1,x,t)
    !     elseif (j==0)
    !     else
    !     v=(x-theta1)/t
    !     print*,v
    !   enddo
    ! enddo


  !Print statement when code stops
  print*, "Solution to f(x)=0 is: x=",theta1


!End program
end program burgersolver
