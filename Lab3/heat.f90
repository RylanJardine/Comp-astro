!Begin module remove implicit types
module heat
  implicit none


!Define Subroutine
contains
   subroutine pde(T)
     !Define real parameters, integers and arrays
    real :: alpha, dx, dt, L
    real, parameter :: pi=4.*atan(1.)
    integer :: j, n
    !intent out to pass real variable through to program
    real, intent(out) :: T(21,201)

    !Length of rod (in metres)
    L=1
    !change in position in metres
    dx=0.05
    !Timestep(seconds)
    dt=27.4
    !alpha=dimensionless parameter, with alpha<0.5 for a stable solution
    alpha=0.25

    !open file
    open(1,file='results.dat', status='replace',action='write')

   !Do loop to set initial conditions for all position gridpoints
    do j=1,21
      !Initial condition:
      T(j,1)=100*sin(pi*(j-1)*dx/L)
      !Write into file
      write(1,*) dx*(j-1), T(j,1), 0
    enddo

    !Set boundary conditions
    T(1,:)=0
    T(21,:)=0

    !Do loop to iterate over all time steps
    do n=1,200
      !Write boundary condition
        write(1,*) dx*0, T(1,n+1), n*dt
      !Do loop to iterate over position
      do j=2,20
        !Iterative heat equation
        T(j,n+1)=alpha*T(j+1,n)+(1-2*alpha)*T(j,n)+alpha*T(j-1,n)
        !write out each iteration
        write(1,*) dx*(j-1), T(j,n+1),n*dt
      enddo
      !Write Boundary condition
      write(1,*) dx*20, T(21,n+1), n*dt
    enddo
    !Close write file
    close(1)

    !end subroutine
  end subroutine pde
!End module
end module heat
