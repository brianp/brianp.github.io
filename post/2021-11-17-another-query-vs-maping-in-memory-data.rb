---
tags:
 - ruby
 - activerecord
 - rails
categories:
 - software development
date: 2021-11-17T13:58:02Z
title: Another SQL query vs Maping in memory data
draft: true
---
I considered this. And in the case of multiple thousands of records, I think a single SQL query search will scale better then enumerating a list of the same number of items. One of the issues teams had in this area was memory allocation on the processes trying to execute these large calls.

Okay so I did what I do. With a small amount of records map was in fact quicker, but as the scale grows SQL stays consistent where map has a positively correlated growth. map became slower then SQL at less than 3000 records.

This test did take into account the join query. I loaded the query for each benchmark then performed either the map, or next sql query.

```
       user     system      total        real
Map filter with 1700 issues:  0.027566   0.000310   0.027876(  0.029066)
 SQL Query with 1700 issues:  0.051915   0.015173   0.067088 (  0.072244)
Map filter with 2890 issues:  0.067009   0.001747   0.068756 (  0.088530)
 SQL Query with 2890 issues:  0.073292   0.017076   0.090368 (  0.175228)
Map filter with 4913 issues:  0.089396   0.001474   0.090870 (  0.119362)
 SQL Query with 4913 issues:  0.054147   0.012857   0.067004 (  0.077316)
Map filter with 8352 issues:  0.119007   0.001433   0.120440 (  0.124050)
 SQL Query with 8352 issues:  0.044935   0.011138   0.056073 (  0.057529)
Map filter with 14198 issues:  0.189850   0.001870   0.191720 (  0.197212)
 SQL Query with 14198 issues:  0.044847   0.011035   0.055882 (  0.057213)
Map filter with 24136 issues:  0.358427   0.003157   0.361584 (  0.371087)
 SQL Query with 24136 issues:  0.051236   0.012518   0.063754 (  0.073650)
Map filter with 41031 issues:  0.540804   0.013141   0.553945 (  0.635450)
 SQL Query with 41031 issues:  0.050133   0.013249   0.063382 (  0.069286)
Map filter with 69752 issues:  0.386282   0.003123   0.389405 (  0.403803)
 SQL Query with 69752 issues:  0.048370   0.012643   0.061013 (  0.062231)
Map filter with 118578 issues:  0.419409   0.005647   0.425056 (  0.462794)
 SQL Query with 118578 issues:  0.047598   0.012515   0.060113 (  0.065927)
Map filter with 201582 issues:  0.491358   0.010568   0.501926 (  0.659142)
 SQL Query with 201582 issues:  0.050493   0.012791   0.063284 (  0.076221)
Map filter with 342689 issues:  0.473795   0.005248   0.479043 (  0.490785)
 SQL Query with 342689 issues:  0.044737   0.010659   0.055396 (  0.056820)
```
