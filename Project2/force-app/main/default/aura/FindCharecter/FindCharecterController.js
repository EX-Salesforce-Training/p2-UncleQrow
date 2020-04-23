({
    handleClick : function (cmp, event, helper) {
        helper.doSearch(cmp,event,helper);
        component.set("v.Search", false);
    },
    SaveCharecter: function (cmp, event, helper){
        helper.saveId(cmp,event,helper);
        component.set("v.Search", true);
    }
})