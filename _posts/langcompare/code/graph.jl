using PlotlyJS, Rsvg

dev_time = [3.3, 7.2, 9.1, 23.5, 51.2]
code_line = [124, 117, 75, 84, 56]
col = ["#EEAD0E", "#00CD66", "#FF6A6A", "#BEBEBE", "#7AC5CD"]
text = ["C++","Scala","Julia","Python","R"]
#col = [:darkgoldenrod2, :springgreen, :indianred, :grey, :cadetblue]

t = scatter(;x=code_line, y=dev_time, 
            text=text,
            marker=attr(color=col, size=20), 
            line=attr(color=:grey, width=1)); 
layout = Layout(width=670, height=670, 
                title="Speed vs. Code Length Tradeoff",
                xaxis=attr(title="Lines of Code"),
                yaxis=attr(title="Execution Time (seconds)"))
p = plot(t, layout)
savefig(p, "scat.html")
