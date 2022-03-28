@isTest
private class TestContactTrigger {
    @isTest
    static void testSingleContactInsert(){
        Account newAcc = new Account(Name='Test Account');
        insert newAcc;

        Contact newContact = new Contact(FirstName='Joe',
        LastName='Smith',
        Phone='415.555.1212',
        AccountId=newAcc.Id);

        Test.startTest();
        insert newContact;
        Test.stopTest();

        Account acc = [SELECT ID,Number_Of_Contacts__c FROM Account WHERE ID= :newAcc.Id];
        System.assertEquals(1,acc.Number_Of_Contacts__c);
    }
    @isTest
    static void testSemiBulkContactInsert(){
        List<Account> all_acc = new List<Account>();
        Integer accLength = 5;
        for (Integer i = 0; i < 5; i++) {
            all_acc.add(new Account(Name='Test Account ' + i));
        }
        insert all_acc;

        List<Contact> all_contacts = new List<Contact>();
        for (Integer i = 0; i < accLength; i++) {
            Integer j = 0;
            while(j < 50){
                all_contacts.add(new Contact(
                    FirstName='Test Contact ' + i +j,
                    LastName='LName',
                    Phone='123456',
                    AccountId=all_acc[i].Id
                ));
                j++;
            }
        }
        insert all_contacts;

        for(Account acc : [SELECT Id, Number_Of_Contacts__c FROM Account WHERE Id = :all_acc]){
            System.assertEquals(50, acc.Number_Of_Contacts__c);
        }
    }
}
