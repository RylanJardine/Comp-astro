module heat
  implicit none

contains
   subroutine pde(T)
    real :: alpha, kappa, dx, dt, L
    real, parameter :: pi=4.*atan(1.)
    integer :: j, n,i,k
    real, intent(out) :: T(21,200)


    L=1
    dx=0.05
    dt=27.4
    alpha=0.6

    print*, "alpha is"
    read*,alpha
    open(1,file='results.dat', status='replace',action='write')


    do j=1,21

      T(j,1)=100*sin(pi*(j-1)*dx/L)
      write(1,*) dx*(j-1), T(j,1), 0
    enddo


    T(1,:)=0
    T(21,:)=0

    do n=1,199
        write(1,*) dx*0, T(1,n+1), n*dt
      do j=2,20
        T(j,n+1)=alpha*T(j+1,n)+(1-2*alpha)*T(j,n)+alpha*T(j-1,n)
        write(1,*) dx*(j-1), T(j,n+1),n*dt
      enddo
      write(1,*) dx*20, T(21,n+1), n*dt
    enddo

    close(1)

  end subroutine pde
!End module
end module heat
