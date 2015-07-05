{% highlight julia linenos %}
##= Install Packages if needed:
#  Pkg.add("Distributions")
#  Pkg.add("DataFrames")
#  Pkg.add("Gadfly")
#=#
#ta = 1:size(X,2); (ta .!= 3) & (ta .!= 5)
#blas_set_num_thread(8)

println("Loading packages (20 seconds)...")
using DataFrames, Distributions, Gadfly
println("Finished loading packages...")

const dat = readdlm("../data/dat.txt")
n,k1 = size(dat)
const k = k1-1

const y =dat[:,1]
const X = dat[:,2:end]

const XXi = inv(X'X)
const s = 100
const mle = XXi*X'y

a = 1
b = 1
s2=10
csb=4XXi
S=chol(csb)'
css=1

function ll(be::Array{Float64,1},sig2::Float64) 
  c = y-X*be
  c'c/(-2sig2)-n*log(sig2)/2 
end

lpb(be::Array{Float64,1}) = -be'XXi*be/2s2
lps(sig2::Float64) = (a-1)*log(s2)-s2/b 
mvrnorm(M::Array{Float64,1}) = M+S*randn(k)


function mh(B=100000)
  accb = 0; accs = 0
  bb = Array(Float64,(k,B))
  ss = Array(Float64,B)
  bcur = bb[:,1]
  scur = 1.0

  println("Starting Metropolis...")
  #@time @fastmath for i in 1:B
  @time for i in 1:B

    # Update β̂: 
    candb = mvrnorm(bcur)
    q = ll(candb,scur)+lpb(candb) -ll(bcur,scur)-lpb(bcur)
    if q[1]>log(rand())
      bcur = candb
      accb += 1
    end

    # Update ŝ²:
    cands = rand(Normal(scur,sqrt(css)))
    if cands>0
      q = ll(bcur,cands)+lps(cands) -ll(bcur,scur)-lps(scur)
      if q[1]>log(rand())
        scur = cands
        accs += 1
      end
    end

    @inbounds bb[:,i] = bcur
    @inbounds ss[i]  = scur

    if i%(B/10)==0 print("\r",round(100*i/B),"%") end
  end # End of loops
  println("End of Metropolis.\n\n")

  return (bb,ss,accb,accs,B)
end # End of mh function

bb,ss,accb,accs,B = @time mh();

println("β̂: \n", mean(bb[:,round(B*.9):end],2),"\n")
println("ŝ²: ",  mean(ss[round(B*.9):end]),"\n")

println("Acceptance rate for β̂: ",accb/B)
println("Acceptance rate for ŝ²:",accs/B)

#plot(x=1:10000,y=ss[90000:99999], Geom.line,Theme( line_width=1pt, default_color=color("orange")))
#plot(x=ss[90000:99999],Geom.histogram())
{% endhighlight %}
