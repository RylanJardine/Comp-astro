module newton_raphson
  implicit none

contains
  subroutine nr_method(tol, x, t, theta_old, theta)
    real(8), intent(in) :: tol, x, t, theta_old
    real(8), intent(out) :: theta
    real(8) :: theta_diff
    integer :: i


    theta=0.
    i=0
    !print*, theta_old, x, t
    theta_diff = abs(theta-theta_old)

    do while (theta_diff > tol)
      i=i+1
      theta = theta_old - (cos(theta_old)-(x-theta_old)/t)/(-sin(theta_old)+1/t)
      theta_diff = abs(theta-theta_old)
      print*,"Iteration:",i
      print*,"Error:",theta_diff
      print*,"Root value is:", theta
      !theta_old=theta
    enddo
  end subroutine nr_method
end module newton_raphson
