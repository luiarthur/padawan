---
layout: post
title: Choropleth 
countyChoropleth: on
---

<!-- Data: http://www.countyhealthrankings.org/rankings/data/2015/CHR Analytic Data.csv 
Documentation of Data: http://www.countyhealthrankings.org/sites/default/files/2015%20CHR%20SAS%20Analytic%20Data%20Documentation.pdf-->


<br>
# Adult Obesity Proportion (2011)
<div id='obeseProp'></div>

# Diabetes Proportion (2011)
<div id='diabetesProp'></div>

# Number of Dentists / 100,000 Population (2013)
<div id='dentists'></div>

# Number of Primary Care Providers / 100,000 Population (2012)
<div id='doctors'></div>

<script>
  // Obesity Prop
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

  // Diabetes Proportion
  num ="Diabetes.Numerator",
  denom ="Diabetes.Denominator",
  state = "State",
  county = "County",
  legendLab = ["","",""],
  pre = "",
  suff = "%",
  scale = 800,
  div = "#diabetesProp",
  color = "blue",
  pm = 0, mn = 0, mx=15;

  countyChoropleth(file,v,num,denom,pre,suff,state,county,legendLab,scale,div,color,pm,mn,mx);

  // Dentists / 100,000
  v = "Dentists.Value",
  state = "State",
  county = "County",
  legendLab = ["","",""],
  pre = "",
  suff = "",
  scale = 800,
  div = "#dentists",
  color = "blue",
  pm = 0, mn = 0, mx=100;

  countyChoropleth(file,v,num,denom,pre,suff,state,county,legendLab,scale,div,color,pm,mn,mx);

  // Doctors / 100,000
  v = "Primary.care.physicians.Value",
  state = "State",
  county = "County",
  legendLab = ["","",""],
  pre = "",
  suff = "",
  scale = 800,
  div = "#doctors",
  color = "blue",
  pm = 0, mn = 0, mx=100;

  countyChoropleth(file,v,num,denom,pre,suff,state,county,legendLab,scale,div,color,pm,mn,mx);


</script>
