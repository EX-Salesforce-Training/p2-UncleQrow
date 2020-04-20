public class FindCharecterController {
    @auraEnabled
    public static string findCharecter(string name){
        String Id = '';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://xivapi.com/character/search?name=' + name);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200){
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> charecters = (Map<String, Object>) results.get('Results');
            Map<String, Object> charecter = (Map<String, Object>) charecters.get('0');
            Id = (string) charecter.get('ID');
        }
        return Id;
    }
}