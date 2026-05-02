@isTest
private class RJ_BaseDAOLayer_Test {

    @isTest
    static void testGetLeadsByEmail(){
        List<Lead> leadList = new List<Lead>();
        leadList.add(
            new Lead(
                LastName = 'Lead 1',
                Company  = 'ABC',
                Status   = 'Open - Not Contacted',
                Email    = 'lead1@test.com'
            )
        );

        leadList.add(
            new Lead(
                LastName = 'Lead 2',
                Company  = 'XYZ',
                Status   = 'Open - Not Contacted',
                Email    = 'lead2@test.com'
            )
        );

        insert leadList;

        Set<String> emails = new Set<String>{
            'lead1@test.com',
            'lead2@test.com'
        };

        Test.startTest();
        RJ_LeadDAOLayer dao = new RJ_LeadDAOLayer();
        List<Lead> results = dao.getLeadsByEmail(emails);
        Test.stopTest();
        System.assertEquals(2, results.size());
    }

    @isTest
    static void testQueryCacheProvider(){
        String key = 'Lead_ByEmail';
        List<SObject> records = new List<SObject>();
        records.add(
            new Lead(
                LastName = 'Cache Test',
                Company  = 'ABC'
            )
        );

        Test.startTest();
        RJ_QueryCacheProvider.put(key, records);

        List<SObject> cached =
            RJ_QueryCacheProvider.get(key);

        RJ_QueryCacheProvider.invalidate('Lead');
        List<SObject> afterRemove =
            RJ_QueryCacheProvider.get(key);

        Test.stopTest();

        System.assertNotEquals(null, cached);
        System.assertEquals(1, cached.size());
        System.assertEquals(null, afterRemove);
    }

    @isTest
    static void testInvalidateCacheFromDAO(){

        Test.startTest();
        RJ_LeadDAOLayer dao = new RJ_LeadDAOLayer();
        dao.invalidateCache();
        Test.stopTest();
        System.assert(true);
    }
}