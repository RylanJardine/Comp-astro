!Begin Program
program heatsolver
  !use module
  use heat
  !Remove all variable implicit types.
  implicit none
  !Define real array
  real :: T(21,201)

  !Call subroutine Solver
  call pde(T)




!End program
end program heatsolver
