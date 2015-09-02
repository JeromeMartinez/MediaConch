---
layout: downloads
permalink: download.html
title: "Download MediaConch"
---

# Downloads

## 15.07 Release Notes

This release of MediaConch CLI focuses on the online shell, [MediaConchOnline](https://mediaarea.net/MediaConchOnline/).

### CLI

Improved FFV1 slice analysis (currently activated only for 1st frame)

### GUI

Improved FFV1 slice analysis (currently activated only for 1st frame)
Improved Schematron file editor

### Online

Initial release of [MediaConchOnline](https://mediaarea.net/MediaConchOnline/). MediaConchOnline features the ability to create an account; to create, import, and develop checker policies; and to validate files.

### Historical Release Notes

{% for post in site.releasenotes reversed %}
  [{{ post.date }}]({{ post.url }})
{% endfor %}