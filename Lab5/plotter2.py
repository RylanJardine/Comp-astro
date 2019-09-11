#import packages
import numpy as np
import matplotlib.pyplot as plt


#For loop to select specific timesteps
for i in 0,40,100,200:
    #define string and if statement to select correct files for plotting
    p=str(i)
    if i<10:
        data=np.loadtxt('snapftcs_0000'+p)
    elif i<100:
        data=np.loadtxt('snapftcs_000'+p)
    elif i<1000:
        data=np.loadtxt('snapftcs_00'+p)
    else:
        data=np.loadtxt('snapftcs_0'+p)
    #load data and plot
    x=data[:,0]
    y=data[:,1]
    plt.xlabel('x')
    plt.ylabel('u(x,t)')
    plt.title('FTCS')
    plt.plot(x,y)
    plt.show()


#For loop to select specific timesteps
for i in 0,40,100,200:
    #define string and if statement to select correct files for plotting
    p=str(i)
    if i<10:
        data=np.loadtxt('snaplax_0000'+p)
    elif i<100:
        data=np.loadtxt('snaplax_000'+p)
    elif i<1000:
        data=np.loadtxt('snaplax_00'+p)
    else:
        data=np.loadtxt('snaplax_0'+p)
    #load data and plot
    x=data[:,0]
    y=data[:,1]
    plt.xlabel('x')
    plt.ylabel('u(x,t)')
    plt.title('Lax')
    plt.plot(x,y)
    plt.show()
