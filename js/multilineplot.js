function draw(filename,xcol,div,xlo,xhi,ylo,yhi) {
  /*Page Setup:*/
  var margin = {top: 20, right: 80, bottom: 30, left: 50},
      width = (1000 - margin.left - margin.right),
      height = (width/2 - margin.top - margin.bottom);

  if (div === undefined) {
    div = "body";
  } else {
    width = d3.select(div).node().getBoundingClientRect().width * .85;
    height = width/2;
  }
   
  var svg = d3.select(div).append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
    .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
  /* End of page setup*/

  var x = d3.scale.linear().range([0, width]);
  var y = d3.scale.linear().range([height, 0]);
  var color = d3.scale.category10();
  var xAxis = d3.svg.axis().scale(x).orient("bottom");
  var yAxis = d3.svg.axis().scale(y).orient("left");
  var myline = d3.svg.line().interpolate("basis")
      .x(function(d) { return x(d.xval); })
      .y(function(d) { return y(d.yval); });

    /* Read in Data and Plot */
    d3.tsv(filename, function(data) {
    /* maps colors to each city */
      /* d3.keys(data[0]) gets the column headers*/
      /* d3.keys(data[0]).filter(etc) gets all all the column headers except the first one, "date"*/

    color.domain(d3.keys(data[0]).filter(function(key) { return key !== xcol; }));
    var curves = color.domain().map(function(name) {
      return {
        name: name,
        values: data.map(function(d) { return {xval: +d[xcol], yval: +d[name]}; })
      };
    });

    /* Setting x,y limits*/
    if (xlo === undefined || xhi === undefined) {
      x.domain(d3.extent(data, function(d) { return +d[xcol]; }));
    } else {
      x.domain([xlo,xhi]);
    }

    if (ylo === undefined || yhi === undefined) {
      y.domain([
        d3.min(curves, function(c) { return d3.min(c.values, function(v) { return v.yval; }); }),
        d3.max(curves, function(c) { return d3.max(c.values, function(v) { return v.yval; }); })
      ]);
    } else {
      y.domain([ylo,yhi]);
    }

    /*Add x,y-axis*/
    svg.append("g").attr("class","x axis").attr("transform","translate(0," + height + ")").call(xAxis);
    svg.append("g").attr("class","y axis").attr("transform","translate("+0+",0)").call(yAxis);

    /*Add curves*/
    var curve = svg.selectAll(".curve").data(curves).enter().append("g").attr("class", "curve");
    curve.append("path").attr("class", "line").attr("d", function(d) { return myline(d.values); })
         /*.style("stroke", function(d) { return color(d.name); })*/;

    /*Add names of cities to curves*/
    curve.append("text")
         .datum(function(d) { return {name: d.name, value: d.values[d.values.length - 1]}; })
         .attr("transform", function(d) { return "translate(" + x(d.value.xval) + "," + y(d.value.yval) + ")"; })
         .attr("x", 3).attr("dy", ".35em").text(function(d) { return d.name; });

    /* mouseover stuff below*/
    curve.style("opacity",".3").on("mouseover",mouseover).on("mouseout",mouseout);
      function mouseover(d, i) { d3.select(this).style("opacity",  "1"); };
      function mouseout(d, i)  { d3.select(this).style("opacity", ".3"); };
    /*End of Mouseover stuff*/

    d3.selectAll("line").attr("x2","0");  
    d3.selectAll("line").attr("y2","0");  
  });
}
