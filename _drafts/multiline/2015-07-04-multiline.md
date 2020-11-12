---
layout: temperature
title: "Example Multiline Plot"
subtitle: "Attraction Indian Buffet Process: Probability of Same Feature Vector vs. Temperature (USArrest, R data)"
description: "Example multiline plot, d3, hover over highlight, attraction Indian buffet process"
alpha: 1
sigma: "Random"
D: "\\tiny \\begin{array}{crrrrr}
             &   NH &   IA &   WI &   CA &   NV \\\\
          NH & 0.00 & 0.12 & 0.66 & 3.74 & 3.78 \\\\
          IA & 0.12 & 0.00 & 0.59 & 3.65 & 3.69 \\\\
          WI & 0.66 & 0.59 & 0.00 & 3.32 & 3.46 \\\\
          CA & 3.74 & 3.65 & 3.32 & 0.00 & 1.01 \\\\
          NV & 3.78 & 3.69 & 3.46 & 1.01 & 0.00 \\\\
    \\end{array}"
multiline: on
image:
---

<!-- Javascript: -->
<script type="text/javascript">
  multiline("/assets/demoDat.tsv","tau","#multilinePlot");
</script>
