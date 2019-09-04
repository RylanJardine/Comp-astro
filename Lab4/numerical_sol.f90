module numerical_sol
  implicit none

contains
  subroutine NumSol(dx,dt,vel)
    real, parameter :: pi=4.*atan(1.)
    real, intent(in) :: dx, dt
    real, intent(out) :: vel(629,240)
    integer :: j,n, N_grid
    real :: x

    ! do j=1,21
    !   vel(j,1) = cos((j-1)*dx)
    !   ! j-1 was used to have the right j value because of the indexing in fortran
    ! end do
    ! print*, vel

    N_grid = pi/dx

    x  = -(pi/2)
    do j=1,N_grid+1 !for t=0
      vel(j,1) = cos(x)
      x = x+dx
    end do


    do n=2,240
      vel(1,n-1) = 0
      vel(N_grid+1,n-1) = 0
      do j=2,N_grid
        vel(j,n) = vel(j,n-1)-(0.25)*(dt/dx)*((vel(j+1,n-1))**2-(vel(j-1,n-1))**2)
      end do

    end do



end subroutine NumSol
end module numerical_sol
