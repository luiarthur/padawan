---
layout: default
choropleth: on
---

<br>
<div id='test'></div>

<script>
 // need to remove "," from dataset in Median.income
  choropleth("/assets/chr2015/chr2015.csv","Median.household.income.Value",
             1000,"#test","blue",0,0,100000);
</script>
