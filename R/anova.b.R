
# This file is a generated template, your changes will not be overwritten

anovaClass <- R6::R6Class(
    "anovaClass",
    inherit = anovaBase,
    private = list(
        .init = function() {
            preformatted <- jmvcore::Preformatted$new(self$options, 'pre')
            self$results$add(preformatted)
        },
        .run = function() {

            preformatted <- self$results$get('pre')
            preformatted$content <- ''

            if (length(self$options$dep) == 0 ||
                length(self$options$ind) == 0 ||
                base::identical(self$options$modelTerms, character()))
                return()

            data <- self$data
            data[[self$options$dep]] <- jmvcore::toNumeric(data[[self$options$dep]])

            formula <- private$.formula()
            formula <- as.formula(formula)

            model <- stats::aov(formula=formula, data=data)
            anova <- stats::anova(model)

            preformatted$content <- paste0(capture.output(anova), collapse='\n')
        },
        .formula=function() {
            terms <- self$options$modelTerms
            if (is.null(terms))
                terms <- private$.ff()

            terms <- jmvcore::composeTerms(terms)
            rhs <- paste0(terms, collapse='+')
            lhs <- jmvcore::composeTerm(self$options$dep)
            formula <- paste0(lhs, '~', rhs)
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
                args <- ''
                paste0('anova(\n    aov(\n        formula=', formula, ',\n        data=data)', args, ')')
            })
)
