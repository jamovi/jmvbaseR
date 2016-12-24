
var view = View.extend({

    initialize: function(ui) {
        this.calcModelTerms(ui);
        this.filterModelTerms(ui);
    },

    events: [
        {
            onChange: "ind", execute: function(ui) {
                this.calcModelTerms(ui);
            }
        },
        {
            onChange: "modelTerms", execute: function(ui) {
                this.filterModelTerms(ui);
            }
        },
        {
            onEvent: "modelTerms.preprocess", execute: function(ui, data) {
                if (data.intoSelf === false)
                    data.items = this.getItemCombinations(data.items);
            }
        }
    ],

    calcModelTerms: function(ui) {
        var variableList = this.cloneArray(ui.ind.value(), []);

        ui.modelSupplier.setValue(this.valuesToItems(variableList, FormatDef.variable));

        var varsDiff = this.findChanges("variableList", variableList, true, FormatDef.variable);

        var termsList = this.cloneArray(ui.modelTerms.value(), []);

        var termsChanged = false;

        for (var i = 0; i < varsDiff.removed.length; i++) {
            for (var j = 0; j < termsList.length; j++) {
                if (FormatDef.term.contains(termsList[j], varsDiff.removed[i])) {
                    termsList.splice(j, 1);
                    termsChanged = true;
                    j -= 1;
                }
            }
        }

        termsList = this.getCombinations(varsDiff.added, termsList);
        termsChanged = termsChanged || varsDiff.added.length > 0;

        if (termsChanged)
            ui.modelTerms.setValue(termsList);
    },

    filterModelTerms : function(ui) {
        var termsList = this.cloneArray(ui.modelTerms.value(), []);

        var termsDiff = this.findChanges("currentList", termsList, true, FormatDef.term);

        var changed = false;
        if (termsDiff.removed.length > 0 && termsList !== null) {
            var itemsRemoved = false;
            for (var i = 0; i < termsDiff.removed.length; i++) {
                var item = termsDiff.removed[i];
                for (var j = 0; j < termsList.length; j++) {
                    if (FormatDef.term.contains(termsList[j], item)) {
                        termsList.splice(j, 1);
                        j -= 1;
                        itemsRemoved = true;
                    }
                }
            }

            if (itemsRemoved)
                changed = true;
        }

        if (this.sortArraysByLength(termsList))
            changed = true;

        if (changed)
            ui.modelTerms.setValue(termsList);
    },
});

module.exports = view;
