---
layout: quick
---

<div class="row">
  <hr>
  <div class="col-md-2"></div>
  <div class="col-md-8">
    <hr>
    <div id="speed"></div>
    <hr>
  </div>
  <div class="col-md-2"></div>
</div>
<hr>

<script>
  var data = [{code:"C++",color:"goldenrod",val:3.3},
              {code:"Scala",color:"mediumseagreen",val:7.2},
              {code:"Julia",color:"crimson",val:9.1},
              {code:"R",color:"darkcyan",val:51.2}];
  barchart(data,"#speed");
</script>

