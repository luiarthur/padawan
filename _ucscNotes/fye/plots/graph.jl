using PlotlyJS, Rsvg

ams211 = Dict("Lagrange"=>1,"2nd Order ODE non-Homo"=>3,
              "Line Integral over Strange Path"=>1,
              "Eigen"=>1,"Fourier Series"=>2,"Surface Integral"=>1,
              "1st Order ODE"=>1,"Stationary Points"=>1,
              "Trans Matrix"=>1)

ams211Topics = [x[1] for x in ams211]
ams211Freqs = [x[2] for x in ams211]

s = bar(;x=ams211Topics, y=ams211Freqs, 
            marker=attr(size=20))
l = Layout(width=670, height=470, 
                 margin=attr(r=50,l=50,b=100,t=100),
                 title="FYE AMS 211 Topic Distribution")
p = plot(s, l)

savefig(p, "ams211.html")
run(`sed -i.bak '8,13!d' ams211.html`)
run(`sed -i.bak 's/newPlot('\''[a-z|0-9|-]*'\''/newPlot('\''ams211'\''/' ams211.html`)
run(`rm -f ams211.html.bak`)
