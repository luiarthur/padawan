---
layout: map
---

## Station Measured Ozone Levels
<div id='ozone'></div>  

## Simulated CMAQ Measurements
<div id='cmaq'></div>  

<script>
  usmap("/assets/cmaq/ozone.csv","ozone",800,"#ozone",7,7,1);
  usmap("/assets/cmaq/cmaq.csv","cmaq",800,"#cmaq",7,7,1);
</script>

