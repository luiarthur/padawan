---
layout: page
title: "UCSC Lecture Notes"
header-img: "img/beach.jpg"
---

# Fall 2015
### AMS 203 (Probability Theory)
{% for notes in site.ucscNotes %}
  {% if notes.ams == 203 %}
  - [{{ notes.date }}: {{notes.title}}]({{notes.url}})
  {% endif %}
{% endfor %}

### AMS 211 (Foundations of Applied Math)
{% for notes in site.ucscNotes %}
  {% if notes.ams == 211 %}
  - [{{ notes.date }}: {{notes.title}}]({{notes.url}})
  {% endif %}
{% endfor %}

### AMS 241 (Bayesian Nonparametrics)
{% for notes in site.ucscNotes %}
  {% if notes.ams == 241 %}
  - [{{ notes.date }}: {{notes.title}}]({{notes.url}})
  {% endif %}
{% endfor %}

<!--http://jekyllrb.com/docs/collections/-->
