import numpy as np
import matplotlib.pyplot as plt

for i in 0,40,100,200:
    p=str(i)
    if i<10:
        data=np.loadtxt('snapftcs_0000'+p)
    elif i<100:
        data=np.loadtxt('snapftcs_000'+p)
    elif i<1000:
        data=np.loadtxt('snapftcs_00'+p)
    else:
        data=np.loadtxt('snapftcs_0'+p)
    x=data[:,0]
    y=data[:,1]
    plt.plot(x,y)
    plt.show()

for i in 0,40,100,200:
    p=str(i)
    if i<10:
        data=np.loadtxt('snaplax_0000'+p)
    elif i<100:
        data=np.loadtxt('snaplax_000'+p)
    elif i<1000:
        data=np.loadtxt('snaplax_00'+p)
    else:
        data=np.loadtxt('snaplax_0'+p)
    x=data[:,0]
    y=data[:,1]
    plt.title()
    plt.plot(x,y)
    plt.show()
