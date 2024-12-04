public with sharing class TraceFlagManager implements Queueable ,Database.AllowsCallouts  {


    String userId;
    String debugLevelName;
    Integer durationInMinutes;

    static String userToDebugName='test';

    public TraceFlagManager(String userId,String debugLevelName,Integer durationInMinutes){
        this.userId = userId;
        this.debugLevelName = debugLevelName;
        this.durationInMinutes = durationInMinutes;
    }

    public void execute(QueueableContext context) {
        createTFWithDebugLevelName(userId,debugLevelName,durationInMinutes);    
    }


    public static void createTFWithDebugLevelName(String userId,String debugLevelName,Integer durationInMiNutes){

        String debugLevelId = (String) ToolingApiUtil.execSoql('SELECT Id  FROM DebugLevel  WHERE DeveloperName = \''+debugLevelName+'\'',false)[0].get('Id');
        createTF(userId,debugLevelId,durationInMiNutes);
        if(!Test.isRunningTest()){
            userToDebugName =[Select Name  FROM User WHERE Id = :userId][0].Name;
        }
        sendMail();
    }


    public static void createTF(String userId,String debugLevelId,Integer durationInMiNutes){

        deleteExistingTf(userId);

        Map<String,Object> traceFlag = new Map<String,Object>();
        traceFlag.put('StartDate',DateTime.now());
        traceFlag.put('ExpirationDate',DateTime.now().addMinutes(durationInMiNutes));
        traceFlag.put('TracedEntityId',userId);
        traceFlag.put('DebugLevelId',debugLevelId);
        traceFlag.put('LogType','USER_DEBUG');
        ToolingApiUtil.createObject('TraceFlag',traceFlag);
    }


    public static void deleteExistingTf(String userId){
        for(Map<String, Object> traceFlag : ToolingApiUtil.execSoql('SELECT Id FROM TraceFlag WHERE TracedEntityId = \''+userId+'\'',false)){
            ToolingApiUtil.deleteObject('TraceFlag',(String)traceFlag.get('Id'));
        }
    }
    


    private static void sendMail() {
        String jobId;
        if(!Test.isRunningTest()){
            jobId =[SELECT Id FROM AsyncApexJob WHERE JobType  ='ScheduledApex' AND status='Queued'  AND ApexClass.Name='TraceFlagManagerScheduler' ORDER BY CronTrigger.StartTime desc LIMIT 1][0].Id;
        }
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {UserInfo.getUserEmail()});
        mail.setSubject('TraceFlag Creation executed');
        String body ='Your request to trace again the user '+userToDebugName+' has been executed.'+'\n';
        body+='To stop daily creation , execute the following apex command : \n';
        body+='******\n';
        body+='\n';
        body+='System.abortJob(\''+jobId+'\')\n';
        body+='\n';
        body+='******\n';
        body+='Ignore this message if you still want to monitor the user tomorrow \n';
        mail.setPlainTextBody(body);
         Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }

}