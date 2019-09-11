
#import packages
import numpy as np
import matplotlib.pyplot as plt

#load data and parameters
data=np.loadtxt('results.dat')
parameters = np.loadtxt('steps.dat')


#set nj used to calulate the number of spatial points per timestep
nj= int(parameters[3])+1


#define for loop to iterate over number of timesteps we want to plot (every 20th)
for i in range(0,240,20):
    #Import from results.dat file for every njth steps  discontinously to define separate timesteps
    x=data[i*nj:(i+1)*nj,0]
    t=data[i*nj:(i+1)*nj,2]
    v=data[i*nj:(i+1)*nj,1]
    #produce plot
    plt.plot(x,v)
    plt.xlabel('x')
    plt.ylabel('v(x,t)')

plt.savefig('numburg')
plt.show()

data2=np.loadtxt('results2.dat')

#define nx
nx=100

#define for loop to iterate over number of timesteps we want to plot
for i in range(0,8):
    #Import from results.dat file every 100 steps discontinously to define separate timesteps
    x1=data2[i*nx:(i+1)*nx,0]
    theta1=data2[i*nx:(i+1)*nx,1]
    t1=data2[i*nx:(i+1)*nx,2]
    v1=data2[i*nx:(i+1)*nx,3]
    #produce plot
    plt.plot(x1,v1)
    plt.xlabel('x')
    plt.ylabel('v(x,t)')
plt.savefig('analburg')
plt.show()
