#' @include mlr.learners.R
#' @include LearnerRegr.R
mlr.learners$add(LearnerRegr$new(
  name = "dummy",
  par.set = ParamSetFlat$new(
    params = list(
      ParamCategorical$new("method", values = c("mean", "median"), default = "mean")
    )
  ),
  par.vals = list(),
  properties = c("missings", "feat.factor", "feat.numeric"),
  train = function(task, subset, method = "mean", ...) {
    tn = unlist(task$get(subset, task$target))
    mod = switch(method,
      "mean" = mean(tn),
      "median" = median(tn),
      stop("Illegal value for 'method'"))
    class(mod) = c("dummy.model", class(mod))
    mod
  },

  predict = function(model, newdata, ...) {
    rep(as.numeric(model$rmodel), nrow(newdata))
  }
))
