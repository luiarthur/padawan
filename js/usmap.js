function usmap(csv,v,scale,div,r,op,css,mn,mx,pm,width,height) {
  if (pm === undefined) {
    pm = 0;
  }
  if (css === undefined) {
    css = "orig";
  }
  if (r === undefined) {
    r = 2;
  }
  if (op === undefined) {
    op = 1;
  }
  if (scale === undefined) {
    scale = 1280;
  }
  if (width === undefined) {
    width = 960;
  }
  if (height === undefined) {
    height = 600;
  }
  if (div === undefined) {
    div = "body";
  } else {
    width = d3.select(div).node().getBoundingClientRect().width;
    height = width/2;
  }

  var rateById = d3.map();

  var projection = d3.geo.albersUsa()
      .scale(scale)
      .translate([width / 2, height / 2]);

  var path = d3.geo.path()
      .projection(projection);

  var svg = d3.select(div).append("svg")
      .attr("width", width)
      .attr("height", height);

  queue()
      .defer(d3.json, "/assets/cmaq/us.json")
      .await(ready);

  function ready(error, us) {
    if (error) throw error;

    // Cities
    d3.csv(csv, function(error, data) {
      if (mn === undefined) {
        mn = d3.min(data, function(d) {return +d[v] + pm;} )
      }
      if (mx === undefined) {
        mx = d3.max(data, function(d) {return +d[v] - pm;} )
      }
      var quantize = d3.scale.quantize()
          .domain([mn,mx])
          .range(d3.range(9).map(function(i) { return "q" + i + "-9"; }));

      var point = svg.selectAll("g.point")
      .data(data)
      .enter()
      .append("g")
      .attr("class", "point")
      .attr("class", function(d) {return css +" "+ quantize(+d[v]);})
      .attr("transform", function(d) {return "translate(" + projection([d.lon, d.lat]) + ")"; })
      .attr("hospital", function(d) {return d.hospital;})
      .attr("lat", function(d) {return d.lat;})
      .attr("lon", function(d) {return d.lon;})
      .attr("prop", function(d) {return Math.floor(+d[v] * 10000) / 100 +"%";})

      point.append("circle")
        .attr("r",r)
        .style("opacity", op)
        .on("mouseover", mouseover)
        .on("mouseout",  mouseout);

      /* mouseover stuff below*/
        function mouseover() { 
          d3.select(this).attr("r",30); 
          var pn = d3.select(this.parentNode);
          console.log(pn.attr("hospital")+": "+pn.attr("prop"));
          console.log("("+pn.attr("lat")+","+pn.attr("lon")+")");
        };
        function mouseout() { 
          d3.select(this).attr("r",r); 
        };
      /*End of Mouseover stuff*/

      // Draws State Lines. Only uses us.json.
      svg.append("g")
          .attr("class", "states")
        .selectAll("path")
          .data(topojson.feature(us, us.objects.states).features)
        .enter().append("path")
          .attr("d", path);
    }); // End of City Drawing
  } // End of Function ready 

  d3.select(self.frameElement).style("height", height + "px");
}
