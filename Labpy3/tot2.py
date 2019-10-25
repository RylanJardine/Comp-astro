"""
ASP 3162 - Workshop 11

Integration of Nuclear Reaction Networks
"""

import numpy as np
import matplotlib.pyplot as plt
import matplotlib as mpl
from numba import jit


default_tmax = 9.24
default_composition = np.array([0.25, 0, 0])


@jit(nopython=True)

def r_3a(t9, rho = 1, sc = 1):
    """Compute lambda for 3a rate and its reverse"""
    # q = 7.275 MeV
    t9m1 = 1/t9
    t9log = np.log(t9)
    t913 = np.exp(t9log * 1/3)
    t9m13 = 1/t913
    t953 = t913**5
    t93 = t9**3
    rho2 = rho**2
    ra3 = (
        + np.exp(
        -9.710520e-01
        -3.706000e+01*t9m13
        +2.934930e+01*t913
        -1.155070e+02*t9
        -1.000000e+01*t953
        -1.333330e+00*t9log)
        + np.exp(
        -2.435050e+01
        -4.126560e+00*t9m1
        -1.349000e+01*t9m13
        +2.142590e+01*t913
        -1.347690e+00*t9
        +8.798160e-02*t953
        -1.316530e+01*t9log)
        + np.exp(
        -1.178840e+01
        -1.024460e+00*t9m1
        -2.357000e+01*t9m13
        +2.048860e+01*t913
        -1.298820e+01*t9
        -2.000000e+01*t953
        -2.166670e+00*t9log))
    f = ra3 * rho2 * sc / 6
    rev = 2.00e+20 * t93 * np.exp(-84.424e+0 * t9m1)
    r = rev * ra3
    return f, r


def r_2c(t9, rho = 1, sc = 1):
    # q = 13.933 MeV
    t9a = t9 / (1 + 0.0396e0 * t9)
    t9a13 = t9a**(1/3)
    t9a56 = t9a**(5/6)
    t932 = t9**(3/2)
    t9m32 = 1/t932
    t9m1 = 1/t9
    t93 = t932**2
    r24 = (4.27e+26 * t9a56 * t9m32 *
           np.exp(-84.165e+0 / t9a13 - 2.12e-03 * t93))
    f = 0.5e0 * rho * r24*sc
    rev = 2.56e10 * t932 * np.exp(-161.6858e+0 * t9m1)
    r = rev * r24
    return f, r


f3a1,r3a1,f2c1,r2c1,f3a107,r3a107,f2c107,r2c107=[],[],[],[],[],[],[],[]

T9=10**np.arange(-1,1,0.01)



f2c1,r2c1=r_2c(T9,1)
f2c107,r2c107=r_2c(T9,10**(7))
f3a1,r3a1=r_3a(T9,1)
f3a107,r3a107=r_3a(T9,10**(7))


plt.figure()
plt.plot(T9,r2c1,label='r2c',color='b')
plt.plot(T9,f2c1,label='f2c',color='g')
plt.plot(T9,r2c107,label='r2c',linestyle='--',color='r')
plt.plot(T9,f2c107,label='f2c',linestyle='--',color='c')
plt.ylim(1.e-30,1.e20)
plt.yscale('log')
plt.xscale('log')

plt.legend(loc='best')

plt.plot(T9,r3a1,label='r3a',color='m')
plt.plot(T9,f3a1,label='f3a',color='y')
plt.plot(T9,r3a107,label='r3a',linestyle='--',color='k')
plt.plot(T9,f3a107,label='f3a',linestyle='--',color='0.75')
plt.legend(loc='best')
plt.ylim(1.e-30,1.e20)
plt.yscale('log')
plt.xscale('log')
plt.xlabel(r'$T/(10^9$K)')
plt.ylabel('Reaction Rate [1/s]')
plt.show()




class Integrand(object):


    def initial(self):
        """return initial conditions for x and y"""
        raise NotImplementedError()

    def final(self, x, y):
        """return True if reached fianl point, False otherwise"""
        raise NotImplementedError()

    def __call__(self,x,y):
        """return vector of derivatives for given x and y"""
        raise NotImplementedError()

    def integrate(self,method,**kwargs):
        """evaluate the integral and return x coordinate and values"""
        integrator=method(self,self.initial,self.final,**kwargs)
        return integrator.run()




class LE(Integrand):
    """class to integrate Lane Emden Equation"""

    def __init__(self, n):
        self.n=n

    def initial(self):
        """provide initial values for integration"""
        x=0
        y=np.array((1,0))
        return x,y

    def final(self,x,y):
        """termination for y <= 0"""
        return y[0]<=0


    def __call__(self,x,y):
        """method to compute derivatives of Lane Emden Equation"""
        n=self.n
        if x==0:
            f0=0
            f1=-1/3
        else:
            f0=y[1]
            f1=-2*y[1]/x-y[0]**n
        return np.array((f0,f1))

class LELimitX(LE):
    def __init__(self,n,xmax=10):
        self.xmax=xmax
        super().__init__(n)


    def final(self,x,y):
        """ termination condition with limit"""
        if self.xmax is None:
            return y[0] <= 0
        return y[0] <= 0 or x > self.xmax

class LEAnalytic(object):
    def __init__(self,n):
        self.n=n
        if n==0:
            self.lea=self.lea0
        elif n==1:
            self.lea=self.lea1
        elif n==5:
            self.lea =self.lea5
        else:
            raise Exception(f'No analytic LE solution for n={n}')


    def lea0(self,x):
        """function to return analytic solution to LEE for n=0"""
        return 1-x**2/6

    def lea1(self,x):
        """function to return analytic solution to LEE for n=1"""
        ii=x==0
        y=np.empty_like(x)
        y[ii]=1
        ii=np.logical_not(ii)
        y[ii]=np.sin(x[ii])/x[ii]
        return y

    def lea5(self,x):
        """function to return analytic solution to LEE for n=5"""
        return (1+(1/3)*x**2)**(-1/2)

    def truncate(self,x,y):
        """truncate analytic x,y arrays to positive values of y"""
        ii=np.where(y[:]<0)[0]
        if len(ii)==0:
            return x,y
        i=ii[0]
        return x[:i], y[:i]

    def integrate(self,x=None,h=1e-5,xmax=10,**kwargs):
        if x is None:
            x=np.arange(0,xmax,h)
        y=self.lea(x)
        return self.truncate(x,y)


class Integrate(object):
    """integration driver class"""

    def __init__(self,f,initial,final):
        self.f=f
        self.initial=initial
        self.final=final

    def run(self):
        """ execute integration"""
        x,y=self.initial()
        xi=list()
        yi=list()
        print(x,y)
        h=self.h
        while not self.final(x,y):
            xi.append(x)
            yi.append(y)
            x,y,h=self.advance(x,y)
        return np.array(xi), np.array(yi)

class StepIntegrate(Integrate):
        """intermediate helper class to set step size"""
        def __init__(self,*args,h=0.001,**kwargs):
            super().__init__(*args,**kwargs)
            self.h=h

class ImprovedEuler(StepIntegrate):
    def advance(self,x,y):
        """Improved Euler integration step"""
        f=self.f
        h=self.h
        f0=f(x,y)
        yb=y+h*f0
        y=y+h*(f0+f(x+h,yb))/2
        x+=h
        return x,y



class RK4(StepIntegrate):
    def advance(self,x,y,h):
        """4th order Runge Kutta integration step"""
        f=self.f
        # h=self.h
        k1=f(x,y)
        k2=f(x+h/2,y+h*k1/2)
        k3=f(x+h/2,y+h*k2/2)
        k4=f(x+h,y+h*k3)
        phi=1/6*(k1+2*k2+2*k3+k4)
        y=y+h*phi
        x+=h
        return x,y



class Euler(StepIntegrate):


    def advance(self,x,y):
            """Euler integration step"""
            f=self.f
            h=self.h
            y=y+h*f(x,y)
            x+=h
            return x,y


class Network(Integrand):
    """Class to integrate Reaction Network"""
    def __init__(self,
                t9 = 2.3,
                rho = 1.,
                tmax = default_tmax,
                y0 = default_composition,
                ):
            """obtain and store parameters"""
            self.t9 = t9
            self.rho = rho
            self.tmax = tmax
            self.y0 = y0
    def __call__(self, t, y,return_jacobian=False):
            """method to compute derivatives of the reaction network"""
            t9, rho = self.thermo(t, y)
            # t9 = self.t9
            # rho = self.rho
            fa, ra = r_3a(t9, rho)
            fc, rc = r_2c(t9, rho)
            # da=-0.5*y[0]**3*(fa-ra)
            # dc=1/6*y[0]**3*(fa-ra)-y[1]**2*(fc-rc)
            # dm=0.5*y[1]**2*(fc-rc)
            # print(ra)
            da=-0.5*y[0]**3*fa+3*ra*y[1]
            dc=1/6*y[0]**3*fa-fc*y[1]**2-ra*y[1]+2*rc*y[2]
            dm=0.5*fc*y[1]**2-rc*y[2]
            # print(-ra*y[0],3*ra,0,0.5*y[0]**2*fa,-2*fc*y[1]-ra,2*rc,0,fc*y[1],-rc)
            b = np.array([da, dc, dm])
            if return_jacobian:
                l = np.array([
                    [-fa*y[0]**2*3/2,3*ra,0],
                    [0.5*y[0]**2*fa,-2*fc*y[1]-ra,2*rc],
                    [0,fc*y[1],-rc]
                    ])
                return b,l

            return b
    def thermo(self,t,y):
        """return thermodynamics conditions"""
        # return self.t9, self.rho
        """call thermodynamic function and return t9 and tho"""
        return self._thermo(t, y)

    def initial(self):
            """provide initial values for integration"""
            t = 0
            y = np.array(self.y0)
            return t, y

    def final(self, t, y):
            """termination for t <= tmax"""
            return t > self.tmax



class NetworkImplicit(StepIntegrate):
    """implicit integrator for network"""
    def solver(self,x,y,h):
        """return solution vector for dy"""
        b,l= self.f(x,y,return_jacobian=True)
        m=np.diag(np.tile(1/h,3))-l
        dy=np.linalg.solve(m,b)
        return dy

    def advance(self,x,y):
        """implicit advancing time step"""
        h=self.h
        dy=self.solver(x,y,h)
        return x+h, y+dy, h

class Adaptive(object):
    """Adaptive driver template"""
    def __init__(self,*args,
                    rmax=1.e-3,
                    thres=1e-4,
                    **kwargs):
                kwargs.setdefault('h',1.e99)
                super().__init__(*args, **kwargs)
                self.rmax=rmax
                self.thres=thres


    def advance(self,x,y):
            """adaptive advancing"""
            yp = self.f(x, y)+1.e-99

            self.h=np.min(abs((y+self.thres)/yp))*self.rmax
            h0=self.h

            while True:
                xn, yn =super().advance(x,y,h0)
                # xn, yn =super().advance(x,y,h0)
                if np.all(yn>=0):
                    break

                self.h*=0.5



            self.h = np.minimum(self.h, 2*h0)
            h=self.h
            # xn, yn = super().advance(x,y,h)
            return xn, yn, h


class AdaptiveRK4(Adaptive,RK4):
    """Adaptive RK4 solver"""
    # def __init__(self,x,y,h):
         #     print(self.y)


class AdaptiveImplicit():
    """Adaptive RK4 solver"""
    def __init__(self,*args,
                rmax=1.e-2,
                thres=1.e-12,
                **kwargs):
        kwargs.setdefault('h',1.)
        super().__init__(*args,**kwargs)
        self.rmax=rmax
        self.thres=thres

    def advance(self,x,y):
        """adaptive advancing"""
        h=self.h
        print(h)
        while True:
            dy=self.solver(x,y,h)
            yn=y+dy
            hn=h*np.min(self.rmax*(yn+self.thres)/(np.abs(dy)+1.e-99))
            if np.all(yn>=0) and (hn>0.5*h):
                break
            h*=0.5
        hn=np.minimum(hn,2*h)
        self.h=hn
        return x+h,yn, h

class AdaptiveNetworkImplicit(AdaptiveImplicit,NetworkImplicit):
    """Adaptive Implicit solver"""

class ThermoNetwork(Network):
    """Network with time-dependent thermodynamics"""
    def __init__(self, *args, **kwargs):
        self._thermo = kwargs.pop('thermo')
        kwargs['t9'] = np.nan
        kwargs['rho'] = np.nan
        super().__init__(*args, **kwargs)

class T9Rho(object):
    """Thermodynamics function for free exansion"""
    def __init__(self, tp = 10, rhop = 1e7):
        self.tp=tp
        self.rhop=rhop
        self.tau3i=-1/(3*446*rhop**(-1/2))
    def __call__(self,t,y):
        """return time-dependent t9 and rho"""
        f = np.exp(t * self.tau3i)
        return self.tp * f, self.rhop * f ** 3


#plotting and comparing both analytic and numerical methods
class Plot_6(object):
    def __init__(self):
        #set the range of x positions
        # x=np.arange(0,10+h,h)
        #use lelimitx for a specified n to ensure we stop integrating after a specified number of steps
        thermo=T9Rho(tp=10,rhop=1.e6)
        le=ThermoNetwork(thermo=thermo)
        #analytic solution
        # x1,y1=LEAnalytic(n=n).integrate(x)
        #integrate using the euler method
        x,y=le.integrate(method=AdaptiveNetworkImplicit)
        # x,y=le.integrate(method=RK4,h=1.e9)

        f=plt.figure()
        ax=f.add_subplot(111)
        # for i in range(0,len(y[:,0])):
        #     print(y[i+1,0]-y[i:0])
        #plot both analytic and numerical solutions of theta
        ax.plot(x,y[:,0],label='4He')
        ax.plot(x,y[:,1],label='12C')
        ax.plot(x,y[:,2],label='24Mg')
        ax.plot(x,y[:,0]*4+y[:,1]*12+y[:,2]*24)
        # ax.plot(x,y[:,0],label='Numerical',linestyle='--')

        ax.set_xlabel(r'$\xi$')
        ax.set_ylabel(r'$\theta$')
        ax.set_yscale('log')
        ax.set_xscale('log')


        ax.legend(loc='best')
        f.tight_layout()
        f.show()
        self.f = f
        self.ax = ax


class Plot_7(object):
    def __init__(self):
        #set the range of x positions
        # x=np.arange(0,10+h,h)
        #use lelimitx for a specified n to ensure we stop integrating after a specified number of steps
        le=Network()
        #analytic solution
        # x1,y1=LEAnalytic(n=n).integrate(x)
        #integrate using the euler method
        x,y=le.integrate(method=AdaptiveNetworkImplicit)
        # x,y=le.integrate(method=RK4,h=1.e9)

        f=plt.figure()
        ax=f.add_subplot(111)
        # for i in range(0,len(y[:,0])):
        #     print(y[i+1,0]-y[i:0])
        #plot both analytic and numerical solutions of theta
        ax.plot(x,y[:,0],label='4He')
        ax.plot(x,y[:,1],label='12C')
        ax.plot(x,y[:,2],label='24Mg')
        ax.plot(x,y[:,0]*4+y[:,1]*12+y[:,2]*24)
        # ax.plot(x,y[:,0],label='Numerical',linestyle='--')

        ax.set_xlabel(r'$\xi$')
        ax.set_ylabel(r'$\theta$')
        # ax.set_yscale('log')
        ax.set_xscale('log')


        ax.legend(loc='best')
        f.tight_layout()
        f.show()
        self.f = f
        self.ax = ax
