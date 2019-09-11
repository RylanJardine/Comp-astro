!Begin Program
program burgersolves
  !use modules
  use burgers
  use burgersolver
  !Remove all variable implicit types.
  implicit none
  !Define real and integer parameters
  real(8) :: dt,dx,epsilon,theta1
  Integer :: n_grid, n_time
  real(8), parameter :: pi=4.*atan(1.)
  !Call subroutine bourg
  call bourg(theta1)

  !Define steplength and timestep
  dt=0.005
  dx= 0.005*pi
  !Define epsilon
  epsilon = 0.01
  !Define grid size
  n_grid = nint((pi-2*epsilon)/dx)

  !Define number of timesteps
  n_time = nint(1.4/dt)


  !Open file for writing out, which keeps track of timestep and steplength Number and size
  open(2, file= 'steps.dat', status='replace', action='write')
  write(2,*) dt, dx,epsilon, n_grid, n_time
  close(2)
  !Call burg_solver subroutine
  call burg_solver(dt, dx,epsilon, n_grid, n_time)





!End program
end program burgersolves
