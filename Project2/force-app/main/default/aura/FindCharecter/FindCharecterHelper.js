({
    doSearch : function(component,event,helper) {
        console.log('In Search');
        var action = component.get("c.getCharecter");
        action.setParams({"name" : component.get("v.CharecterName")});
        action.setCallback(this, function(response){
            console.log(response.getReturnValue());
            if(response.getReturnValue() == null){
                component.set("v.nullChar", true);
            }
            var state = response.getState();
            if(state == "SUCCESS"){
                //console.log(response.getReturnValue().Avatar);
                component.set("v.Avatar", response.getReturnValue().Avatar);
                component.set("v.Server", response.getReturnValue().Server);
                component.set("v.CId", response.getReturnValue().charecterId);
                component.set("v.Search", false);
                component.set("v.nullChar", false);
                //console.log(component.get("v.Avatar"));
                //console.log(component.get("v.Server"));
                //console.log(component.get("v.CId"));
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
        console.log('here');
    },
    saveId: function(component,event,helper) {
        console.log("In Save");
        var save_action = component.get("c.saveCharecter");
        save_action.setParams({"Id" : component.get("v.CId")});
        save_action.setCallback(this, function(response){
             var state = response.getState();
             if(state == "SUCCESS"){
                 component.set("v.Saved", true);
                 component.set("v.Search", true);
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
        $A.enqueueAction(save_action);
    }
})