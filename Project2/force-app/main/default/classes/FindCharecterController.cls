public class FindCharecterController {
    public static Map <String,Object> findCharecter(string name){
        Map<String, Object> charecter = new Map<String, Object>();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://xivapi.com/character/search?name=' + name);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200){
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> charecters = (Map<String, Object>) results.get('Results');
            if(charecters != null || !charecters.isEmpty()){
            	charecter = (Map<String, Object>) charecters.get('0');
            }
        }
        return charecter;
    }
    @auraEnabled
    public static Map <String, String> getCharecter(string name){
        Map<String,Object> charecter = findCharecter(name);
        Map <String, String> Info = new Map<String, String>();
        if(charecter != null || !charecter.isEmpty()){
            String Avatar = (String) charecter.get('Avatar');
            String CName = (String) charecter.get('Name');
            String Server = (String) charecter.get('Server');
            String charecterId = (String) charecter.get('ID');
            Info.put('Avatar', Avatar);
            Info.put('CName', CName);
            Info.put('Server', Server);
            Info.put('charecterId', charecterId);
        }
        return Info;
        
    }
    @auraEnabled
    public static void saveCId(string Id){
        Id userId = UserInfo.getUserId();
        User currentUser = [SELECT Id, charecterId__c FROM User WHERE Id = :userId];
        currentUser.CharecterId__c = Id;
        update currentUser;
    }
}