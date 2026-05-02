/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class RJ_LeadServices_Test {
    @isTest
    static void testBeforeInsert_DefaultLeadSource(){
        Lead ld = RJ_TestDataFactory.createLead(
            'Boss',
            'ABC Pvt Ltd',
            'Open - Not Contacted',
            null,
            'boss@test.com',
            false
        );

        Test.startTest();
        insert ld;
        Test.stopTest();

        Lead result = [
            SELECT Id, LeadSource
            FROM Lead
            WHERE Id = :ld.Id
        ];

        System.assertEquals(
            'Web',
            result.LeadSource
        );
    }

    @isTest
    static void testBeforeInsert_ExistingLeadSource(){

        Lead ld = RJ_TestDataFactory.createLead(
            'Existing Source',
            'ABC Pvt Ltd',
            'Open - Not Contacted',
            'Partner Referral',
            'partner@test.com',
            false
        );

        Test.startTest();
        insert ld;
        Test.stopTest();

        Lead result = [
            SELECT Id, LeadSource
            FROM Lead
            WHERE Id = :ld.Id
        ];

        System.assertEquals(
            'Partner Referral',
            result.LeadSource
        );
    }

    @isTest
    static void testBeforeInsert_BulkLeads(){

        List<Lead> leadList =
            RJ_TestDataFactory.createLeadList(
                5,
                'Open - Not Contacted',
                false
            );

        Test.startTest();
        insert leadList;
        Test.stopTest();

        List<Lead> results = [
            SELECT Id, LeadSource
            FROM Lead
            WHERE Id IN :leadList
        ];

        for(Lead ld : results){

            System.assertEquals(
                'Web',
                ld.LeadSource
            );
        }
    }

    @isTest
    static void testBeforeUpdate_StatusChangedToWorkingContacted(){

        Lead ld = RJ_TestDataFactory.createLead(
            'Update Test',
            'XYZ Pvt Ltd',
            'Open - Not Contacted',
            'Web',
            'update@test.com',
            true
        );

        ld.Status = 'Working - Contacted';

        Test.startTest();
        update ld;
        Test.stopTest();

        Lead result = [
            SELECT Id, Status, Rating
            FROM Lead
            WHERE Id = :ld.Id
        ];

        System.assertEquals(
            'Working - Contacted',
            result.Status
        );

        System.assertEquals(
            'Hot',
            result.Rating
        );
    }

    @isTest
    static void testBeforeUpdate_StatusAlreadyWorkingContacted(){

        Lead ld = RJ_TestDataFactory.createLead(
            'No Change',
            'PQR Pvt Ltd',
            'Working - Contacted',
            'Web',
            'nochange@test.com',
            true
        );

        ld.Company = 'Updated Company';

        Test.startTest();
        update ld;
        Test.stopTest();

        Lead result = [
            SELECT Id, Rating
            FROM Lead
            WHERE Id = :ld.Id
        ];

        System.assertEquals(
            null,
            result.Rating
        );
    }

    @isTest
    static void testBeforeUpdate_BulkStatusChange(){

        List<Lead> leadList =
            RJ_TestDataFactory.createLeadList(
                5,
                'Open - Not Contacted',
                true
            );

        for(Lead ld : leadList){
            ld.Status = 'Working - Contacted';
        }

        Test.startTest();
        update leadList;
        Test.stopTest();

        List<Lead> results = [
            SELECT Id, Rating
            FROM Lead
            WHERE Id IN :leadList
        ];

        for(Lead ld : results){

            System.assertEquals(
                'Hot',
                ld.Rating
            );
        }
    }
}