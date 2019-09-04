!Begin Program
program burgersolver
  !use module
  use burger
  !Remove all variable implicit types.
  implicit none
  !Define real parameter, set value of convergence limit
  real(8), parameter :: tol=1.e-5,  epsilon=0.01
  !Define real variable
  real(8) :: theta1,v,theta2
  real(8) :: tmax, xlower, xupper,x,t,dx,dt,xmax
  real(8), parameter :: pi=4.*atan(1.)
  integer :: i,j

  tmax=7
  xmax=98

  xlower=-pi/2
  xupper=pi/2


  t=0
  dx=(pi-2*epsilon)/(xmax-1)
  dt=0.2

open(1,file='results.dat', status='replace',action='write')

x= -0.5*pi
t=0
v=0
theta1=x-v*t

write(1,*) x, theta1, t,v

x=-0.5*pi+epsilon

  do j=1,xmax
    v=cos(x)
    theta1=x-v*t
    write(1,*) x, theta1, t,v
    x=x+dx
  enddo

x = 0.5*pi
v=0
theta1=x-v*t

write(1,*) x, theta1, t,v


    do i=1,tmax
      t=t+dt
      x = -0.5*pi
      v=0
      theta1=x-v*t
      write(1,*) x, theta1, t,v
      x=-0.5*pi+epsilon
        do j=1,xmax
          call bg(tol,theta1,x,t)
          v=(x-theta1)/(t)
          write(1,*) x, theta1, t,v
          x=x+dx
          print*, "Theta=",theta1, "x is",x, "t is",t, 'v is',v
        enddo
      x = 0.5*pi
      v=0
      theta1=x-v*t
      write(1,*) x, theta1, t,v


    enddo
close(1)

  !Print statement when code stops


!End program
end program burgersolver
