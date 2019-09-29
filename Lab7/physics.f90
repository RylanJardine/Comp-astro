module physics
  implicit none

contains
  subroutine cons2prim(nu,u,nx,prim)
    integer,intent(in) ::nx,nu
    real,intent(in) ::u(nu,0:nx+1)
    real,intent(out) :: prim(nu,0:nx+1)

    prim=u

  end subroutine

  subroutine prim2cons(nu,u,nx,prim)
    integer,intent(in) ::nx,nu
    real,intent(out) ::u(nu,0:nx+1)
    real,intent(in) :: prim(nu,0:nx+1)

    u=prim

  end subroutine


  subroutine get_f(nu,u,f,lambda)
    integer,intent(in) :: nu
    real,intent(in) :: u(nu)
    real,intent(out) :: f(nu),lambda


    lambda=abs(u(nu))

    f(nu)=0.5*u(nu)**2


  end subroutine

  subroutine get_time_step(dtnew,lambdamax,dx,nx,nu)
    integer,intent(in) :: nx,nu
    real,intent(in) :: dx,lambdamax(0:nx+1)
    real,intent(out) :: dtnew
    real:: endlambda,u(nu,0:nx+1),prim(nu,0:nx+1)

    call cons2prim(nu,u,nx,prim)
    endlambda=maxval(lambdamax(0:nx+1))
    dtnew=dx/endlambda

  end subroutine
end module
