
'use strict';

const options = require("./ttestis.options");

const layout = ui.extend({

    label: "Independent Samples T-Test",
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
                   name: "dependent",
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
                   name: "grouping",
                   label: "Grouping Variable",
                   maxItemCount: 1,
                   showColumnHeaders: false,
                   fullRowSelect: true,
                   columns: [
                       { type: "listitem.variablelabel", name: "column1", label: "", stretchFactor: 1 }
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
        }   ]
});

var actions = Actions.extend({
    events: [

    ]
});

module.exports = { ui : layout, actions: actions, options: options };
