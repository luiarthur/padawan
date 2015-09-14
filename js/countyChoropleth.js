function countyChoropleth (file,v,num,denom,pre,suff,state,county,ledengLab,scale,div,color,pm,mn,mx,width,height) {
  if (color === undefined) {
    /*NEED SOMETHING HERE*/
  }
  if (pm === undefined) {
    pm = 0;
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
  if (mn === undefined) {
    mn = 0;//d3.min(data, function(d) {return +d[v] + pm;} )
  }
  if (mx === undefined) {
    mx = 1;//d3.max(data, function(d) {return +d[v] - pm;} )
  }

  if (legendLab !== "") {
    console.log("legend");
    //http://bl.ocks.org/KoGor/5685876
  }

  var rateById = d3.map();
  var stateById = d3.map();
  var countyById = d3.map();

  var quantize = d3.scale.quantize()
      .domain([mn, mx])
      .range(d3.range(9).map(function(i) { return "q" + i + "-9"; }));

  var projection = d3.geo.albersUsa()
      .scale(scale)
      .translate([width / 2, height / 2]);

  var path = d3.geo.path()
      .projection(projection);

  var svg = d3.select(div).append("svg")
      .attr("width", width)
      .attr("height", height);

  var msg = d3.select("body").append("div")   
      .attr("class", "tooltip")
      .style("opacity",0);

  queue()
      .defer(d3.json, "/assets/spatial/us.json")
      .defer(d3.csv, file, function(d) { 
        if (v > "") {
          rateById.set(d.fips, Math.round(d[v].replace(",","")*100) / 100); 
        } else {
          rateById.set(d.fips, 
            Math.round(d[num].replace(",","") / d[denom].replace(",","") * 10000) / 100); 
        }
        stateById.set(d.fips, d[state]); 
        countyById.set(d.fips, d[county]); 
      })
      .await(ready);

  function ready(error, us) {
    if (error) throw error;

    svg.append("g")
        .attr("class", "counties")
      .selectAll("path")
        .data(topojson.feature(us, us.objects.counties).features)
      .enter().append("path")
        .attr("class", function(d) { 
          return quantize(rateById.get(d.id)); 
        })
        .attr("d", path)
        .on("mouseover",function(d) {
          d3.select(this)
            .style("fill","red");
          d3.select(this).transition().duration(300).style("opacity", 1);
          msg.transition().duration(300)
            .style("opacity",1)
          msg.text( countyById.get(d.id) + ", " + stateById.get(d.id) + 
                    ": " + pre + rateById.get(d.id) + suff)
          .style("left", (d3.event.pageX +15) + "px")
          .style("top",  (d3.event.pageY -40) + "px");
        })
        .on("mouseout",function() {
          d3.select(this)
          .transition().duration(300)
          .style("fill", "");
        });

    svg.append("path")
        .datum(topojson.mesh(us, us.objects.states, function(a, b) { return a !== b; }))
        .attr("class", "states")
        .attr("d", path);
  }

  d3.select(self.frameElement).style("height", height + "px");
}
