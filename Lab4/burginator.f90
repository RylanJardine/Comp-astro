!Begin module
module burgersolver
  !use module
  use burger
  !Remove all variable implicit types.
  implicit none
contains
  !Define Subroutine
  subroutine bourg(theta1)
      !Define real parameters and integers
      real(8), parameter :: tol=1.e-5,  epsilon=0.01
      integer,parameter :: xmax=98,tmax=7
      !Define real variables and integers
      real(8) :: theta1,v
      real(8) :: x,t,dx,dt
      real(8), parameter :: pi=4.*atan(1.)
      integer :: i,j

      !Set timestep and step length
      dx=(pi-2*epsilon)/(xmax-1)
      dt=0.2
    !open write file
    open(1,file='results2.dat', status='replace',action='write')
    !Set intiial x, v, t and theta
    x= -0.5*pi
    t=0
    v=0
    theta1=x-v*t

    !write initial condition into file
    write(1,*) x, theta1, t,v
    !set x
    x=-0.5*pi+epsilon
    ! iterate over spatial coordinates for the initial time
      do j=1,xmax
        !initial condition
        v=cos(x)
        !Define theta1
        theta1=x-v*t
        !write into file
        write(1,*) x, theta1, t,v
        !iterate over x
        x=x+dx
      enddo

    !Set x,v,theta1 for second boundary condition
    x = 0.5*pi
    v=0
    theta1=x-v*t

    !write into file
    write(1,*) x, theta1, t,v

    !do loop to iterate over all time
        do i=1,tmax
          !iterate over t
          t=t+dt
          !set first boundary condition of x,v,theta1
          x = -0.5*pi
          v=0
          theta1=x-v*t
          !write into file
          write(1,*) x, theta1, t,v
          !reset x for iteration
          x=-0.5*pi+epsilon
          !Do loop to iterate over all spatial coordinates
            do j=1,xmax
              !Call subroutine to find theta1
              call bg(tol,theta1,x,t)
              !Find v
              v=(x-theta1)/(t)
              !Write results into file for each grid point
              write(1,*) x, theta1, t,v
              !Iterate over x
              x=x+dx
            enddo
            !set final boundary conditions and write into file
          x = 0.5*pi
          v=0
          theta1=x-v*t
          write(1,*) x, theta1, t,v
        enddo

        !close write statement
    close(1)

      !Print statement when code stops
    end subroutine bourg

!End program
end module burgersolver
