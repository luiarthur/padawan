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

## Gatrointestinal (median: 36%)
<div id='gastro'></div>
<div id='gastroh'></div>
<br>

## Musculoskeletal (median: 12%)
<div id='muscle'></div>
<div id='muscleh'></div>
<br>

## Genitourinary (median: 5.6%)
<div id='genital'></div>
<div id='genitalh'></div>
<br>

## Skin (median: 5.4%)
<div id='skin'></div>
<div id='skinh'></div>
<br>

## Nervous System (median: 4.8%)
<div id='nerve'></div>
<div id='nerveh'></div>
<br>

## Cardiovascular (median: 4.1%)
<div id='cardio'></div>
<div id='cardioh'></div>
<br>

## Eye (median: 2.6%)
<div id='eye'></div>
<div id='eyeh'></div>
<br>

***

Lightheartedly, if you are a medical student considering specializations, why
not look into gastroenterology? They have more than enough patients keeping
them busy during the day.  For those of you thinking of becoming a
neuro-surgeon, it's not too late to *change your mind*. Sure, it's not brain
surgery, but you'll never run out of work at the gastro clinic.

<script>
  var thresh = .1;
  var color = 'blue'; //orig
  var r = 2;
  var op = .7;
  usmap("/assets/Hospital_Outpatient/prop.csv","Gastrointestinal",800,"#gastro",r,op,'blue',0,thresh);
  usmap("/assets/Hospital_Outpatient/prop.csv","Eye",800,"#eye",r,op,'blue',0,thresh);
  usmap("/assets/Hospital_Outpatient/prop.csv","Nervous.System",800,"#nerve",r,op,'blue',0,thresh);
  usmap("/assets/Hospital_Outpatient/prop.csv","Skin",800,"#skin",r,op,'blue',0,thresh);
  usmap("/assets/Hospital_Outpatient/prop.csv","Musculoskeletal",800,"#muscle",r,op,'blue',0,thresh);
  usmap("/assets/Hospital_Outpatient/prop.csv","Genitourinary",800,"#genital",r,op,'blue',0,thresh);
  usmap("/assets/Hospital_Outpatient/prop.csv","Cardiovascular",800,"#cardio",r,op,'blue',0,thresh);

  var gastro = [],
      muscle = [],
      genital = [],
      skin = [],
      ns = [],
      cardio = [];
      eye = [],
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
    histogram(gastro,"#gastroh");
    histogram(muscle,"#muscleh");
    histogram(genital,"#genitalh");
    histogram(skin,"#skinh");
    histogram(ns,"#nerveh");
    histogram(cardio,"#cardioh");
    histogram(eye,"#eyeh");
  });
</script>
