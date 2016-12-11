
# This file is a generated template, your changes will not be overwritten

AnovaClass <- R6::R6Class(
    "AnovaClass",
    inherit = AnovaBase,
    private = list(
        .init = function() {
            preformatted <- jmvcore::Preformatted$new(self$options, 'pre')
            self$results$add(preformatted)
        },
        .run = function() {
            preformatted <- self$results$get('pre')
            preformatted$content <- ''

            if (length(self$options$dep) == 0 ||
                length(self$options$ind) == 0)
                return()

            data <- self$data
            data[[self$options$dep]] <- jmvcore::toNumeric(data[[self$options$dep]])

            rhs <- paste0(paste0('`', self$options$ind, '`'), collapse='+')
            formula <- paste0('`', self$options$dep, '`~', rhs)
            formula <- as.formula(formula)

            model <- stats::aov(formula=formula, data=data)
            anova <- stats::anova(model)

            preformatted$content <- paste0(capture.output(anova), collapse='\n')
        }),
        public=list(
            asSource=function() {

                dep <- self$options$dep
                ind <- self$options$ind

                if ( ! is.null(dep) && ! identical(make.names(dep), dep))
                    dep <- paste0('`', dep, '`')
                if (length(ind) > 0 && ! identical(make.names(ind), ind))
                    ind <- paste0('`', ind, '`')

                formula <- paste0(dep, '~', paste(ind, collapse='+'))

                #args <- private$.asArgs()
                #if (args != '')
                #    args <- paste0(',', args)
                args <- ''

                paste0('anova(\n    aov(\n        formula=', formula, ',\n        data=data)', args, ')')
            })
)
