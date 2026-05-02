trigger RJ_LeadTrigger on Lead (before insert, before update) {
    System.debug('===== RJ_LeadTrigger START =====');
    System.debug('Trigger Operation : ' + Trigger.operationType);
    System.debug('Is Before : ' + Trigger.isBefore);
    System.debug('Is Insert : ' + Trigger.isInsert);
    System.debug('Is Update : ' + Trigger.isUpdate);
    System.debug('Record Count : ' + Trigger.new.size());
    new RJ_LeadTriggerHandler().run();
    System.debug('===== RJ_LeadTrigger END =====');
}