module step
  use output
  implicit none

contains
  subroutine set_step()
    integer ::istep ,i
    integer,parameter :: nx=100
    !set arrays of size 0 to nx+1, to allow for two buffer zones
    real ::u(0:nx+1),u_prior(0:nx+1),t,tmax,dt,dx,v,x



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










  end subroutine set_step
end module step
