import numpy as np
import matplotlib.pyplot as plt

data=np.loadtxt('results.dat')


nx=630


for i in range(0,60):
    #Import from results.dat file for every 20 steps to account for all space at each time step
    x=data[i*nx:(i+1)*nx,0]
    t=data[i*nx:(i+1)*nx,2]
    v=data[i*nx:(i+1)*nx,1]
    plt.plot(x,v)


plt.plot(x,v)
plt.show()
