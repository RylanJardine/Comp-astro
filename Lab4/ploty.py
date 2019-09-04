import numpy as np
import matplotlib.pyplot as plt

data=np.loadtxt('results.dat')
x=data[:,0]
theta=data[:,1]
t=data[:,2]
v=data[:,3]

nx=100


for i in range(0,8):
    #Import from results.dat file for every 20 steps to account for all space at each time step
    x=data[i*nx:(i+1)*nx,0]
    theta=data[i*nx:(i+1)*nx,1]
    t=data[i*nx:(i+1)*nx,2]
    v=data[i*nx:(i+1)*nx,3]
    plt.plot(x,v)


plt.plot(x,v)
plt.show()
