public class ProfileInfoController {
    public static Map<String,integer> getCharecterClasses(String Id){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://xivapi.com/character/'+Id+'?data=CJ');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        List<Object> Jobs = new List<Object>();
        Map<String,integer> classes = new Map<String,integer>();
        if(response.getStatusCode() == 200){
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> Charecter = (Map<String, Object>) results.get('Character');
            Jobs = (List<Object>) Charecter.get('ClassJobs');
            for(object i: jobs){
                Map <String,Object> item = (Map<String,Object>) i;
                String x = item.get('Name').toString();
                integer y = integer.valueOf(item.get('Level'));
                classes.put(x,y);
            }
            //system.debug(classes);
        }
        return classes;
    }
    
    @auraEnabled
    public static Map <String, String> getClassInfo(){
        Id userId = UserInfo.getUserId();
        Charecter__c myCharecter = [SELECT Name,Id__c,Race__c,Server__c FROM Charecter__c WHERE OwnerId =:userId];
        Map<String,integer> Jobs = getCharecterClasses(myCharecter.Id__c);
        Map<String,String> Info = new Map<String, String>();
        Info.put('Name', mycharecter.Name);
        Info.put('Race', mycharecter.Race__c);
        Info.put('Server', mycharecter.Server__c);
        for(String key: Jobs.keyset()){
            Info.put(key, string.valueOf(Jobs.get(key)));
        }
        return Info;
    }
}