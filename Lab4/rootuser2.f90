!Begin Program
program rootfinder
  !use module
  use newboi
  !Remove all variable implicit types.
  implicit none
  !Define real parameter, set value of convergence limit
  real(8), parameter :: epsilon=1.e-5
  !Define real variable
  real(8) :: x1

  !Call subroutine NR
  call NR(epsilon,x1)

  !Print statement when code stops
  print*, "Solution to f(x)=0 is: x=",x1


!End program
end program rootfinder
