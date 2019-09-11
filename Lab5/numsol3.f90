program numericalsol
  implicit none

    integer ::istep ,i,n
    integer,parameter :: nx=101
    real(8) ::u(0:nx+1),u_old(0:nx+1),t,tmax,dt,x,dx


  open(1, file= 'results.dat', status='replace', action='write')


    t=0.



    dx=0.01
    dt=0.5*dx
    x=0.

    do i=0,nx
      x=i*dx
      if (x .LE. 0.25 .or. x > 0.75) then
        u(i)=0
      else
        u(i)=1
      endif
      write(1,*)t, x,u(i)
      u_old=u
    enddo


  tmax = 1.
  istep = 0
  do while ( t < tmax)
    x=0.
    t = t + dt
    istep=istep+1
    u_old(0)=u_old(nx)
    u_old(nx+1)=u_old(1)
    do i=1,nx
        x=x+dx
      u(i)=u_old(i)-0.5*(dt/dx)*(u_old(i+1)-u_old(i-1))
      write(1,*)t, x,u(i)
    enddo
    u_old=u
  enddo

  close(1)


end program numericalsol
