!Begin Program
program heatsolver
  !use module
  use heat
  !Remove all variable implicit types.
  implicit none
  !Define real variable
  real :: T(21,200)

  !Call subroutine Solver
  call pde(T)




!End program
end program heatsolver
