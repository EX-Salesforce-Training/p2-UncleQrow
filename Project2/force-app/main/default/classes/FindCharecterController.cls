public class FindCharecterController {
    @auraEnabled
    public static Map <String,Object> findCharecter(string name){
        Map<String, Object> charecter = new Map<String, Object>();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://xivapi.com/character/search?name='+ name);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200){
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            List<Object> charecters = (List<Object>) results.get('Results');
            //system.debug(charecters);
            if(charecters != null || !charecters.isEmpty()){
            	charecter = (Map<String, Object>) charecters[0];
                system.debug(charecter);
            }
        }
        system.debug(charecter);
        return charecter;
    }
    @auraEnabled
    public static Map<String, Object> getCharecterInfo(String Id){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://xivapi.com/character/' + Id +'?extended=1');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        Map<String, Object> Charecter = new Map<String, Object>();
        if(response.getStatusCode() == 200){
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Charecter = (Map<String, Object>) results.get('Character');
        }
        //system.debug(Charecter.get('Portrait'));
        return Charecter;
    }
    @auraEnabled
    public static WrapperFixer getCharecter(string name){
        Map<String,Object> charecter = findCharecter(name);
        WrapperFixer Info = new WrapperFixer();
        if(charecter != null || !charecter.isEmpty()){
            Info.Avatar = string.valueOf(charecter.get('Avatar'));
            Info.CName = string.valueOf(charecter.get('Name'));
            Info.Server = string.valueOf(charecter.get('Server'));
            Info.charecterId = string.valueOf(charecter.get('ID'));
        }
        return Info;
        
    }
    @auraEnabled
    public static void saveCharecter(string Id){
        List<Charecter__c> UserChars = [SELECT Name FROM Charecter__c WHERE OwnerId =: UserInfo.getUserId() LIMIT 1];
        List<Charecter__c> savedChars = [SELECT Name,Id__c, OwnerId, Primary_Charecter__c FROM Charecter__c WHERE Id__c =:Id];
        system.debug(savedChars);
        if(!UserChars.isEmpty()){
            for(Charecter__c item: savedChars){
                item.Primary_Charecter__c = false;
                update item;
            }
        }
        if(!savedChars.isEmpty()){
            savedChars[0].OwnerId = UserInfo.getUserId();
            update savedChars[0];
        } 
        else{
            Map <String, Object> Info = getCharecterInfo(Id);
            Map<String, Object> Race = (Map<String, Object>) Info.get('Race');
            system.debug(Race);
            Charecter__c myCharecter = new Charecter__c();
            myCharecter.Name = string.valueOf(Info.get('Name'));
            myCharecter.Id__c = string.valueOf(Info.get('ID'));
            myCharecter.Race__c = string.valueOf(Race.get('Name'));
            mycharecter.Portrait_Link__c = string.valueof(Info.get('Portrait'));
            mycharecter.Server__c = string.valueOf(Info.get('Server'));
            myCharecter.OwnerId = UserInfo.getUserId();
            insert myCharecter;
        }
    }
}