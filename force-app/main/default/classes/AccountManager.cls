@RestResource(urlMapping='/Accounts/*')
global class AccountManager {
	@HttpGet
    global static Account getAccount(){
        Account account = new Account();
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
    	//Hey when are you ready?
       	try{
       	account = [SELECT Id,Name, (SELECT Id,Name FROM Contacts) FROM Account WHERE Id = :accountId LIMIT 1];       
        }
       	catch(Exception e){
            System.debug('Error:  ' + e.getMessage());
        }
        return account;
    }
}