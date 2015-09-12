---
layout: post
title: National Distribution of Outpatient Procedures
subtitle: Why do people visit hospitals?
description: "Mapping information using d3, Spatial visualization"
nohlink: on
ogimg: "http://luiarthur.github.io/assets/Hospital_Outpatient/hospital.png"
usmap: on
histogram: on
---

Why do people visit hospitals? 

A look at the distribution of outpatient procedures may provide some insights.
An outpatient is a patient who receives medical treatment without being
admitted to a hospital. In most cases, if you *don't stay overnight* at a
hospital, you are an outpatient.

The graphs below illustrate the proportion of [outpatients treated in each of 7
departments at several medicare-registered hospitals in
2013](http://catalog.data.gov/dataset/outpatient-procedures-volume/resource/af370823-8af4-414e-bf65-ca1b7f6f3fa0).
The departments are:

- Gastrointestinal
- Musculoskeletal
- Genitourinary
- Skin
- Nervous System
- Cardiovascular
- Eye

The proportions are computed as follows: if a hospital had 1000 outpatients,
out of which 100 were treated in the gastro department, then the proportion of
gastro patients in that location is 100/1000 = 10%. A shades of blue are used
to indicate the proportions. <text style="color: rgb(8,48,107); font-weight:
bold; background-color: #8D8D8D; padding: 2px; border-radius: 4px;"> Navy
Blue</text> is used to indicate that the proportion is greater than 10%.  And
<text style="color: white; font-weight: bold; background-color: #8D8D8D;
padding: 2px; border-radius: 4px;">White</text> is used to indicate 0. 
Different shades of blue are used to linearly interpolate between 0 and 10%.

The plots are ordered according to the median proportion of visits within each
department, the department with the highest median proportion being placed at
the top.

***

### Gatrointestinal (median: 36%)
<div id='gastro'></div>
<aside>
  <a target="_blank" href="/assets/Hospital_Outpatient/bigMap.html#gastro">
    Open in a new window
  </a>
</aside>
<div id='gastroh'></div>
***

### Musculoskeletal (median: 12%)
<div id='muscle'></div>
<aside>
  <a target="_blank" href="/assets/Hospital_Outpatient/bigMap.html#muscle">
    Open in a new window
  </a>
</aside>
<div id='muscleh'></div>
***

### Genitourinary (median: 5.6%)
<div id='genital'></div>
<aside>
  <a target="_blank" href="/assets/Hospital_Outpatient/bigMap.html#genital">
    Open in a new window
  </a>
</aside>
<div id='genitalh'></div>
***

### Skin (median: 5.4%)
<div id='skin'></div>
<aside>
  <a target="_blank" href="/assets/Hospital_Outpatient/bigMap.html#skin">
    Open in a new window
  </a>
</aside>
<div id='skinh'></div>
***

### Nervous System (median: 4.8%)
<div id='nerve'></div>
<aside>
  <a target="_blank" href="/assets/Hospital_Outpatient/bigMap.html#nerve">
    Open in a new window
  </a>
</aside>
<div id='nerveh'></div>
***

### Cardiovascular (median: 4.1%)
<div id='cardio'></div>
<aside>
  <a target="_blank" href="/assets/Hospital_Outpatient/bigMap.html#cardio">
    Open in a new window
  </a>
</aside>
<div id='cardioh'></div>
***

### Eye (median: 2.6%)
<div id='eye'></div>
<aside>
  <a target="_blank" href="/assets/Hospital_Outpatient/bigMap.html#eye">
    Open in a new window
  </a>
</aside>
<div id='eyeh'></div>
***

Lightheartedly, if you are a medical student considering specializations, why
not look into gastroenterology? They have more than enough patients keeping
them busy during the day.  For those of you thinking of becoming a
neuro-surgeon, it's not too late to *change your mind*. Sure, it's not brain
surgery, but you'll never run out of work at the gastro clinic.

<script>
  var thresh = .1;
  var color = 'blue'; //orig
  var r = 3;
  var op = .7;
  var scale = 700;
  usmap("/assets/Hospital_Outpatient/prop.csv","Gastrointestinal",scale,"#gastro",r,op,'blue',0,thresh);
  usmap("/assets/Hospital_Outpatient/prop.csv","Musculoskeletal",scale,"#muscle",r,op,'blue',0,thresh);
  usmap("/assets/Hospital_Outpatient/prop.csv","Genitourinary",scale,"#genital",r,op,'blue',0,thresh);
  usmap("/assets/Hospital_Outpatient/prop.csv","Skin",scale,"#skin",r,op,'blue',0,thresh);
  usmap("/assets/Hospital_Outpatient/prop.csv","Nervous.System",scale,"#nerve",r,op,'blue',0,thresh);
  usmap("/assets/Hospital_Outpatient/prop.csv","Cardiovascular",scale,"#cardio",r,op,'blue',0,thresh);
  usmap("/assets/Hospital_Outpatient/prop.csv","Eye",scale,"#eye",r,op,'blue',0,thresh);

  var gastro = [],
      muscle = [],
      genital = [],
      skin = [],
      ns = [],
      cardio = [],
      eye = [];

  var margin = {top: 50, right: 100, bottom: 30, left: 100};

  d3.csv('/assets/Hospital_Outpatient/prop.csv', function(csv) {
    csv.map(function(d) { 
      gastro.push(d.Gastrointestinal);
      muscle.push(d.Musculoskeletal);
      genital.push(d.Genitourinary);
      skin.push(d.Skin);
      ns.push(d["Nervous.System"]);
      cardio.push(d.Cardiovascular);
      eye.push(d.Eye);
    });
    histogram(gastro,"#gastroh",margin);
    histogram(muscle,"#muscleh",margin);
    histogram(genital,"#genitalh",margin);
    histogram(skin,"#skinh",margin);
    histogram(ns,"#nerveh",margin);
    histogram(cardio,"#cardioh",margin);
    histogram(eye,"#eyeh",margin);
  });
</script>
