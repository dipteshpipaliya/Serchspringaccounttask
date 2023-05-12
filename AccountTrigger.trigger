trigger AccountTrigger on Account (before insert,after insert, before update, after update) {
	AccountHelper.triggerHelper(Trigger.operationType , Trigger.new , Trigger.oldMap);
}