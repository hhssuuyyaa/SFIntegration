public with sharing class SearchYoutubeController {
    @AuraEnabled
    public static string getSearchDetails(String searchText){
        try {

            String endpoint = System.Label.YoutubeEndPoint;
            endpoint += '?part=snippet';
            endpoint += '&maxResults=5';
            endpoint += '&q='+searchText;
            endpoint += '&key='+System.Label.YoutubeApiKey;
            endpoint = endpoint.replace(' ', '%20');

            system.debug('endpoint '+endpoint);

            Http http = new Http();

            HttpRequest request = new HttpRequest();
            request.setHeader('Accept','application/json');
            request.setEndpoint(endpoint);
            request.setMethod('GET');

            HttpResponse response = http.send(request);

            String body = response.getBody();
            return body;

        } catch (Exception e) {
            system.debug(e.getMessage());
            return 'error';
        }
    }
}