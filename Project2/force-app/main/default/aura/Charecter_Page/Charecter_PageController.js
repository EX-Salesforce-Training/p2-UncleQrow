({
	doInit : function(component, event, helper) {
		var userId = $A.get("$SObjectType.CurrentUser.Id");
        helper.grabProfile(component,event,helper,userId);
	}
})