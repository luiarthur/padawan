---
layout: page
title: "UCSC Lecture Notes"
inNav: on
comments: off
---

# Fall 2015

### AMS 241 (Bayesian Nonparametrics)
{% for notes in site.ucscNotes %}
  {% if notes.ams == 241 %}
  - [{{ notes.date | date: "%-d %b, %Y"}}&raquo; {{notes.title}}]({{notes.url | prepend: base.url}})
  {% endif %}
{% endfor %}

### AMS 211 (Foundations of Applied Math)
{% for notes in site.ucscNotes %}
  {% if notes.ams == 211 %}
  - [{{ notes.date | date: "%-d %b, %Y"}}&raquo; {{notes.title}}]({{notes.url | prepend: base.url}})
  {% endif %}
{% endfor %}

### AMS 268 (Advanced Bayesian Computation)
{% for notes in site.ucscNotes %}
  {% if notes.ams == 268 %}
  - [{{ notes.date | date: "%-d %b, %Y"}}&raquo; {{notes.title}}]({{notes.url | prepend: base.url}})
  {% endif %}
{% endfor %}

### AMS 206B (Bayesian Inference)
{% for notes in site.ucscNotes %}
  {% if notes.ams == 206 %}
  - [{{ notes.date | date: "%-d %b, %Y"}}&raquo; {{notes.title}}]({{notes.url | prepend: base.url}})
  {% endif %}
{% endfor %}

### AMS 205B (Classical Inference)
{% for notes in site.ucscNotes %}
  {% if notes.ams == 205 %}
  - [{{ notes.date | date: "%-d %b, %Y"}}&raquo; {{notes.title}}]({{notes.url | prepend: base.url}})
  {% endif %}
{% endfor %}

### AMS 256 (Linear Models)
{% for notes in site.ucscNotes %}
  {% if notes.ams == 256 %}
  - [{{ notes.date | date: "%-d %b, %Y"}}&raquo; {{notes.title}}]({{notes.url | prepend: base.url}})
  {% endif %}
{% endfor %}

### AMS 207 (Intermediate Bayesian Modeling)
{% for notes in site.ucscNotes %}
  {% if notes.ams == 207 %}
  - [{{ notes.date | date: "%-d %b, %Y"}}&raquo; {{notes.title}}]({{notes.url | prepend: base.url}})
  {% endif %}
{% endfor %}

### AMS 250 (High Performance Computing)
{% for notes in site.ucscNotes %}
  {% if notes.ams == 250 %}
  - [{{ notes.date | date: "%-d %b, %Y"}}&raquo; {{notes.title}}]({{notes.url | prepend: base.url}})
  {% endif %}
{% endfor %}

### AMS 274 (GLM)
{% for notes in site.ucscNotes %}
  {% if notes.ams == 274 %}
  - [{{ notes.date | date: "%-d %b, %Y"}}&raquo; {{notes.title}}]({{notes.url | prepend: base.url}})
  {% endif %}
{% endfor %}

### AMS 276 (Bayesian Survival Analysis)
{% for notes in site.ucscNotes %}
  {% if notes.ams == 276 %}
  - [{{ notes.date | date: "%-d %b, %Y"}}&raquo; {{notes.title}}]({{notes.url | prepend: base.url}})
  {% endif %}
{% endfor %}

### AMS 5 (Intro to Stats)
{% for notes in site.ucscNotes %}
  {% if notes.ams == 5 %}
  - [{{ notes.date | date: "%-d %b, %Y"}}&raquo; {{notes.title}}]({{notes.url | prepend: base.url}})
  {% endif %}
{% endfor %}

<!--http://jekyllrb.com/docs/collections/-->
