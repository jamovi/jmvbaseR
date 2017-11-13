
regressionClass <- if (requireNamespace('jmvcore')) R6::R6Class(
    "regressionClass",
    inherit = regressionBase,
    private = list(
        .init = function() {
            pre <- jmvcore::Preformatted$new(self$options, 'pre')
            self$results$add(pre)
        },
        .run = function() {

            pre <- self$results$get('pre')
            pre$content <- ''

            if (length(self$options$dep) == 0 ||
                length(self$options$ind) == 0 ||
                base::identical(self$options$modelTerms, character()))
                return()

            data <- self$data
            data[[self$options$dep]] <- jmvcore::toNumeric(data[[self$options$dep]])

            formula <- private$.formula()
            formula <- as.formula(formula)

            model <- stats::lm(formula=formula, data=data)
            r <- stats::summary.lm(model)

            pre$content <- paste0(capture.output(r), collapse='\n')
        },
        .formula=function() {
            terms <- self$options$modelTerms
            if (is.null(terms))
                terms <- private$.ff()

            terms <- jmvcore::composeTerms(terms)
            rhs <- paste0(terms, collapse=' + ')
            lhs <- jmvcore::composeTerm(self$options$dep)
            formula <- paste0(lhs, ' ~ ', rhs)
            formula
        },
        .ff=function() {
            fixedFactors <- self$options$ind

            if (length(fixedFactors) > 1) {
                formula <- as.formula(paste('~', paste(paste0('`', fixedFactors, '`'), collapse='*')))
                terms   <- attr(stats::terms(formula), 'term.labels')
                modelTerms <- sapply(terms, function(x) as.list(strsplit(x, ':')), USE.NAMES=FALSE)
            } else {
                modelTerms <- as.list(fixedFactors)
            }

            for (i in seq_along(modelTerms)) {
                term <- modelTerms[[i]]
                quoted <- grepl('^`.*`$', term)
                term[quoted] <- substring(term[quoted], 2, nchar(term[quoted])-1)
                modelTerms[[i]] <- term
            }

            modelTerms
        }),
    public=list(
        asSource=function() {
            formula <- private$.formula()
            model <- paste0('model <- lm(\n    formula = ', formula, ',\n    data = data\n)\n')
            coef <- paste0('summary(model)\n')
            paste(model, coef, sep='\n')
        })
)
