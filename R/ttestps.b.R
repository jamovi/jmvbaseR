
ttestPSClass <- R6::R6Class(
    "ttestPSClass",
    inherit = ttestPSBase,
    private = list(
        .init = function() {
            preformatted <- jmvcore::Preformatted$new(self$options, 'pre')
            self$results$add(preformatted)
        },
        .run = function() {

            preformatted <- self$results$get('pre')
            preformatted$content <- ''

            if (is.null(self$options$x) ||
                is.null(self$options$y))
                return()

            x <- jmvcore::toNumeric(self$data[[self$options$x]])
            y <- jmvcore::toNumeric(self$data[[self$options$y]])

            ttest <- t.test(
                x=x,
                y=y,
                alternative=self$options$alternative,
                mu=self$options$mu,
                paired=TRUE,
                var.equal=self$options$varEqual,
                conf.level=self$options$confLevel)

            preformatted$content <- paste0(capture.output(ttest), collapse='\n')
        },
        .sourcifyOption = function(option) {
            if (option$name == 'x')
                return('')
            if (option$name == 'y')
                return('')
            if (option$name == 'data')
                return('')
            if (option$name == 'varEqual') {
                if (isTRUE(option$value))
                    return('var.equal=TRUE')
                else
                    return('')
            }
            if (option$name == 'confLevel') {
                if (isTRUE(all.equal(option$value, 0.95)))
                    return('')
                else
                    return(paste0('conf.level=', option$value))
            }

            super$.sourcifyOption(option)
        }),
    public=list(
        asSource=function() {
            args <- private$.asArgs(incData=FALSE)
            if (args != '')
                args <- paste0(',', args)
            paste0('t.test(\n    x=data$x,\n    y=data$y,\n    paired=TRUE', args, ')')
        })
)
