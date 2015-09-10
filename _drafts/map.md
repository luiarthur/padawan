---
layout: map
nohlink: on
---

## Station-Measured Ozone Levels
<div id='ozone'></div>  

## [Count of Gastrointestinal Outpatient Procedures](http://catalog.data.gov/dataset/outpatient-procedures-volume/resource/af370823-8af4-414e-bf65-ca1b7f6f3fa0)
<div id='gastro'></div>  

<script>
  usmap("/assets/cmaq/ozone.csv","ozone",800,"#ozone",7,7,1);
  usmap("/assets/Hospital_Outpatient/gastro.csv","gastro",800,"#gastro",4,4,1,'orig',0,0,1500);
</script>
