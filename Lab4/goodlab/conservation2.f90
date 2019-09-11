module burger
  !removing any implicit types
  implicit none

contains
  subroutine burgers_eq2(dt, dx, epsilon, nj, nt)
    !defining the variables we get from run_conserve.f90
    real, intent(in) :: dt, dx, epsilon
    integer, intent(in) :: nj, nt
    !defining our area using inputs from run_conserve.f90
    real :: v(0:nj, 0:nt)
    real :: x
    real, parameter :: pi = 4.*atan(1.0)
    integer :: j,n

    open(1, file= 'results.dat', status='replace', action='write')

    !calculating the initial condition for all x (and writting in results.dat)

    !initial condition at x=0
    write(1,*) -0.5*pi, 0, 0
    do j= 1, nj-1
      !calculating the position
      x = (-pi/2+epsilon) + j*dx
      !expression for the initial condition
      v(j,0) = cos(x)
      !writting the output
      write(1,*) x, v(j,0), 0
    enddo
    !initial condition at x=L
    write(1,*) 0.5*pi, 0, 0

    !iterating over time
    do n=1, nt
      !writting boundary condition to results.dat (x=0)
      write(1,*) -pi/2, 0, dt*n
      !iterating over position
      do j=1, nj-1
        !calculating the position
        x = (-pi/2+epsilon) + j*dx
        !Equation 38 from the workshop booklet
        v(j,n) = v(j,n-1) - 0.25*(dt/dx)*((v(j+1,n-1))**2 - (v(j-1,n-1))**2)
        !writting the output
        write(1,*) x, v(j,n), dt*n
      enddo
      !writting boundary condition to results.dat (x=L)
      write(1,*) pi/2, 0, dt*n
    enddo

    !closing the results.dat file
    close(1)

    !closing the subroutine
  end subroutine burgers_eq2
!closing module
end module burger
