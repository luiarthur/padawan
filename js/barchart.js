function barchart(data,div,scale,w,h,barPadding,labelPadding) {
  //Width and height

  if (labelPadding === undefined) {
    labelPadding = 0;
  }
  if (w === undefined) {
    w = 500;
  }
  if (h === undefined) {
    h = 100;
  }
  if (barPadding === undefined) {
    barPadding = 2;
  }
  var scaling = .95;
  if (scale === undefined) {
    scale = 1;
  }
  if (div === undefined) {
    div = "body";
  } else {
    w = d3.select(div).node().getBoundingClientRect().width * scale;
    h = w/2;
  }



  vals = [];
  for (i=0;  i < data.length; i++) {
    vals.push(data[i].val);
  }

  //Create SVG element
  yhi = d3.max(vals);
  var svg = d3.select(div)
        .append("svg")
        .attr("width", w)
        .attr("height", h);

  svg.selectAll("rect")
     .data(vals)
     .enter()
     .append("rect")
     .attr("x", function(d, i) {
        return i * (w / vals.length);
     })
     .attr("y", function(d) {
        return h * (1 - d / yhi) * scaling;
     })
     .attr("width", w / vals.length - barPadding)
     .attr("height", function(d) {
        return d * h / yhi * scaling;
     })
     .attr("fill", function(d,i) {
      //return "rgb(0, 0, " + (d * 10) + ")";
      //return "steelblue";
         return data[i].color;
     });

  svg.selectAll("text")
     .data(vals)
     .enter()
     .append("text")
     .text(function(d) {
        return d;
     })
     .attr("text-anchor", "middle")
     .attr("x", function(d, i) {
        return i * (w / vals.length) + (w / vals.length - barPadding) / 2;
     })
     .attr("y", function(d) {
        return h * (1 - d / yhi) * scaling + 15;
     })
     .attr("font-family", "sans-serif")
     .attr("font-size", "15px")
     .attr("fill", "white");

  svg.selectAll(".bartext")
     .data(vals)
     .enter()
     .append("text")
     .text(function(d,i) {
        return data[i].code;
     })
     .attr("text-anchor", "middle")
     .attr("x", function(d, i) {
        return i * (w / vals.length) + (w / vals.length - barPadding) / 2;
     })
     .attr("y", function(d) {
        return h-5;
     })
     .attr("font-family", "sans-serif")
     .attr("font-size", "15px")
     .attr("fill", "rgb(72,72,72)");
}
