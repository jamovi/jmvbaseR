
// This file is an automatically generated template, it will not be subsequently
// overwritten by the compiler, and may be edited

'use strict';

const options = require("./anova.options");
const view = require('./anova.actions');

view.layout = ui.extend({

    label: "ANOVA",
    type: "root",
    stage: 0,
    controls: [
        {
           type: "variablesupplier",
           persistentItems: false,
           stretchFactor: 1,
           controls: [
                {
                   type: "variabletargetlistbox",
                   name: "dep",
                   label: "Dependent Variable",
                   maxItemCount: 1,
                   showColumnHeaders: false,
                   fullRowSelect: true,
                   columns: [
                       { type: "listitem.variablelabel", name: "column1", label: "", stretchFactor: 1 }
                   ]
                },
                {
                   type: "variabletargetlistbox",
                   name: "ind",
                   label: "Independent Variables",
                   showColumnHeaders: false,
                   fullRowSelect: true,
                   columns: [
                       { type: "listitem.variablelabel", name: "column1", label: "", stretchFactor: 1 }
                   ]
                }
            ]
        },
        {
            name: "modelgroup",
            type: "collapsebox",
            label: "Model",
            collapsed: true,
            stretchFactor: 1,
            controls : [
                {
                    type: "supplier",
                    name: "modelSupplier",
                    label: "Componets",
                    persistentItems: true,
                    stretchFactor: 1,
                    controls: [
                        {
                            type:"targetlistbox",
                            name: "modelTerms",
                            format: FormatDef.term,
                            label: "Model Terms",
                            showColumnHeaders: false,
                            valueFilter: "unique",
                            itemDropBehaviour: "empty_space",
                            columns: [
                                { type: "listitem.termlabel", name: "column1", label: "", format: FormatDef.term, stretchFactor: 1 }
                            ]
                        }
                    ]
                }
            ]
        },
    ]
});


module.exports = { view : view, options: options };
