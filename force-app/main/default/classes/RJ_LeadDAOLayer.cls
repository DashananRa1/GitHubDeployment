public class RJ_LeadDAOLayer extends RJ_BaseDAOLayer{

    protected override String getSObjectName() {
        System.debug('===== RJ_LeadDAOLayer.getSObjectName =====');
        System.debug('Returning Object Name = Lead');
        return 'Lead';
    }
    public List<Lead> getLeadsByEmail(Set<String> emails){
        System.debug('===== RJ_LeadDAOLayer.getLeadsByEmail START =====');
        System.debug('Emails Received : ' + emails);
        System.debug('Email Count : ' + emails.size());
        string soql = 'SELECT Id, Name, Email, Status, Company FROM Lead WHERE Email IN :emails WITH SECURITY_ENFORCED';
        System.debug('Generated SOQL : ' + soql);
        System.debug('Calling executeQuery with cache key = ByEmail');
        List<Lead> result =
            (List<Lead>)executeQuery(soql, 'ByEmail', false);
        System.debug('Returned Lead Count : ' + result.size());
        System.debug('===== RJ_LeadDAOLayer.getLeadsByEmail END =====');

        return result;
    }
}
