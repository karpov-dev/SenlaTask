@isTest
public class FeedItemManager_Test {

    @TestSetup static void setup() {
        Account accountWithFeedItem = AccountDataFactory.getAccountByName('With Feed Item');
        Account accountWithoutFeedItem = AccountDataFactory.getAccountByName('Without Feed Item');
        insert accountWithoutFeedItem;
        insert accountWithFeedItem;
        FeedItem feedItem = FeedItemDataFactory.getTextPostFeedItem(accountWithFeedItem.Id);
        insert feedItem;
    }

    @isTest static void getItemsByParentIdAndType_FoundData() {
        Account feedItemOwner = [SELECT Id, Name, Phone FROM Account WHERE Name = 'With Feed Item'];

        Test.startTest();
        List<FeedItem> returnedList = FeedItemManager.getItemsByParentIdAndType(feedItemOwner.Id, 'TextPost');
        Test.stopTest();

        System.assertEquals(1, returnedList.size());
        System.assertEquals(feedItemOwner.Id, returnedList[0].ParentId);
    }

    @isTest static void getItemsByParentIdAndType_NotFoundData() {
        Account feedItemOwner = [SELECT Id, Name, Phone FROM Account WHERE Name = 'Without Feed Item'];

        Test.startTest();
        List<FeedItem> returnedList = FeedItemManager.getItemsByParentIdAndType(feedItemOwner.Id, 'TextPost');
        Test.stopTest();

        System.assertEquals(0, returnedList.size());
    }

    @isTest static void getItemsByParentIdAndType_NullData() {
        Test.startTest();
        List<FeedItem> returnedList = FeedItemManager.getItemsByParentIdAndType(null, null);
        Test.stopTest();

        System.assertEquals(0, returnedList.size());
    }

    @isTest static void getItemsByParentIdAndType_EmptyData() {
        //account without id (before insert)
        Account account = AccountDataFactory.getAccount();

        Test.startTest();
        List<FeedItem> returnedList = FeedItemManager.getItemsByParentIdAndType(account.Id, '');
        Test.stopTest();

        System.assertEquals(0, returnedList.size());
    }
}