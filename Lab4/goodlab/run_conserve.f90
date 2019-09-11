program run_conserve
  use burger
  implicit none
  real :: dt, dx, epsilon
  integer :: nj, nt
  real, parameter :: pi = 4.*atan(1.0)

  dt=0.005
  dx= pi*0.005
  epsilon = 0.01

  nj = (abs(pi/2 - epsilon)- (-pi/2+epsilon))/dx
  nt = 1.4/dt

  open(2, file= 'stepping.dat', status='replace', action='write')
  write(2,*) dt, dx, epsilon, nj, nt
  close(2)

  call burgers_eq2(dt, dx, epsilon, nj, nt)

end program run_conserve
