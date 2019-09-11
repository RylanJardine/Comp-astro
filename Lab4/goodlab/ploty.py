import numpy as np
import matplotlib.pyplot as plt

data=np.loadtxt('results.dat')
parameters = np.loadtxt('stepping.dat')

nj= int(parameters[3])+1

steps = np.array([0,40,80,120,160,200,240,280])

for i in steps:
    #Import from results.dat file for every 20 steps to account for all space at each time step
    x=data[i*nj:(i+1)*nj,0]
    t=data[i*nj:(i+1)*nj,2]
    v=data[i*nj:(i+1)*nj,1]
    #print(t)
    plt.plot(x,v, label = i)
    plt.legend()




plt.plot(x,v)
plt.show()
