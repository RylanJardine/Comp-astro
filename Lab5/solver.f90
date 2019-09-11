!Begin program
program numericalsol
  !Use modules
    use laxmethod
    use ftcsmethod
    !remove implicit variable types
    implicit none


    !Call subroutines
    call lax()

    call ftcs()

    !End program
  end program
