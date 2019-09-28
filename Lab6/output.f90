
!Open module
module output
  implicit none

!Define subroutine
contains
  subroutine write_output(x, u, nx, istep, t)
    real,    intent(in) ::   t
    integer, intent(in) :: nx, istep
    real,    intent(in) :: u(0:nx+1), x(1:nx)
    integer :: iunit, i
    character(len=100) :: filename

    ! write to a sequence of files called snap_00000, snap_00001 etc
    write(filename,"(a,i5.5)") 'snap_',istep

    !Print timestep
    print "(a,f8.3)", ' writing '//trim(filename)// ' t =',t
    !open file
    open(newunit=iunit,file=filename,status='replace')
    !do loop for writing into output files
    do i=1,nx
      write(iunit,*) x(i), u(i)
    enddo
    !close and end file, subroutine and module
    close(iunit)

  end subroutine write_output
end module output
