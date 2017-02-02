
ttestOneSClass <- R6::R6Class(
    "ttestOneSClass",
    inherit = ttestOneSBase,
    private = list(
        .init = function() {
            preformatted <- jmvcore::Preformatted$new(self$options, 'pre')
            self$results$add(preformatted)
        },
        .run = function() {

            preformatted <- self$results$get('pre')
            preformatted$content <- ''

            if (is.null(self$options$x))
                return()

            x <- jmvcore::toNumeric(self$data[[self$options$x]])

            ttest <- t.test(
                x=x,
                alternative=self$options$alternative,
                mu=self$options$mu,
                var.equal=self$options$varEqual,
                conf.level=self$options$confLevel)

            preformatted$content <- paste0(capture.output(ttest), collapse='\n')
        },
        .sourcifyOption = function(option) {
            if (option$name == 'x')
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
            args <- private$.asArgs()
            if (args != '')
                args <- paste0(',', args)
            paste0('t.test(\n    x=data$x', args, ')')
        })
)
