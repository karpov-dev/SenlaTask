@IsTest
private class AccountService_Test {

    @IsTest static void SetTimeTaskFourField_ValidData() {
        List<Account> accountsToTest = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            accountsToTest.add(AccountDataFactory.getAccountByName('Account number ' + i));
        }
        insert accountsToTest;

        Test.startTest();
        AccountService.setTimeTaskFourField(accountsToTest);
        Test.stopTest();

        List<Account> updatedAccounts = [
                SELECT Task_Four_Date_Time__c
                FROM Account
        ];

        Datetime currentDateTime = Datetime.now();
        for (Account account : updatedAccounts) {
            System.assert(updatedAccounts != null);
            System.assert(account.Task_Four_Date_Time__c != null);
            System.assertEquals(currentDateTime.time().hour(), account.Task_Four_Date_Time__c.hour());
        }
    }
}