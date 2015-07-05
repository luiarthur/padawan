---
layout: temperature
title: "Example Multiline Plot"
subtitle: "Attraction Indian Buffet Process Temperature Plot"
description: "Example multiline plot, d3, hover over highlight, attraction Indian buffet process"
alpha: 1
sigma: "(1,2,3,4)"
D: "\\left( \\begin{array}{rrrr}
      0.0 & 1.1 & 1.2 & 1.3 \\\\
      1.1 & 0.0 & 1.4 & 1.5 \\\\
      1.2 & 1.4 & 0.0 & 1.6 \\\\
      1.3 & 1.5 & 1.6 & 0.0
    \\end{array} \\right)"
image:
---

<!-- Javascript: -->
<script type="text/javascript">
  draw("/assets/demoDat.tsv","tau","#multilinePlot");
</script>
