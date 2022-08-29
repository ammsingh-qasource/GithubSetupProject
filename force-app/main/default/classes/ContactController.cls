public with sharing class ContactController {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts() {
        return [
            SELECT FirstName, LastName, Email
            FROM Contact
            WITH SECURITY_ENFORCED
            ORDER BY FirstName
        ];
 
    }

    @AuraEnabled(cacheable=true)
    public static Account getAccountData(Id recordId) {
        Account acc = Database.query('SELECT Name from Account where Id = :recordId LIMIT 1');
        return acc;
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> fetchContacts(Id accountId) {
        System.debug('Hi'+accountId);
        List<Contact> conList = Database.query('SELECT Id, FirstName, LastName, Email FROM Contact WHERE AccountId= :accountId WITH SECURITY_ENFORCED ORDER BY FirstName');
        return conList;
    }

    @AuraEnabled
    public static string updateContacts( Object data ) {
        
        List<Contact> consForUpdate = (List<Contact>) JSON.deserialize(
            JSON.serialize( data ),
            List<Contact>.class
        );
        try {
            update consForUpdate;
            return 'Success: Contact(s) updated successfully';
        }
        catch (Exception e) {
            return 'The following exception has occurred: ' + e.getMessage();
        }

    }
}