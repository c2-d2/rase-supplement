#!/usr/bin/env Rscript

library(stats)
library(plyr)

# FPR = FP/(FP+TN)
FPR = function(p.vec, r.vec, R.vec) {
  sum(p.vec * (1 - r.vec) * R.vec) / sum(p.vec * (1 - r.vec))
}

# TPR = TP/(TP+FN)
TPR = function(p.vec, r.vec, R.vec) {
  sum(p.vec * r.vec * R.vec) / sum(p.vec * r.vec)
}

shift.df = function(d, k) {
  rbind(tail(d, k), head(d, -k), deparse.level = 0)
}


example.roc.chull = function(lineages = 4,
  eq.pri = T,
  seed = 42,
  p.vec = NA,
  xlab = "FPR (1-specificity)",
  ylab = "TPR (sensitivity)",
  ...) {
  set.seed(seed)
  # p: prior probabilities of phylogroups
  # r: proportions of resistant isolates
  # R: probability of assigning resistance
  plot(
    NA,
    xlim = c(0, 1),
    ylim = c(0, 1),
    xlab = xlab,
    ylab = ylab,
    ...
  )
  
  # initialize p.vec = prior probabilities of phylogroups
  
  if (any(is.na(p.vec))) {
    p.vec = runif(lineages) # to ensure that same random numbers are always generated
  }
  if (eq.pri) {
    p.vec = rep(1, lineages)
  }
  p.vec = p.vec / sum(p.vec)
  
  # initialize r.vec = proportion of resistance in phylogroups
  r.vec = sort(runif(lineages))
  
  # generate cube vertices
  cube = as.matrix(do.call(expand.grid, c(rep(
    list(c(0, 1)), lineages
  ))))
  
  # calculate images of cube vertices in the roc coordinates
  cube.roc = plyr::adply(cube, 1,
    function(x) {
      c(FPR(p.vec, r.vec, x), TPR(p.vec, r.vec, x))
    }, .inform = T, .expand = F, .id = NULL)
  
  # calculate their convex hull
  hpts = chull(cube.roc)
  roc.vertices = cube.roc[hpts,]
  while (all(roc.vertices[1, ] != c(0, 0))) {
    roc.vertices = shift.df(roc.vertices, -1)
  }
  
  # plot the convex hull
  polygon(roc.vertices, col = "grey")
  
  #plot upper line
  lines(head(roc.vertices, lineages + 1),
    col = "red",
    lw = 2)
  
  # plot cube vertices
  points(cube.roc, col = "red", pch = rowSums(cube) + 1)
  
  pos = legend(
    "bottomright",
    pch = seq(lineages + 1),
    legend = seq(lineages + 1) - 1,
    col = "red",
    title = "RL",
    box.col = NA
  )
  
  xleft <- pos$rect[["left"]]
  ytop <- pos$rect[["top"]]
  ybottom <- ytop - pos$rect[["h"]]
  xright <- xleft + pos$rect[["w"]]
  rect(xleft, ybottom, xright, ytop + 0.05)
  p.vec
}

#plot.roc.chull(seed=6, lineages=3, eq.pri=F)
