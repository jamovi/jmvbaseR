
ttestISClass <- R6::R6Class(
    "ttestISClass",
    inherit = ttestISBase,
    private = list(
        .init = function() {
            preformatted <- jmvcore::Preformatted$new(self$options, 'pre')
            self$results$add(preformatted)
        },
        .run = function() {

            preformatted <- self$results$get('pre')
            preformatted$content <- ''

            if (is.null(self$options$dependent) ||
                is.null(self$options$grouping))
                    return()

            data <- self$data
            data[[self$options$dependent]] <- jmvcore::toNumeric(data[[self$options$dependent]])

            ttest <- t.test(
                formula=as.formula(jmvcore::constructFormula(self$options$dependent, self$options$grouping)),
                data=data,
                alternative=self$options$alternative,
                mu=self$options$mu,
                var.equal=self$options$varEqual,
                conf.level=self$options$confLevel)

            preformatted$content <- paste0(capture.output(ttest), collapse='\n')

        },
        .sourcifyOption = function(option) {
            if (option$name == 'dependent')
                return('')
            if (option$name == 'grouping')
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

            dep <- self$options$dependent
            grp <- self$options$grouping

            if ( ! is.null(dep) && ! identical(make.names(dep), dep))
                dep <- paste0('`', dep, '`')
            if ( ! is.null(grp) && ! identical(make.names(grp), grp))
                grp <- paste0('`', grp, '`')

            formula <- paste0(dep, '~', grp)

            args <- private$.asArgs()
            if (args != '')
                args <- paste0(',', args)

            paste0('t.test(\n    formula=', formula, args, ')')
        })
)
