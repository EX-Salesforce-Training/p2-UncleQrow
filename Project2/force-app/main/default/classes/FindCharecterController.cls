public class FindCharecterController {
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
        //system.debug(Race.get('Name'));
        return Charecter;
    }
    @auraEnabled
    public static Map <String, String> getCharecter(string name){
        Map<String,Object> charecter = findCharecter(name);
        Map <String, String> Info = new Map<String, String>();
        if(charecter != null || !charecter.isEmpty()){
            String Avatar = string.valueOf(charecter.get('Avatar'));
            String CName = string.valueOf(charecter.get('Name'));
            String Server = string.valueOf(charecter.get('Server'));
            String charecterId = string.valueOf(charecter.get('ID'));
            Info.put('Avatar', Avatar);
            Info.put('CName', CName);
            Info.put('Server', Server);
            Info.put('charecterId', charecterId);
        }
        return Info;
        
    }
    @auraEnabled
    public static void saveCharecter(string Id){
        Map <String, Object> Info = getCharecterInfo(Id);
        Map<String, Object> Race = (Map<String, Object>) Info.get('Race');
        Charecter__c myCharecter = new Charecter__c();
        myCharecter.Name = string.valueOf(Info.get('Name'));
        myCharecter.Id__c = string.valueOf(Info.get('ID'));
        myCharecter.Race__c = string.valueOf(Race.get('Name'));
        myCharecter.OwnerId = UserInfo.getUserId();
        upsert myCharecter;
    }
}