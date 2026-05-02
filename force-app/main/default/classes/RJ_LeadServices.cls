public class RJ_LeadServices {
    public static void beforeInsert(List<Lead> newLeads) { 
        System.debug('===== RJ_LeadServices.beforeInsert START =====');
        System.debug('Total Leads Received : ' + newLeads.size());

        for(Lead ld : newLeads){
             System.debug('Processing Lead Before Insert -> Name: ' + ld.Name +
                         ' | LeadSource: ' + ld.LeadSource +
                         ' | Email: ' + ld.Email);
            if(String.isBlank(ld.LeadSource)){
                 System.debug('LeadSource is blank. Setting default value = Web');
                ld.LeadSource ='Web';
            }
            System.debug('Lead Final LeadSource Value : ' + ld.LeadSource);
        }
         System.debug('===== RJ_LeadServices.beforeInsert END =====');
    }
    public static void beforeUpdate(List<Lead> newLeads, Map<Id,Lead> oldMap){
        System.debug('===== RJ_LeadServices.beforeUpdate START =====');
        System.debug('Total Leads Received : ' + newLeads.size());

        for(Lead ld:newLeads){
            Lead oldLead = oldMap.get(ld.Id);
            System.debug('Processing Lead Update -> Id: ' + ld.Id);
            System.debug('Old Status : ' + oldLead.Status);
            System.debug('New Status : ' + ld.Status);
            System.debug('Old Rating : ' + oldLead.Rating);
            System.debug('New Rating : ' + ld.Rating);
            if(oldLead.Status!= 'Working - Contacted' && ld.Status == 'Working - Contacted'){
                System.debug('Status changed to Working - Contacted. Setting Rating = Hot');
                ld.Rating= 'Hot';
            }
            System.debug('Final Rating After Logic : ' + ld.Rating);
        }
    }
}