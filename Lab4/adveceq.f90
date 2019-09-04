program adveceq

!  use Newton_Raph
  use numerical_sol
  implicit none
  real,parameter :: er=0.01
  real :: theta, dt, v, dx,x, t, vel(630,240)
  real, parameter :: pi=4.*atan(1.)
  integer:: i, j

  open(1, file='adveceq_analytical.dat', status='replace', action='write')
  open(2, file='results.dat', status='replace', action='write')

  dx = (pi-2*er)/100
  t = 0.2
  dt = 0.2

  x  = -(pi/2)+er
  do i=1,100 !for t=0
    v = cos(x)
    write(1, *) v
    x = x+dx
  end do

  ! do j=1,5
  !   x  = -(pi/2)+er
  !   do i=1,100
  !     call NR(er,x,t,theta)
  !     !print*, "theta is: ", theta, "x is: ", x, "t is: ",t, "v is:", v
  !     v = (x-theta)/t
  !     write(1, *) v
  !     x = x+dx
  !   end do
  !   !print*, x
  !   t = t+dt
  ! end do



  dt = 0.005
  dx = 0.005
  call NumSol(dx,dt,vel)
  !print*, vel
  write(2, *) vel




  close(1)
  close(2)

end program adveceq
