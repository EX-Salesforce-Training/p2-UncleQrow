public class ProfileInfoController {
    public static Map<String, Object> getCharecter(String Id){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://xivapi.com/character/' + Id +'?data=CJ');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        Map<String, Object> Charecter = new Map<String, Object>();
        if(response.getStatusCode() == 200){
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Charecter = (Map<String, Object>) results.get('Charecter');
        }
        return Charecter;
    }
    
    @auraEnabled
    public static void parseInfo(String Id){
        Map<String, Object> Info = getCharecter(Id);
    }
}