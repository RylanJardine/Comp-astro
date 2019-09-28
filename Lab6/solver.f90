!Begin program
program numericalsol
  !Use modules
    use solve
    use grid
    use init
    use output
    !remove implicit variable types
    implicit none
    !define varibables
    integer,parameter :: nx=100
    real:: dx,dt,t,c
    real :: x(1:nx)
    real :: u(0:nx+1),u_old(0:nx+1)
    real,parameter::v=1,xmax=1.,xmin=0.,tmax=1.
    integer::istep,i,j

    !select courant factor
    print*, "what is the Courant Factor?"
    read*,c

    !Set step size, time step initial time and initial step
    dx=(xmax-xmin)/(nx-1)
    t=0.
    dt=(c*dx)/v
    istep=0

    !Call grid
    call set_grid(nx,dx,x,xmin)

    !select initial conditions using if statment to call correct subroutine
    print*,"select (1) for sine initial conditions, (2) for step function"
    read*,j
    if (j==1) then
      call set_init2(x,nx,u)
      ! set uold=u to store only 2 timesteps
      call write_output(x, u, nx, istep, t)
      u_old=u
      !write into output file
    else if (j==2) then
      call set_init(x,nx,u)
      !write into output file
      call write_output(x, u, nx, istep, t)
      ! set uold=u to store only 2 timesteps
      u_old=u
    end if



    !Select pde solver method and iterate over timesteps then write output file accordingly
    print*,"select (1) for ftcs, (2) for lax, (3) for upwind or (4) for Lax-Wendroff"
    read*,i

    !ftcs
    if (i==1) then
      !iterate whilst condition is true
      do while(t<tmax)
        !iterate over time
        t=t+dt
        !Iterate over iteration number
        istep=istep+1
        !call solver routine and write output file
        call ftcs(nx,dt,dx,v,u_old,u)
        call write_output(x, u, nx, istep, t)
        !set uold=u
        u_old=u
      enddo

      !lax
    else if (i==2) then
      !iterate whilst condition is true
      do while(t<tmax)
        !iterate over time
        t=t+dt
        !Iterate over iteration number
        istep=istep+1
        !call solver routine and write output file
        call lax(nx,dt,dx,v,u_old,u)
        call write_output(x, u, nx, istep, t)
        !set uold=u
        u_old=u
      enddo


      !upwind
    else if (i==3) then
      !iterate whilst condition is true
      do while(t<tmax)
        !iterate over time
        t=t+dt
        !Iterate over iteration number
        istep=istep+1
        !call solver routine and write output file
        call upwind(nx,dt,dx,v,u_old,u)
        call write_output(x, u, nx, istep, t)
        !set uold=u
        u_old=u
      enddo


      !lax-wendroff
    else if (i==4) then
      !iterate whilst condition is true
      do while(t<tmax)
        !iterate over time
        t=t+dt
        !Iterate over iteration number
        istep=istep+1
        !call solver routine and write output file
        call laxwendroff(nx,u_old,u,c)
        call write_output(x, u, nx, istep, t)
        !set uold=u
        u_old=u
      enddo
    endif


    !end program
  end program
