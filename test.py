import numpy as np
import sys

N = int(sys.argv[1])

mem0 = open("A.mem")
depth_mem0 = len(mem0.readlines())

M = np.sqrt(depth_mem0*N)

A = np.zeros((int(M),int(M)))
B = np.zeros((int(M),int(M)))
D = np.zeros((int(M),int(M)))

ascii_thank = r'''
                                   ___
                               ,-""   `.
       Thank Mr. Goose       ,'  _   ' )`-._
                            /  ,' `-._<.===-'
                           /  /
                          /  ;
              _          /   ;
 (`._    _.-"" ""--..__,'    |
 <_  `-""                     \
  <`-                          :
   (__   <__.                  ;
     `-.   '-.__.      _.'    /
        \      `-.__,-'    _,'
         `._    ,    /__,-'
            ""._\__,'< <____
                 | |  `----.`.
                 | |        \ `.
                 ; |___      \-``
                 \   --<
                  `.`.<
                    `-'
                    
'''


ascii_hisssss = r'''
                                                        _...--.
                                        _____......----'     .'
                                  _..-''                   .'
                                .'                       ./
                        _.--._.'                       .' |
                     .-'                           .-.'  /
  HISSSSS!!        .'   _.-.                     .  \   '
                 .'  .'   .'    _    .-.        / `./  :
               .'  .'   .'  .--' `.  |  \  |`. |     .'
            _.'  .'   .' `.'       `-'   \ / |.'   .'
         _.'  .-'   .'     `-.            `      .'
       .'   .'    .'          `-.._ _ _ _ .-.    :
      /    /o _.-'               .--'   .'   \   |
    .'-.__..-'                  /..    .`    / .'
  .'   . '                       /.'/.'     /  |
 `---'                                   _.'   '
                                       /.'    .'
                                        /.'/.'
                                        
'''

mem0 = open("A.mem")
i=0
for line in mem0:
    for n in range(N):
        row = int(i/M)*N + n
        column = int(i%M)  
        A[row][column] = 16*int(line[2*(N-1-n)],16)+int(line[2*(N-1-n)+1],16)
    i+=1

mem1 = open("B.mem")
i=0
for line in mem1:
    for n in range(N):
        row = int(i%M)#int(i/M)*N + n
        column = int(i/M)*N + n# int(i%M)  
        B[row][column] = 16*int(line[2*(N-1-n)],16)+int(line[2*(N-1-n)+1],16)
    i+=1


mem2 = open("D.mem")
i=0
for line in mem2:
    if(line[0]!="/"):
        quadrant = int(i/(N*N))
        row=(int(quadrant/(M/N)))*N+int((i-((quadrant)*N*N))/N)
        column= int(((quadrant)%(M/N)))*N+int((i-((quadrant)*N*N))%N)
        D[row][column] = int(line,16)
        i+=1
truth=np.matmul(A,B)
print("Matrix 0 (A) is")
print(A)    
print("Matrix 1 (B) is")
print(B)  
print("Answer is")
print(truth)
print("Your answer is:")
print(D)
print("##########")
if np.array_equal(D,truth):
    print(ascii_thank)
else:
    print(ascii_hisssss)
print("##########")
