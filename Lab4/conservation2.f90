module burger
  implicit none

contains
  subroutine burgers_eq2(dt, dx, epsilon, nj, nt)
    real, intent(in) :: dt, dx, epsilon
    integer, intent(in) :: nj, nt
    real :: v(0:nj, 0:nt)
    real :: l, x
    real, parameter :: pi = 4.*atan(1.0)
    integer :: j,n


    !allocate(v(nn,nt))

    open(1, file= 'results.dat', status='replace', action='write')

    !stating the boundary conditions

    !v(1,:) = 0
    !v(630,:) =0

    !x = -pi/2

    !calculating the initial condition for all x (and writting in results.dat)

    do j= 0, nj
      x = (-pi/2 + epsilon) + j*dx
      v(j,0) = cos(x)
      write(1,*) x, v(j,0), 0
    enddo

    x = -pi/2

    !iterating over time
    do n=1, nt
      !writting boundary condition to results.dat (x=0)
      !write(1,*) -pi/2, v(1,n+1), dt*n
      !iterating over position
      do j=1, nj-1
        v(j,n) = v(j,n-1) - 0.25*(dt/dx)*((v(j+1,n-1))**2 - (v(j-1,n-1))**2)
        write(1,*) x, v(j,n), dt*n
        x = x + dx
      enddo
      !writting boundary condition to results.dat (x=L)
      !write(1,*) pi/2, v(630,n+1), dt*n
      x = -pi/2
    enddo

    !closing the results.dat file
    close(1)

  end subroutine burgers_eq2

end module burger
