#import packages
import numpy as np
import matplotlib.pyplot as plt


#For loop to select specific timesteps
for i in 0,198:
    #define string and if statement to select correct files for plotting
    p=str(i)
    if i<10:
        data=np.loadtxt('snap_0000'+p)
    elif i<100:
        data=np.loadtxt('snap_000'+p)
    elif i<1000:
        data=np.loadtxt('snap_00'+p)
    else:
        data=np.loadtxt('snap_0'+p)
    #load data and plot
    x=data[:,0]
    y=data[:,1]
    plt.xlabel('x')
    plt.ylabel('u(x,t)')
    plt.title('FTCS')
    plt.plot(x,y)
    plt.show()

data2=np.loadtxt('laxwsinc10')
data3=np.loadtxt('laxwsinc11')
x=data2[:,0]
y=data2[:,1]
x2=data3[:,0]
y2=data3[:,1]
plt.plot(x,y,label='t=0',linestyle='-')
plt.plot(x2,y2,label='t=1',linestyle='--')
plt.xlabel('x')
plt.ylabel('u(x,t)')
plt.legend(loc='best')
plt.show()
