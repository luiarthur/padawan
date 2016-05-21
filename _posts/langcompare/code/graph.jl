using PlotlyJS, Rsvg

exe_time = [2.0, 6.0, 4.2, 3.0, 23.5, 51.2]
code_line = [124, 125, 80, 75, 84, 55]
text = ["C++", "C", "Scala","Julia","Python","R"]
col = [:goldenrod, "#7F25C4", :mediumseagreen, :crimson, :lightgrey, :darkcyan]

s = scatter(;x=code_line, y=exe_time, 
            text=text,
            marker=attr(color=col, size=20), 
            line=attr(color=:grey, width=1)); 
layout1 = Layout(width=670, height=470, 
                 #title="Speed vs. Code Length Tradeoff",
                 margin=attr(r=20,l=50,b=50,t=20),
                 xaxis=attr(title="Lines of Code"),
                 yaxis=attr(title="Execution Time (seconds)",zeroline=false))
p = plot(s, layout1)
savefig(p, "scatter.html")
run(`sed -i.bak '8,13!d' scatter.html`)
run(`sed -i.bak 's/newPlot('\''[a-z|0-9|-]*'\''/newPlot('\''scatplot'\''/' scatter.html`)


b1 = bar(x=text, y=code_line, marker=attr(color=col)) 
a = [Dict("text"=>code_line[i], "x"=>text[i], "y"=>code_line[i], "showarrow"=>false, 
          "xanchor"=>"center", "yanchor"=>"bottom") for i in 1:length(exe_time)]
layout2 = Layout(width=670, height=300, 
                 text=code_line,
                 annotations=a,
                 margin=attr(t=0),
                 yaxis=attr(zeroline=false,showticklabels=false,showgrid=false))
p2 = plot(b1,layout2)
savefig(p2, "bar_line.html")
run(`sed -i.bak '8,13!d' bar_line.html`)
run(`sed -i.bak 's/newPlot('\''[a-z|0-9|-]*'\''/newPlot('\''conciseness'\''/' bar_line.html`)

b2 = bar(x=text, y=exe_time, marker=attr(color=col)) 
a2 = [Dict("text"=>exe_time[i], "x"=>text[i], "y"=>exe_time[i], "showarrow"=>false, 
          "xanchor"=>"center", "yanchor"=>"bottom") for i in 1:length(exe_time)]
layout3 = Layout(width=670, height=300, 
                 text=code_line,
                 annotations=a2,
                 margin=attr(t=0),
                 yaxis=attr(zeroline=false,showticklabels=false,showgrid=false))
p3 = plot(b2,layout3)
savefig(p3, "bar_time.html")
run(`sed -i.bak '8,13!d' bar_time.html`)
run(`sed -i.bak 's/newPlot('\''[a-z|0-9|-]*'\''/newPlot('\''speed'\''/' bar_time.html`)

#plot([Plot(b1), Plot(b2)])
#=
include("graph.jl")
=#
