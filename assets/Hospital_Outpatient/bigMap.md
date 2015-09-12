---
layout: default
usmap: on
---

<br> 
### Gastrointestinal (median: 36%)
<div id='gastro'></div>
<div id='gastroh'></div>
***

### Musculoskeletal (median: 12%)
<div id='muscle'></div>
<div id='muscleh'></div>
***

### Genitourinary (median: 5.6%)
<div id='genital'></div>
<div id='genitalh'></div>
***

### Skin (median: 5.4%)
<div id='skin'></div>
<div id='skinh'></div>
***

### Nervous System (median: 4.8%)
<div id='nerve'></div>
<div id='nerveh'></div>
***

### Cardiovascular (median: 4.1%)
<div id='cardio'></div>
<div id='cardioh'></div>
***

### Eye (median: 2.6%)
<div id='eye'></div>
<div id='eyeh'></div>

<script>
  var scale= 1500,
      r = 3,
      thresh = .1,
      op = .7;

  usmap("/assets/Hospital_Outpatient/prop.csv","Gastrointestinal",scale,"#gastro",r,op,'blue',0,thresh);
  usmap("/assets/Hospital_Outpatient/prop.csv","Musculoskeletal",scale,"#muscle",r,op,'blue',0,thresh);
  usmap("/assets/Hospital_Outpatient/prop.csv","Genitourinary",scale,"#genital",r,op,'blue',0,thresh);
  usmap("/assets/Hospital_Outpatient/prop.csv","Skin",scale,"#skin",r,op,'blue',0,thresh);
  usmap("/assets/Hospital_Outpatient/prop.csv","Nervous.System",scale,"#nerve",r,op,'blue',0,thresh);
  usmap("/assets/Hospital_Outpatient/prop.csv","Cardiovascular",scale,"#cardio",r,op,'blue',0,thresh);
  usmap("/assets/Hospital_Outpatient/prop.csv","Eye",scale,"#eye",r,op,'blue',0,thresh);


</script>


