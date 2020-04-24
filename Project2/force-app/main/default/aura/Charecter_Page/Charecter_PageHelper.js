({
	grabProfile : function(component,event,helper) {
        console.log('inGrabe');
		var action = component.get("c.retrieveCharInfo");
        action.setParams({});
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == "SUCCESS"){
                var CharInfo = response.getReturnValue();
                component.set("v.Portrait", response.getReturnValue().Portrait_Link__c);
                component.set("v.Server", response.getReturnValue().Server__c);
                component.set("v.CName", response.getReturnValue().Name);
                component.set("v.Race", response.getReturnValue().Race__c);
                //console.log(component.get("v.Server"));
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
    grabClasses : function(component,event,helper){
        //console.log('inClasses');
        var action = component.get("c.getClassInfo");
        action.setParams({});
        action.setCallback(this, function(response){
            var state = response.getState();
            //console.log(response.getReturnValue());
            if(state == "SUCCESS"){
                var MapKeyArray = [];
                var ClassInfo = response.getReturnValue();
                console.log(ClassInfo);
                component.set("v.ClassLevels", ClassInfo);
                console.log(component.get("v.ClassLevels"));
                for(var Job in ClassInfo){
                    MapKeyArray.push(Job);
                }
                component.set("v.ClassNames", MapKeyArray);
                console.log(component.get("v.ClassNames"));
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