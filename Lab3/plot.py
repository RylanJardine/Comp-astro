import numpy as np
import matplotlib.pyplot as plt


data=np.loadtxt('results.dat')


nx=20


for i in (0,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200):
    x=data[i*nx+i:(i+1)*nx+i+1,0]
    y=data[i*nx+i:(i+1)*nx+i+1,1]
    t=data[i*nx+i:(i+1)*nx+i+1,2]

    #plt.ylim(0,100)
    plt.figure(1)
    plt.plot(x,y)
    plt.figure(2)
    plt.plot(x,y-100*np.exp(-np.pi**2*2.28*10**(-5)*t)*np.sin(np.pi*x))



plt.show()
