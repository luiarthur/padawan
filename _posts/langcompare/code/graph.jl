using PlotlyJS, Rsvg

dev_time = [1.9, 7.2, 3.6, 23.5, 51.2]
code_line = [124, 117, 75, 84, 56]
text = ["C++","Scala","Julia","Python","R"]
col = [:goldenrod, :mediumseagreen, :crimson, :lightgrey, :darkcyan]

s = scatter(;x=code_line, y=dev_time, 
            text=text,
            marker=attr(color=col, size=20), 
            line=attr(color=:grey, width=1)); 
layout1 = Layout(width=670, height=470, 
                 #title="Speed vs. Code Length Tradeoff",
                 xaxis=attr(title="Lines of Code"),
                 yaxis=attr(title="Execution Time (seconds)",zeroline=false))
p = plot(s, layout1)
savefig(p, "scatter.html")

b1 = bar(x=text, y=code_line, marker=attr(color=col)) 
a = [Dict("text"=>code_line[i], "x"=>text[i], "y"=>code_line[i], "showarrow"=>false, 
          "xanchor"=>"center", "yanchor"=>"bottom") for i in 1:length(dev_time)]
layout2 = Layout(width=670, height=470, 
                 text=code_line,
                 annotations=a,
                 margin=attr(t=0),
                 yaxis=attr(zeroline=false,showticklabels=false,showgrid=false))
p2 = plot(b1,layout2)
savefig(p2, "bar_line.html")

b2 = bar(x=text, y=dev_time, marker=attr(color=col)) 
a2 = [Dict("text"=>dev_time[i], "x"=>text[i], "y"=>dev_time[i], "showarrow"=>false, 
          "xanchor"=>"center", "yanchor"=>"bottom") for i in 1:length(dev_time)]
layout3 = Layout(width=800, height=470, 
                 text=code_line,
                 annotations=a2,
                 margin=attr(t=0),
                 yaxis=attr(zeroline=false,showticklabels=false,showgrid=false))
p3 = plot(b2,layout3)
savefig(p3, "bar_time.html")

#plot([Plot(b1), Plot(b2)])
