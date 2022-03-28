trigger updateTotalNoOfContacts on Contact (after insert) {
    new ContactTriggerHandler().afterInsert();
}