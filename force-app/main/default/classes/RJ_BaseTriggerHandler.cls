public abstract class RJ_BaseTriggerHandler {

    public void run(){
        System.debug('===== RJ_BaseTriggerHandler.run START =====');
        System.debug('Operation Type : ' + Trigger.operationType);
        if(Trigger.isBefore){
            System.debug('Entered BEFORE Context');
            if(Trigger.isInsert){
                System.debug('Calling beforeInsert()');
                beforeInsert();
            }
            if(Trigger.isUpdate){
                System.debug('Calling beforeUpdate()');
                beforeUpdate();
            }
        }
        /* if(Trigger.isAfter){
            System.debug('Entered AFTER Context');
            if(Trigger.isInsert){
                System.debug('Calling afterInsert()');
                afterInsert();
            }
            if(Trigger.isUpdate){
                System.debug('Calling afterUpdate()');
                afterUpdate();
            }
        }
         System.debug('===== RJ_BaseTriggerHandler.run END ====='); */
    }

    protected virtual void beforeInsert(){
        System.debug('Base beforeInsert() executed');
    }

    protected virtual void beforeUpdate(){
        System.debug('Base beforeUpdate() executed');
    }

    protected virtual void afterInsert(){
        System.debug('Base afterInsert() executed');
    }

    protected virtual void afterUpdate(){
        System.debug('Base afterUpdate() executed');
    }
}