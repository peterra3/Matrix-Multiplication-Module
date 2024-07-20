import sys
import numpy as np

M = int(sys.argv[1])
N = int(sys.argv[2])

f_m0 = open("A.mem", "w") 

np.random.seed(seed=0)

for i in range(int(M*M/N)):
    line = ""
    for j in range(N):
        line = line + str(0) + str(int(np.random.uniform(0,10)))
    f_m0.write(line+"\n")
f_m0.close()

f_m1 = open("B.mem", "w") 

for i in range(int(M*M/N)):
    line = ""
    for j in range(N):
        line = line + str(0) + str(int(np.random.uniform(0,10)))
    f_m1.write(line+"\n")
f_m1.close()
