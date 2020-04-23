({
	grabProfile : function() {
		var action = component.get("c.retrieveCharInfo");
        action.setParams({});
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == "SUCCESS"){
                var CharInfo = response.getReturnValue();
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
    grabClasses : function(){
        var action = component.get("c.getClassInfo");
        action.setParams({});
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == "SUCCESS"){
                var ClassInfo = response.getReturnValue();
                let Classes = [...ClassInfo.keys()];
                component.set("v.ClassNames", Classes);
                component.set("v.ClassLevels", ClassInfo);
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
    }
})