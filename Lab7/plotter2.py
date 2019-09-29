#import packages
import numpy as np
import matplotlib.pyplot as plt


#For loop to select specific timesteps
# for i in 0,198:
#     #define string and if statement to select correct files for plotting
#     p=str(i)
#     if i<10:
#         data=np.loadtxt('snap_0000'+p)
#     elif i<100:
#         data=np.loadtxt('snap_000'+p)
#     elif i<1000:
#         data=np.loadtxt('snap_00'+p)
#     else:
#         data=np.loadtxt('snap_0'+p)
#     #load data and plot
#     x=data[:,0]
#     y=data[:,1]
#     plt.xlabel('x')
#     plt.ylabel('u(x,t)')
#     plt.title('FTCS')
#     plt.plot(x,y)
#     plt.show()

plt.figure()
data1=np.loadtxt('kur00')
data2=np.loadtxt('kur05')
data3=np.loadtxt('kur1')
x1=data1[:,0]
y1=data1[:,1]
x2=data2[:,0]
y2=data2[:,1]
x3=data3[:,0]
y3=data3[:,1]
plt.plot(x1,y1,label='t=0',linestyle='-')
plt.plot(x2,y2,label='t=0.5',linestyle='-')
plt.plot(x3,y3,label='t=1.0',linestyle='-')
# plt.xlabel('x')
# plt.ylabel('u(x,t)')
# plt.legend(loc='best')
# plt.show()
#
# plt.figure()
data4=np.loadtxt('god00')
data5=np.loadtxt('god05')
data6=np.loadtxt('god1')
x4=data4[:,0]
y4=data4[:,1]
x5=data5[:,0]
y5=data5[:,1]
x6=data6[:,0]
y6=data6[:,1]
plt.plot(x4,y4,label='t=0',linestyle='--')
plt.plot(x5,y5,label='t=0.5',linestyle='--')
plt.plot(x6,y6,label='t=1.0',linestyle='--')
plt.xlabel('x')
plt.ylabel('u(x,t)')
plt.legend(loc='best')
plt.show()
