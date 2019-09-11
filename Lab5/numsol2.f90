!Begin module
module ftcsmethod
  !use module
  use output
  !remove variable types
  implicit none

!Subroutine
contains
  subroutine ftcs()

    !Define integers, parameters reals
    integer ::istep ,i
    integer,parameter :: nx=100
    !set arrays of size 0 to nx+1, to allow for two buffer zones
    real ::u(0:nx+1),u_prior(0:nx+1),t,tmax,dt,dx,v,x


    !define initial parameters and set v,dt,dx
    t=0.
    v=1.
    dx=0.01
    dt=0.5*dx/v
    x=0.
    istep = 0

    !do loop for initial conditions
    do i=1,nx
      !set x to iterate over
      x=(i-1)*dx
      !define regions defined for initial conditions
      if (x .LE. 0.25 .or. x > 0.75) then
        !initial condition
        u(i)=0
      !otherwise other initial condition
      else
        u(i)=1
      endif
      !set u_prior=u
      u_prior=u
    enddo
!Call output subroutine,to write into
call write_output(dx, u, nx, istep, t)
  !set tmax
  tmax = 1.


  ! loop to do while condition is true
  do while ( t < tmax-dt)
    !iterate over t
    t = t + dt
    !step for writing into output
    istep=istep+1
    !set the buffer zones such that we have periodic boundary conditions
    u_prior(0)=u_prior(nx)
    u_prior(nx+1)=u_prior(1)
    !do loop to iterate across position
    do i=1,nx
      !set condition to 'solve'
      u(i)=u_prior(i)-0.5*v*(dt/dx)*(u_prior(i+1)-u_prior(i-1))
    enddo
    !write into output file
    call write_output(dx, u, nx, istep, t)
    !set u_prior=u
    u_prior=u
  enddo

  !end subroutine and module
 end subroutine ftcs
end module ftcsmethod
