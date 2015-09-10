---
layout: map
---

## Station Measured Ozone Levels
<div id='ozone'></div>  

## Simulated CMAQ Measurements
<div id='cmaq'></div>  

<!--http://catalog.data.gov/dataset/outpatient-procedures-volume/resource/af370823-8af4-414e-bf65-ca1b7f6f3fa0-->
## Gastro
<div id='gastro'></div>  

<script>
  usmap("/assets/cmaq/ozone.csv","ozone",800,"#ozone",7,7,1);
  usmap("/assets/cmaq/cmaq.csv","cmaq",800,"#cmaq",7,7,1);
  usmap("/assets/Hospital_Outpatient/gastro.csv","gastro",800,"#gastro",7,7,1);
</script>
