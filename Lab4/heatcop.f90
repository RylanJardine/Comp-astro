!Begin module remove implicit types
module heat
  implicit none


!Define Subroutine
contains
   subroutine pde(v)
     !Define real parameters, integers and arrays
    real(8) :: alpha, dx, dt, L,x,n_grid
    real(8), parameter :: pi=4.*atan(1.)
    integer(8) :: j, n
    !intent out to pass real variable through to program
    real(8), intent(out) :: v(629,281)

    !Length of rod (in metres)
    L=1
    !change in position in metres
    dx=0.005
    !Timestep(seconds)
    dt=0.005
    !alpha=dimensionless parameter, with alpha<0.5 for a stable solution
    alpha=0.25
    x=-pi/2
    n_grid=pi/dx
    !open file
    open(1,file='results.dat', status='replace',action='write')

!   Do loop to set initial conditions for all position gridpoints
    do j=1,n_grid+1

      !Initial condition:
      v(j,1)=cos(x)

      write(1,*) x, v(j,1), 0
      x=x+dx

    enddo

    !Set boundary conditions
    ! v(1,:)=0
    ! v(629,:)=0


    !Do loop to iterate over all time steps
    do n=1,280
        x=-pi/2
      write(1,*) -pi/2, v(1,n+1), n*dt
      print*,-pi/2, v(1,n+1), n*dt
      do j=2,n_grid+1
        x=x+dx
        v(j,n+1)=v(j,n)-0.25*dt/dx*((v(j+1,n)**2)-v(j-1,n)**2)
        !v(j,n)=v(j,n-1)-0.25*(dt/dx)*((v(j+1,n-1))**2-(v(j-1,n-1))**2)
        write(1,*) -pi/2+dx*(j-1), v(j,n+1),n*dt
      enddo
      write(1,*) pi/2, v(629,n+1), n*dt
    enddo
    close(1)

    ! do n=2,240
    !   v(1,n-1)=0
    !   v(n_grid+1,n-1)=0
    !   do j=2, n_grid
    !     v(j,n)=v(j,n-1)-0.25*(dt/dx)*((v(j+1,n-1))**2-(v(j-1,n-1))**2)
    !     write(1,*)-pi/2+dx*(j-1), v(j,n+1),n*dt
    !   enddo
    ! enddo

!close(1)
    !end subroutine
  end subroutine pde
!End module
end module heat
