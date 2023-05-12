/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 05-13-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class ContactHelper {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(Id AccountId) {
        return [SELECT Id, FirstName,LastName,Name,DoNotCall,Email,CreatedDate FROM contact where AccountId=:AccountId ];
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(Id AccountId) {
        return [SELECT Id,Name,Status__c,AnnualRevenue,CreatedDate FROM Account where ParentId=:AccountId ];
    }
}