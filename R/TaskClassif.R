#' @title Classification Tasks
#' @format [R6Class()] object
#'
#' @description
#' A [R6::R6Class()] to construct classification tasks.
#'
#' @template fields-task
#' @template fields-supervisedtask
#' @field positive (`character(1)`)\cr
#'  Only for binary classification: Level of the positive class (`NA` otherwise).
#' @field classes [`character()`]\cr
#'  Levels of class labels.
#' @field nclasses (`integer(1)`)\cr
#'  Number of levels of class labels.
#'
#' @return [TaskClassif()].
#' @include TaskSupervised.R
#' @export
#' @family Tasks
#' @examples
#' task = TaskClassif$new("iris", data = iris, target = "Species")
#' task$formula
TaskClassif = R6Class("TaskClassif",
  inherit = TaskSupervised,
  public = list(
    task.type = "classif",
    positive = NA_character_,
    initialize = function(id = deparse(substitute(data)), data, target, positive) {
      super$initialize(id = id, data = data, target = target)
      qassert(self$head(1L)[[self$target]], c("S", "F"))
    },
    print = function(...) {
      cat("Classification ")
      super$print()
    }
  ),

  active = list(
    classes = function() self$backend$distinct(self$target),
    nclasses = function() length(self$classes)
  )
)
