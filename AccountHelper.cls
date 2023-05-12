public class AccountHelper {
    Public static final string ACCOUNT_STATUS= 'Cold';
    Public static List<Account> listMatchForChild = new List<Account>();
    
    public static void triggerHelper(
        System.TriggerOperation operationtype,
        List<Account> newList,
        Map<Id,Account> oldMap){
            
            Switch on Trigger.OperationType {
                when AFTER_INSERT {
                    if(RecursiveTriggerHandler.isFirstTime){
                        RecursiveTriggerHandler.isFirstTime = false;
                        accountStatuscheck(newList);  
                    }
                }
                
            }
        }
    Public static void accountStatuscheck(List<Account> newList){
        system.debug('newList---'+newList.size());
        for(Account acc:newList){
            if(acc.Status__c==ACCOUNT_STATUS && acc.ParentId==null){
                listMatchForChild.add(acc);
            }
        }
        
        childAccountcreate(listMatchForChild);
    }
    
    Public static void childAccountcreate(List<Account> accParent){
        List<Account> accListtoCreate = New List<Account>();
        for(Account accChild:accParent){
            Account accChildcreteInstance = New Account();
            accChildcreteInstance.Name= 'Child of ' + accChild.Name;
            //Fields added as per validation in my org.
            accChildcreteInstance.Support_Tier__c=accChild.Support_Tier__c;
            accChildcreteInstance.ParentId=accChild.Id;
            accChildcreteInstance.Status__c=accChild.Status__c;
            accListtoCreate.add(accChildcreteInstance);
            system.debug('--accListtoCreate--'+accListtoCreate);
        }
        try{
            Database.insert(accListtoCreate);
        }
        catch(exception e){
            system.debug('===e==='+e.getMessage());
        }
    }
}