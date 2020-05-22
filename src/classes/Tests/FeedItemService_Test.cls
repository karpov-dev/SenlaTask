@isTest
public class FeedItemService_Test {

    @TestSetup static  void setup(){
        Account sourceAccountWithFeedItem = AccountDataFactory.getAccountByName('Source Account');
        Account sourceAccountWithoutFeedItem = AccountDataFactory.getAccountByName('Source Account Without Item');
        Account targetAccount = AccountDataFactory.getAccountByName('Target Account');
        Contact targetContact = ContactDataFactory.getContact();

        List<Account> accountsToInsert = new List<Account>();
        accountsToInsert.add(sourceAccountWithoutFeedItem);
        accountsToInsert.add(sourceAccountWithFeedItem);
        accountsToInsert.add(targetAccount);
        insert accountsToInsert;
        insert targetContact;

        FeedItem item = FeedItemDataFactory.getTextPostFeedItem(sourceAccountWithFeedItem.Id);
        insert item;
    }

    @isTest static void cloneTextPost_ValidData() {
        Account sourceAccount = [SELECT Id, Name FROM Account WHERE Name = 'Source Account'];
        Account targetAccount = [SELECT Id, Name FROM Account WHERE Name = 'Target Account'];
        FeedItem item = [SELECT Id, Title, Body, Type, ParentId FROM FeedItem WHERE ParentId =: sourceAccount.Id];

        Test.startTest();
        List<FeedItem> clonedItems = FeedItemService.cloneTextPost(sourceAccount.Id, targetAccount.Id);
        Test.stopTest();

        System.assertEquals(1, clonedItems.size());
        System.assertEquals(targetAccount.Id, clonedItems[0].ParentId);
    }

    @IsTest static void cloneTextPost_CloneAccountToContact() {
        Account sourceAccount = [SELECT Id, Name FROM Account WHERE Name = 'Source Account'];
        Contact targetContact = [SELECT Id, FirstName, LastName FROM Contact];
        FeedItem item = [SELECT Id, Title, Body, Type FROM FeedItem WHERE ParentId =: sourceAccount.Id];

        Test.startTest();
        List<FeedItem> clonedItems = FeedItemService.cloneTextPost(sourceAccount.Id, targetContact.Id);
        Test.stopTest();

        System.assertEquals(1, clonedItems.size());
    }

    @isTest static void cloneTextPost_AccountWithoutFeedItems() {
        Account sourceAccount = [SELECT Id, Name FROM Account WHERE Name = 'Source Account Without Item'];
        Account targetAccount = [SELECT Id, Name FROM Account WHERE Name = 'Target Account'];

        Test.startTest();
        List<FeedItem> clonedItems = FeedItemService.cloneTextPost(sourceAccount.Id, targetAccount.Id);
        Test.stopTest();

        System.assertEquals(0, clonedItems.size());
    }

    @isTest static void cloneTextPost_NullData() {
        Test.startTest();
        List<FeedItem> clonedItems = FeedItemService.cloneTextPost(null, null);
        Test.stopTest();

        System.assertEquals(0, clonedItems.size());
    }

    @IsTest static void cloneTextPost_EmptyData() {
        //accounts before insert (without id)
        Account sourceAccount = AccountDataFactory.getAccountByName('Source Account');
        Account targetAccount = AccountDataFactory.getAccountByName('Target Account');

        Test.startTest();
        List<FeedItem> clonedItems = FeedItemService.cloneTextPost(sourceAccount.Id, targetAccount.Id);
        Test.stopTest();

        System.assertEquals(0, clonedItems.size());
    }

    @IsTest static void cloneTrackedChangeToTextPost_NullData() {
        Account sourceAccount = [SELECT Id, Name FROM Account WHERE Name = 'Source Account'];
        Account targetAccount = [SELECT Id, Name FROM Account WHERE Name = 'Target Account'];
        sourceAccount.Phone = '987654321';
        update sourceAccount;

        Test.startTest();
        FeedItem clonedItems = FeedItemService.cloneTrackedChangeToTextPost(sourceAccount.Id, targetAccount.Id);
        Test.stopTest();

        System.assertEquals(null, clonedItems.Id);
    }

    @IsTest static void cloneTrackedChangeToTextPost_SourceChanged() {
        Account sourceAccount = [SELECT Id, Name FROM Account WHERE Name = 'Source Account'];
        Account targetAccount = [SELECT Id, Name FROM Account WHERE Name = 'Target Account'];

        Test.startTest();
        FeedItem clonedItems = FeedItemService.cloneTrackedChangeToTextPost(sourceAccount.Id, targetAccount.Id);
        Test.stopTest();

        System.assertEquals(null, clonedItems.Id);
    }

    @IsTest static void cloneTrackedChangeToTextPost_EmptyIdData() {
        Account sourceAccount = AccountDataFactory.getAccountByName('Source Account');
        Account targetAccount = AccountDataFactory.getAccountByName('Target Account');

        Test.startTest();
        FeedItem clonedItems = FeedItemService.cloneTrackedChangeToTextPost(sourceAccount.Id, targetAccount.Id);
        Test.stopTest();

        System.assertEquals(null, clonedItems.Id);
    }
}