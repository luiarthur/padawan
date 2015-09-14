---
layout: post
countyChoropleth: on
---

<br>
# Adult Obesity Proportion
<div id='obeseProp'></div>

<script>
  var file = "/assets/chr2015/chr2015.csv",
             //v ="Median.household.income.Value",
             v ="",
             num ="Adult.obesity.Numerator",
             denom ="Adult.obesity.Denominator",
             state = "State",
             county = "County",
             legendLab = ["","",""],
             pre = "",
             suff = "%",
             scale = 800,
             div = "#obeseProp",
             color = "blue",
             pm = 0, mn = 0, mx=45;

  countyChoropleth(file,v,num,denom,pre,suff,state,county,legendLab,scale,div,color,pm,mn,mx);
</script>
