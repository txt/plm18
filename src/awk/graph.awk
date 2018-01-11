# Graph.awk
# Synopsis
# gawk -f graph.awk graphFile

# Description
# A processor for a little language, specialized for graph-drawing.
#The code inputs  data, which includes a specification of a graph
#The output is 
#data plotted in specified area

#Code
# Initialization
#Set frame dimensions: height and width; offset for x and y axes.

BEGIN {                
    ht = 24; wid = 80  
    ox = 6; oy = 2     
    number = "^[-+]?([0-9]+[.]?[0-9]*|[.][0-9]+)" \
                            "([eE][-+]?[0-9]+)?$"
}

# Handling patterns
# Skip comments

/^[ \t]*#/     { next } 

#P Simple tags

$1 == "height" { ht = $2;  next }
$1 == "width"  { wid = $2; next }
$1 == "label"  {                       # for bottom
    sub(/^ *label */, "")
    botlab = $0
    next
}
$1 == "bottom" && $2 == "ticks" {     # ticks for x-axis
    for (i = 3; i <= NF; i++) bticks[++nb] = $i
    next
}
$1 == "left" && $2 == "ticks" {       # ticks for y-axis
    for (i = 3; i <= NF; i++) lticks[++nl] = $i
    next
}
$1 == "range" {                       # xmin ymin xmax ymax
    xmin = $2; ymin = $3; xmax = $4; ymax = $5
    next
}

# Handling numerics.

$1 ~ number && $2 ~ number {  # pair of numbers
    nd++                      # count number of data points
    x[nd] = $1; y[nd] = $2
    ch[nd] = $3               # optional plotting character
    next
}
$1 ~ number && $2 !~ number { # single number
    nd++                      # count number of data points
    x[nd] = nd; y[nd] = $1; ch[nd] = $2
    next
}

# Line functions, defined by a slope "m" and a y-intercept "b".

$1 == "mb" {  # m b [mark]
	expand()
    for(i=xmin;i<=xmax;i++) {
		nd++; x[nd]=i; y[nd]=$2*i + $3; ch[nd]=$4 
    }
    next;
}		

# Final case: input error.

{ print "?? line " NR ": ["$0"]" >"/dev/stderr" }

# Draw the graph

END { expand();   frame(); ticks(); label(); data(); draw() }

# Functions
# Expand the "x" and "y" boundaries to include all points.

function expand(note) { if (xmin == "") expand1(note) }
function expand1(note) {
 	xmin = xmax = x[1]    
    ymin = ymax = y[1]
    for (i = 2; i <= nd; i++) {
        if (x[i] < xmin) xmin = x[i]
        if (x[i] > xmax) xmax = x[i]
        if (y[i] < ymin) ymin = y[i]
        if (y[i] > ymax) ymax = y[i] }
}

# Draw the frame around the graph.

function frame() {        
    for (i = ox; i < wid; i++) plot(i, oy, "-")     # bottom
    for (i = ox; i < wid; i++) plot(i, ht-1, "-")   # top
    for (i = oy; i < ht; i++) plot(ox, i, "|")      # left
    for (i = oy; i < ht; i++) plot(wid-1, i, "|")   # right
}

# Create tick marks for both axes.

function ticks(    i) {   
    for (i = 1; i <= nb; i++) {
        plot(xscale(bticks[i]), oy, "|")
        splot(xscale(bticks[i])-1, 1, bticks[i])
    }
    for (i = 1; i <= nl; i++) {
        plot(ox, yscale(lticks[i]), "-")
        splot(0, yscale(lticks[i]), lticks[i])
    }
}

# Center labels under x-axis.

function label() {        
    splot(int((wid + ox - length(botlab))/2), 0, botlab)
}

# Create data points.

function data(    i) {    
    for (i = 1; i <= nd; i++)
        plot(xscale(x[i]),yscale(y[i]),ch[i]=="" ? "*" : ch[i])
    for(i in mark) print mark[i]
}

# Print graph from array.

function draw(    i, j) { 
    for (i = ht-1; i >= 0; i--) {
        for (j = 0; j < wid; j++)
            printf((j,i) in array ? array[j,i] : " ")
        printf("\n")
    }
}

# Scale x-values, y-values.

function xscale(x) {      
    return int((x-xmin)/(xmax-xmin) * (wid-1-ox) + ox + 0.5)
}
function yscale(y) {      
    return int((y-ymin)/(ymax-ymin) * (ht-1-oy) + oy + 0.5)
}

# Put one character into array.

function plot(x, y, c) {  
    array[x,y] = c
}

# Put string "s" into array.

function splot(x, y, s,    i, n) { 
    n = length(s)
    for (i = 0; i < n; i++)
        array[x+i, y] = substr(s, i+1, 1)
}

# Author
# 
# This code comes from the original Awk book by Alfred Aho, Peter Weinberger &  Brian Kernighan and contains some small
# modifications by  <A href="?who/timm">Tim Menzies</a>.
