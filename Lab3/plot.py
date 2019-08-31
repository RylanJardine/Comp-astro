
#Import packages
import numpy as np
import matplotlib.pyplot as plt

#load data
data=np.loadtxt('results.dat')

#set a value for use in iteration
nx=20

#open array error
error=[]
#set L=1m
L=1
#set kappa=2.28*10-5 m^2/s
kappa=2.28*10**(-5)

#For loop for plotting every 10th timestep
for i in range(0,200,10):
    #Import from results.dat file for every 20 steps to account for all space at each time step
    x=data[i*nx+i:(i+1)*nx+i+1,0]
    y=data[i*nx+i:(i+1)*nx+i+1,1]
    t=data[i*nx+i:(i+1)*nx+i+1,2]

    #figure 1 numerical solution
    plt.figure(1)
    plt.plot(x,y)
    plt.xlabel('x(m)')
    plt.ylabel(r' T(x,t)$^{\circ}$K ')
    plt.title('Numerical solution to the Heat Equation')
    plt.savefig('Numericalsolution')

    #Define exact solution
    exact=100*np.exp(-np.pi**2*kappa*t/L**2)*np.sin(np.pi*x/L)

    #figure 2 error
    plt.figure(2)
    plt.xlabel('x(m)')
    plt.ylabel(r'T(x,t)$^{\circ}$K')
    plt.plot(x,y-exact)
    plt.title('Numerical Error to the Heat Equation')
    plt.savefig('NumericalError')


#show plots
plt.show()
