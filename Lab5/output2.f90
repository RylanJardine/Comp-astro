
!Open module
module output
  implicit none

!Define subroutine
contains
  subroutine write_output(dx, u, nx, istep, t)
    real,    intent(in) :: dx,  t
    integer, intent(in) :: nx, istep
    real,    intent(in) :: u(0:nx+1)
    integer :: iunit, i
    character(len=100) :: filename

    ! write to a sequence of files called snap_00000, snap_00001 etc
    write(filename,"(a,i5.5)") 'snapftcs_',istep

    !Print timestep
    print "(a,f8.3)", ' writing '//trim(filename)// ' t =',t
    !open file
    open(newunit=iunit,file=filename,status='replace')
    !do loop for writing into output files
    do i=1,nx
      write(iunit,*) i*dx, u(i)
    enddo
    !close and end file, subroutine and module
    close(iunit)

  end subroutine write_output
end module output
