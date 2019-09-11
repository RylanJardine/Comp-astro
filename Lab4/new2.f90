!Begin module remove implicit types
module burgers
  implicit none


!Define Subroutine
contains
   subroutine burg_solver(dt, dx, epsilon,n_grid, n_time)
    !Define real parameters, and integers
    !intent in to pass real variable into subroutine
    real(8), intent(in) :: dt, dx,epsilon
    integer, intent(in) :: n_grid, n_time
    real(8) :: x, v(0:n_grid, 0:n_time)
    real(8), parameter :: pi=4.*atan(1.)
    integer :: j, n


    !Open file for writing x,v,t results int0
    open(1, file= 'results.dat', status='replace', action='write')


    !Write in the very first component of our solution
    write(1,*) -0.5*pi, 0, 0
    !set x
    x=-pi/2+epsilon
    !Do loop to set initial conditions for all position gridpoints
    do j=1,n_grid-1
      !iterate over x
      x=x+dx
      !Initial conditions:
      v(j,0)=cos(x)
      !Write in initial conditions
      write(1,*) x, v(j,0), 0
    enddo
    !Write last initial condition
    write(1,*) 0.5*pi, 0, 0



    !Do loop to iterate over all time steps
    do n=1,n_time
      !Write first boundary condition
      write(1,*) -pi/2, 0, dt*n
      !set x
      x=-pi/2+epsilon
      !do loop to iterate over all spatial grid points
      do j=1,n_grid-1
        !Iterate over x
        x=x+dx
        !Solve for v(j,n)
        v(j,n)=v(j,n-1)-0.25*(dt/dx)*((v(j+1,n-1))**2-(v(j-1,n-1))**2)
        !Write in the result of each grid point
        write(1,*) x, v(j,n),n*dt
      enddo
      !Set x
      x=pi/2
      !Write in final boundary condition
      write(1,*) x, 0, n*dt
    enddo
    !Close write file
    close(1)


    !end subroutine
  end subroutine burg_solver
!End module
end module burgers
