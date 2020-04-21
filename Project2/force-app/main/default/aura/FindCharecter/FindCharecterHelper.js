({
    doSearch : function(component,event,helper) {
        var action = component.get("c.getCharecter");
        action.setParams({"name" : component.get("v.CharecterName")});
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == "SUCCESS"){
                var BaseCharInfo = response.getReturnValue();
                component.set("v.Avatar", BaseCharInfo.get("Avatar"));
                component.set("v.Server", BaseCharInfo.get("Server"));
                component.set("v.CId", BaseCharInfo.get("charecterId"));
            }
            else if (state === "INCOMPLETE") {
                console.log("Failed to connect Salesforce!!");
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (!errors) {
                        errors = [{"message" : "Unknown Error"}];
                    }
                    console.log(errors);
                }
        });
        $A.enqueueAction(action);
    },
    saveId: function(component,event,helper) {
        var save_action = component.get("c.saveCId");
        save_action.setParams({});
        $A.enqueueAction(save_action);
    }
})