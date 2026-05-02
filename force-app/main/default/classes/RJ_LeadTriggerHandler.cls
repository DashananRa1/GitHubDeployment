public class RJ_LeadTriggerHandler extends RJ_BaseTriggerHandler{
    protected override void beforeInsert(){
        RJ_LeadServices.beforeInsert((List<Lead>)Trigger.new);
    }

    protected override void beforeUpdate(){
        RJ_LeadServices.beforeUpdate((List<Lead>)Trigger.new, (Map<Id, Lead>)Trigger.oldMap);
    }
}