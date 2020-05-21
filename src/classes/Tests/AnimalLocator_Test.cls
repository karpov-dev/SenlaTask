/**
 * Created by passa on 20.05.2020.
 */

@IsTest
private class AnimalLocator_Test {

    @IsTest static void getAnimalNameById_NormalData() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        String response = AnimalLocator.getAnimalNameById(1);
        System.assertEquals(response, 'chicken');
    }

}