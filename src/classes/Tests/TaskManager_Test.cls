@IsTest
public with sharing class TaskManager_Test {

    @TestSetup static void setup(){
        Lead leadWithTask = LeadDataFactory.getLeadByName('With', 'Tasks', '1@mail.com');
        Lead leadWithoutTask = LeadDataFactory.getLeadByName('Without', 'Task', '2@mail.com');
        insert leadWithoutTask;
        insert leadWithTask;

        Task task = TaskDataFactory.getTaskWithWhoId(leadWithTask.Id);
        insert task;
    }

    @IsTest static void getTasksByWhoId_ValidData(){
        Lead lead = [SELECT Id, FirstName, LastName FROM Lead WHERE FirstName = 'With' AND LastName ='Tasks'];

        Test.startTest();
        List<Task> result = TaskManager.getTasksByWhoId(lead.Id);
        Test.stopTest();

        System.assert(result != null);
        System.assertEquals(1, result.size());
        System.assertEquals(lead.Id, result[0].WhoId);
    }

    @IsTest static void getTasksByWhoId_LeadWithoutTasks(){
        Lead lead = [SELECT Id, FirstName, LastName FROM Lead WHERE FirstName = 'Without' AND LastName ='Task'];

        Test.startTest();
        List<Task> result = TaskManager.getTasksByWhoId(lead.Id);
        Test.stopTest();

        System.assert(result != null);
        System.assertEquals(0, result.size());
    }

    @IsTest static void getTasksByWhoId_EmptyLeadId(){
        Lead lead = LeadDataFactory.getLeadByName('Test', 'Lead', '1@mail.com');

        Test.startTest();
        List<Task> result = TaskManager.getTasksByWhoId(lead.Id);
        Test.stopTest();

        System.assert(result != null);
        System.assertEquals(0, result.size());
    }

    @IsTest static void getTasksByWhoId_NullId(){
        Test.startTest();
        List<Task> result = TaskManager.getTasksByWhoId(null);
        Test.stopTest();

        System.assert(result != null);
        System.assertEquals(0, result.size());
    }

}