program burgers
  use newton_raphson
  implicit none
  real(8), parameter :: tol=1.e-5, pi = 4.*atan(1.0), epsilon = 0.01
  integer, parameter :: tmax = 7, xmax = 100
  real(8) :: theta
  real(8) :: x, t, v, guess, dt, dx
  !real(8) :: tmax, xmin, xmax, epsilon
  integer :: i, j

!  tmax = 1.4

  !xmin = -0.5*pi + epsilon
  !xmax = 0.5*pi -epsilon


  dx = (pi-2*epsilon)/xmax
  print*, dx
  dt = 0.2
  t = 0.
  x = -0.5*pi+epsilon

  print*,"What is your initial guess?"
  read*, guess

  open(1, file= 'results.dat', status='replace', action='write')

  do j= 1, tmax
    !t = j*dt
    do i=1, xmax
      !x = i*dx
      if (j==1 .and. i>1) then
        write(1,*) x, t, cos(x)
        !print*, x, t, cos(x)
        !read*,
        !x = x + dx
      elseif (j==1 .and. i==1) then
        call nr_method(tol, x, t, guess, theta)
          print*, 'I made it to 2'
      else
        call nr_method(tol, x, t, theta, theta)
      endif
        x = x + dx
      v = (x-theta)/t
      write(1,*) x, t, v
    enddo
  enddo

  close(1)

end program  burgers
