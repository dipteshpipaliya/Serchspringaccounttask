import { LightningElement,api,track,wire} from 'lwc';
import getContactList from '@salesforce/apex/ContactHelper.getContactList';
import getAccountList from '@salesforce/apex/ContactHelper.getAccountList';

export default class AccountRelatedTable extends LightningElement {
    @api recordId;
    @track columns = [
    { label: 'Name',fieldName: 'conLink', type: 'url',
    typeAttributes: { label: { fieldName: 'Name' }, target: '_blank' }},
    {label: 'DoNotCall',fieldName: 'DoNotCall'},
    {label: 'Email',fieldName: 'Email'},
    {label: 'CreatedDate',fieldName: 'CreatedDate'}
];
@track columnsforaccount = [
    { label: 'Name',fieldName: 'accLink', type: 'url',
    typeAttributes: { label: { fieldName: 'Name' }, target: '_blank' }},
    {label: 'Status',fieldName: 'Status__c'},
    {label: 'AnnualRevenue',fieldName: 'AnnualRevenue'},
    {label: 'CreatedDate',fieldName: 'CreatedDate'}
];
@track error;
@track errorinAccount;
@track contactDataAvaialble;
@track AccountDataAvaialble;
@track conList ;
@track data;
@wire(getContactList,{AccountId :'$recordId'})
wiredContacts({error,data}) {
    if (data) {
        data = JSON.parse(JSON.stringify(data));

        data.forEach(con => {
            con.conLink = '/' + con.Id;
        });
        console.log(data);
        this.conList = data;
        if(this.conList.length === 0){
            this.error='There are no Related contact for this Record.';
        }
        else
        this.contactDataAvaialble=true;
    } else if (error) {
        this.error = error;
     }
}
@wire(getAccountList,{AccountId :'$recordId'})
wiredAccount({error,data}) {
    if (data) {
        data = JSON.parse(JSON.stringify(data));
        
        data.forEach(acc => {
            acc.accLink = '/' + acc.Id;
        });
        console.log(data);
        this.data = data;
        if(this.data.length === 0){
            this.errorinAccount='There are no Related Account for this Record.';
        }
        else
        this.AccountDataAvaialble=true;
    } else if (error) {
        this.errorinAccount = error;
     }
}
section = '';

    handleClick(event) {
        this.section = 'B';
    }

    handleSectionToggle(event) {
        this.section = event.detail.openSections;
    }
}