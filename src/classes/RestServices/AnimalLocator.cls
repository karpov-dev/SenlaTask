/**
 * Created by passa on 20.05.2020.
 */

public with sharing class AnimalLocator {

    public static String getAnimalNameById(Integer Id){
        String animalName = '';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + Id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if(response.getStatusCode() == 200){
            AnimalResponse animal = (AnimalResponse) JSON.deserialize(response.getBody(), AnimalResponse.class);
            animalName = animal.animal.name;
        }
        return  animalName;
    }

    private class AnimalResponse{
        public Animal animal;
    }
    private class Animal{
        public Integer id;
        public String name;
        public String eats;
        public String says;
    }

}