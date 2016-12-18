
// This file is an automatically generated template, it will not be subsequently
// overwritten by the compiler, and may be edited

'use strict';

const options = require("./anova.options");

const layout = ui.extend({

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
                }           ]
        }   ]
});

var actions = Actions.extend({
    events: [

    ]
});

module.exports = { ui : layout, actions: actions, options: options };
