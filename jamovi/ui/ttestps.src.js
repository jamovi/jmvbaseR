
// This file is an automatically generated template, it will not be subsequently
// overwritten by the compiler, and may be edited

'use strict';

const options = require("./ttestps.options");

const layout = ui.extend({

    label: "Paired Samples T-Test",
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
                   name: "x",
                   label: "x",
                   maxItemCount: 1,
                   showColumnHeaders: false,
                   fullRowSelect: true,
                   columns: [
                       { type: "listitem.variablelabel", name: "column1", label: "", format: FormatDef.variable, stretchFactor: 1 }
                   ]
                },
                {
                   type: "variabletargetlistbox",
                   name: "y",
                   label: "y",
                   maxItemCount: 1,
                   showColumnHeaders: false,
                   fullRowSelect: true,
                   columns: [
                       { type: "listitem.variablelabel", name: "column1", label: "", format: FormatDef.variable, stretchFactor: 1 }
                   ]
                }
           ]
        },
        {
            type: "layoutbox",
            margin: "large",
            controls: [
                { name: "alternative", type:"combobox", label: "alternative", options: [
                    { label: "two.sided", value: "two.sided" },
                    { label: "less", value: "less" },
                    { label: "greater", value: "greater" }
                ] },
                { name: "mu", type:"textbox", label: "mu", format: FormatDef.number, inputPattern: "[0-9]+" }
           ]
        },
        {
            type: "layoutbox",
            margin: "large",
            controls: [
                { name: "varEqual", type:"checkbox", label: "var.equal" }
           ]
        },
        {
            type: "layoutbox",
            margin: "large",
            controls: [
                { name: "confLevel", type:"textbox", label: "conf.level", format: FormatDef.number, inputPattern: "[0-9]+" }           ]
        }   ],

    actions: []
});

module.exports = { ui : layout, options: options };
