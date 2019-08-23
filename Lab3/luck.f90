program luck
  implicit none
  real :: T(1000,1000), alpha, kappa
  real, parameter :: pi=4.*atan(1.)
  integer :: j, n,i,k

  print*,'Select N'
  read*,k

  print*,'Select alpha'
  read*,alpha

  print*,'Select iterations'
  read*,i
  j=2
  T(n,1)=0
  T(n,k)=0
  T(1,j)=sin(j*pi)

  do n=1,i
    T(n+1,j)=alpha*T(n,j+1)+(1-2*alpha)*T(n,j)+alpha*T(n,j-1)
    print*,T(n,j)
  end do



end program luck
