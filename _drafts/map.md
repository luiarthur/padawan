---
layout: map
---

## Station Measured Ozone Levels
<div id='ozone'></div>  

## Simulated CMAQ Measurements
<div id='cmaq'></div>  

## Gastro
<div id='gastro'></div>  

<script>
  usmap("/assets/cmaq/ozone.csv","ozone",800,"#ozone",7,7,1);
  usmap("/assets/cmaq/cmaq.csv","cmaq",800,"#cmaq",7,7,1);
  usmap("/assets/Hospital_Outpatient/outpatient_vol.csv","Gastrointestinal",800,"#gastro",7,7,1);
</script>
