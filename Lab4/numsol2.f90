program numericalsol
  implicit none

    real :: t,tmax,dt,u(100)
    integer :: istep,i
    real,parameter :: nx=100

  !open(1, file= 'results.dat', status='replace', action='write')
    v=1

    t=0

    dt=0.5*dx/v

    dx=x/nx


    do i=1,nx
      x=i*dx
      if (x .LE. 0.25 .or. x > 0.75) then
        u(i)=0
      else
        u(i)=1
      endif
      !write(1,*)t, x,u
    enddo

      !close(1)

  tmax = 1.
  istep = 0
  do while ( t < tmax)
    t = t + dt
    istep = istep + 1
  enddo

end program numericalsol
