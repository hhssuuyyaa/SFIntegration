public with sharing class SearchYoutubeController {

    @AuraEnabled
    public static superItemList[] getSearchDetails(String searchText){
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

            fromJSON n = (fromJSON)JSON.deserialize(body, fromJSON.class);
            system.debug('Deserialized Response '+n);
            
            superItemList[] dataSet = new superItemList[]{};

            //Iterate the list for all the records returned from REST API
            for(integer i=0; i< n.items.size(); i++){
                dataSet.add(new superItemList( n.items[i].snippet.title, n.items[i].snippet.description, n.items[i].snippet.thumbnails.medium.url, n.items[i].snippet.publishedAt));                      
            }
            return dataSet;

        } catch (Exception e) {
            system.debug(e.getMessage());
            superItemList[] dataSet = new superItemList[]{};
            return dataSet;
        }
    }

    //Custom DataType
    public class superItemList{
        @AuraEnabled
        public String title;

        @AuraEnabled
        public String description;

        @AuraEnabled
        public String thumbnailUrl;

        @AuraEnabled
        public String published;

        public superItemList(String title, String description, String thumbnailUrl, String published){   
            this.title = title;
            this.description = description;
            this.thumbnailUrl = thumbnailUrl;
            this.published = published;
        }    
    }

    public class fromJSON{
        public String kind;	//youtube#searchListResponse
        public String etag;	//nkR0HCLIiaO2XvG1LP0bWw9kvnQ
        public String nextPageToken;	//CAUQAA
        public String regionCode;	//US
        public cls_pageInfo pageInfo;
        public cls_items[] items;
    }

    class cls_pageInfo {
        public Integer totalResults;	//1000000
        public Integer resultsPerPage;	//5
    }
    class cls_items {
        public String kind;	//youtube#searchResult
        public String etag;	//ykkBRnBA6tYYSP9dLNPGsMQ29aw
        public cls_id id;
        public cls_snippet snippet;
    }
    class cls_id {
        public String kind;	//youtube#playlist
        public String playlistId;	//PLKtwV0uJf2IoyEbAIpfSVqyu8GXi6D1zu
    }
    class cls_snippet {
        public String publishedAt;	//2023-04-05T11:41:45Z
        public String channelId;	//UCn7onrQ4bJCMX6HSVWETXzg
        public String title;	//Mevlana Sözleri ( Mutlaka Dinleyin İlaç Gibi )
        public String description;	//Kanalıma ücretsiz abone olabilir beğendiğiniz videolarıma yorum ve paylaşımlarla destek olabilirsiniz...Allah Hepinizden Razı ...
        public cls_thumbnails thumbnails;
        public String channelTitle;	//Ömer Hançeri
        public String liveBroadcastContent;	//none
        public String publishTime;	//2023-04-05T11:41:45Z
    }
    class cls_thumbnails {
        public cls_default default_x;
        public cls_medium medium;
        public cls_high high;
    }
    class cls_default {
        public String url;	//https://i.ytimg.com/vi/iIafwjHeKXE/default.jpg
        public Integer width;	//120
        public Integer height;	//90
    }
    class cls_medium {
        public String url;	//https://i.ytimg.com/vi/iIafwjHeKXE/mqdefault.jpg
        public Integer width;	//320
        public Integer height;	//180
    }
    class cls_high {
        public String url;	//https://i.ytimg.com/vi/iIafwjHeKXE/hqdefault.jpg
        public Integer width;	//480
        public Integer height;	//360
    }
}