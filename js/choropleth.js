function (file,v,scale,div,color,pm,mn,mx,width,height) {
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
    mn = d3.min(data, function(d) {return +d[v] + pm;} )
  }
  if (mx === undefined) {
    mx = d3.max(data, function(d) {return +d[v] - pm;} )
  }

  var rateById = d3.map();

  var quantize = d3.scale.quantize()
      .domain([mn, mx])
      .range(d3.range(9).map(function(i) { return "q" + i + "-9"; }));

  var projection = d3.geo.albersUsa()
      .scale(1280)
      .translate([width / 2, height / 2]);

  var path = d3.geo.path()
      .projection(projection);

  var svg = d3.select(div).append("svg")
      .attr("width", width)
      .attr("height", height);

  queue()
      .defer(d3.json, "/assets/spatial/us.json")
      .defer(d3.csv, file, function(d) { rateById.set(d.fips, +d[v]); })
      .await(ready);

  function ready(error, us) {
    if (error) throw error;

    svg.append("g")
        .attr("class", "counties")
      .selectAll("path")
        .data(topojson.feature(us, us.objects.counties).features)
      .enter().append("path")
        .attr("class", function(d) { return quantize(rateById.get(d.fips)); })
        .attr("d", path);

    svg.append("path")
        .datum(topojson.mesh(us, us.objects.states, function(a, b) { return a !== b; }))
        .attr("class", "states")
        .attr("d", path);
  }

  d3.select(self.frameElement).style("height", height + "px");
}
