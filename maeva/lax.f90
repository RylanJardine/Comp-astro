program FTCS
  use output
  implicit none
  integer, parameter :: nx=101
  real :: u(0:nx+1), u_old(0:nx+1), dt, dx, t, tmax, x
  integer :: i, istep

  !nx is set to include buffer zone

  dx = 0.01
  dt = 0.5*dx !since v=1

  open(1,file='results_FTCS.dat', status='replace',action='write')

  x=0.
  t=0.

  !setup our initial conditions
  istep= 1
  do i = 1, nx
    x = (i-1)*dx
    if (x .LE. 0.25 .or. x>0.75) then
      u(i) =0
    else
      u(i) = 1
    endif
    call write_output(dx, x, u, nx, istep, t)
    u_old = u
  enddo

  !the main loop
  tmax = 1.
  do while ( t < tmax)
    t = t + dt
    istep = istep + 1
    u_old(0) = u_old(nx)
    u_old(nx+1) = u_old(1)
    do i = 1, nx
      u(i) = 0.5*(u_old(i-1)+ u_old(i+1)) + 0.5*dt*(u_old(i-1) - u_old(i+1))/(dx)
    enddo
    call write_output(dx, x, u, nx, istep, t)
    u_old = u
  enddo


  close(1)

end program FTCS
