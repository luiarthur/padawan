import numpy as np
from numpy.linalg import *
import time # for timing program
import sys # for printing to std out

dat = np.genfromtxt('../data/dat.txt',delimiter=' ')

y = dat[:,0]
X = dat[:,1:11]
K = X.shape[1]
n = y.shape[0]
Xt = X.transpose()
XXi = inv(np.dot(Xt,X))
b_mle = np.dot( np.dot(XXi, Xt), y )

a = 1
b = 1
B = 100000
s2 = 10

def ll(be, sig2):
    y_min_Xb = y - np.dot(X, be)
    return np.dot( y_min_Xb.transpose(), y_min_Xb) / (-2*sig2) - n/2 * np.log(sig2)

def lpb(be):
    return -np.dot( be.transpose(), np.dot(XXi, be) ) / (s2*2)

def lps(sig2):
    return (a-1) * np.log(sig2) - sig2 / b

def mvrnorm(M,S): # STOPPED HERE
    return M + np.dot( cholesky(S) , np.random.normal(0,1,M.shape[0]) )

#ll(b_mle, s2) # test
#lpb(b_mle) # test
#lps(s2) # test
mvrnorm(b_mle, np.eye(b_mle.shape[0]))

csb = 4 * XXi
css = 1
acc_b = 0
acc_s = 0

b_hat = np.zeros(shape=(B,K))
s2_hat = np.ones(B)

# Time this:
start = time.time()
for b in range(1,B):
    b_hat[b] = b_hat[b-1]
    s2_hat[b] = s2_hat[b-1]
    #
    # Update Beta:
    cand = mvrnorm(b_hat[b], csb) 
    q = ( ll(cand, s2_hat[b]) + lpb(cand) 
        - ll(b_hat[b], s2_hat[b]) - lpb(b_hat[b]) )
    if q > np.log( np.random.rand() ):
      b_hat[b] = cand
      acc_b += 1
    #
    # Update s2:
    cand = np.random.normal(s2_hat[b], css)
    if cand > 0:
      q = ( ll(b_hat[b], cand) + lps(cand) 
          - ll(b_hat[b], s2_hat[b]) - lps(s2_hat[b]) )
      if q > np.log( np.random.rand() ):
        s2_hat[b] = cand
        acc_s += 1
    # 
    if b%(B//10) == 0:
      print "\rProgress: %d%s" %(round(b*100/B),"%"),
      sys.stdout.flush()

end = time.time()

print "\n"
print "beta: ", b_hat[B*.9:B].mean(0)
print "s2:   ", s2_hat[B*.9:B].mean()

print "acc_b:", acc_b / B
print "acc_s:", acc_s / B

elapsed_time = end - start # 23 seconds
print "Time Elapsed: ", elapsed_time, "\n"



