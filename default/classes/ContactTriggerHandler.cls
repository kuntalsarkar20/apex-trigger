public class ContactTriggerHandler {
    public void afterInsert(){
        List<Contact> all_contacts = Trigger.new;
        Set<Id> accSetId = new Set<Id>();

        for(Contact cntct : all_contacts){
            if(cntct.AccountId != null)
                accSetId.add(cntct.AccountId);
        }

        if(!accSetId.isEmpty()){
            updateAccount(accSetId);
        }
    }

    private void updateAccount(Set<Id> accId){
        List<Account> all_accs = new List<Account>();

        for(Account acc : [Select Id, Number_of_contacts__c, (SELECT Id from Contacts) FROM Account 
                WHERE ID in: accId]){

                    acc.Number_Of_Contacts__c = acc.Contacts.size();
                    all_accs.add(acc);
        }

        if(!all_accs.isEmpty()){
            update all_accs;
        }
        
    }
}
