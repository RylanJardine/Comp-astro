module writeoutput
implicit none
  contains
    subroutine outfile(nx,dx,u,istep)
          integer, intent(in) :: nx
          real(8),intent(in) ::dx, u(0:nx+1)
          integer ::i, iunit
          character(len=4-) :: filename

          write(filename, "(a,i5.5)") "step_",istep

          open(newunit=iunit,file=filename,status='replace')
          write(unit,*)'#             x               u(x,t)'

          do i=1,nx
                write(iunit,*) i*dx, u(i) 


          close(iunit)

    end subroutine outfile

end module writeoutput
