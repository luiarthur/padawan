---
layout: post
title: National Distribution of Outpatient Procedures
subtitle: Why do people visit hospitals?
description: "Mapping information using d3, Spatial visualization"
nohlink: on
ogimg: "http://luiarthur.github.io/assets/Hospital_Outpatient/hospital.jpg"
usmap: on
---

Why do people visit hospitals? 

A look at the distribution of outpatient procedures may provide some insights.
An outpatient is a patient who receives medical treatment without being
admitted to a hospital. In most cases, if you *don't stay overnight* at a
hospital, you are an outpatient.

The graphs below illustrat the proportion of [outpatients treated in each of 7
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
gastro patients in that location is 100/1000 = 10%. A spectrum of shades of
blue is used to indicate the proportions. <text style="color: rgb(8,48,107);
font-weight: bold; background-color: #8D8D8D; padding: 2px; border-radius: 4px;">
Navy Blue</text> is used to indicate that the proportion is greater than 10%.
And <text style="color: white; font-weight: bold; background-color: #8D8D8D;
padding: 2px; border-radius: 4px;">White</text> is used to indicate 0. 
Different shades of blue are used to linearly interpolate between 0 and 10%.

The plots are ordered according to the median proportion of visits within each
department, the department with the highest median proportion being placed at
the top.

***

## Gatrointestinal
<div id='gastro'></div>

## Musculoskeletal
<div id='muscle'></div>

## Genitourinary
<div id='genital'></div>

## Skin
<div id='skin'></div>

## Nervous System
<div id='nerve'></div>

## Cardiovascular
<div id='cardio'></div>

## Eye
<div id='eye'></div>

***

Lightheartedly, if you are a med student considering specializations, why not
look into gastroenterology? They have more than enough patients keeping them
busy during the day.  For those of you thinking of becoming a neuro-surgeon,
it's not too late to *change your mind*. Sure, it's not brain
surgery, but you'll never run out of work at the gastro clinic.


<!-- Scipts -->
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
</script>
