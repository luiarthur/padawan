---
layout: page
title: "UCSC Lecture Notes"
comments: off
---

# Fall 2015

### AMS 241 (Bayesian Nonparametrics)
{% for notes in site.ucscNotes %}
  {% if notes.ams == 241 %}
  - [{{ notes.date | date: "%-d %b, %Y"}}&raquo; {{notes.title}}]({{notes.url}})
  {% endif %}
{% endfor %}

### AMS 211 (Foundations of Applied Math)
{% for notes in site.ucscNotes %}
  {% if notes.ams == 211 %}
  - [{{ notes.date | date: "%-d %b, %Y"}}&raquo; {{notes.title}}]({{notes.url}})
  {% endif %}
{% endfor %}

### AMS 268 (Advanced Bayesian Computation)
{% for notes in site.ucscNotes %}
  {% if notes.ams == 268 %}
  - [{{ notes.date | date: "%-d %b, %Y"}}&raquo; {{notes.title}}]({{notes.url}})
  {% endif %}
{% endfor %}

### AMS 206B (Bayesian Inference)
{% for notes in site.ucscNotes %}
  {% if notes.ams == "206" %}
  - [{{ notes.date | date: "%-d %b, %Y"}}&raquo; {{notes.title}}]({{notes.url}})
  {% endif %}
{% endfor %}

### AMS 205B (Classical Inference)
{% for notes in site.ucscNotes %}
  {% if notes.ams == "205" %}
  - [{{ notes.date | date: "%-d %b, %Y"}}&raquo; {{notes.title}}]({{notes.url}})
  {% endif %}
{% endfor %}

### AMS FYE
{% for notes in site.ucscNotes %}
  {% if notes.ams == "fye" %}
  - [{{ notes.date | date: "%-d %b, %Y"}}&raquo; {{notes.title}}]({{notes.url}})
  {% endif %}
{% endfor %}

### AMS 5 (Intro to Stats)
{% for notes in site.ucscNotes %}
  {% if notes.ams == 5 %}
  - [{{ notes.date | date: "%-d %b, %Y"}}&raquo; {{notes.title}}]({{notes.url}})
  {% endif %}
{% endfor %}

<!--http://jekyllrb.com/docs/collections/-->
