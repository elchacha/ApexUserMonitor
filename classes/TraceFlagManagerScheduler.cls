global class TraceFlagManagerScheduler implements Schedulable {

    /*
        TraceFlagManagerScheduler cronJob = new TraceFlagManagerScheduler(userId, debugLevelName);
        System.schedule('Tracing user XXXXXX', cronExp, cronJob);
    */

    String userId;
    String debugLevelName;

    global TraceFlagManagerScheduler(String userId,String debugLevelName){
        this.userId = userId;
        this.debugLevelName = debugLevelName;
    }

    global void execute(SchedulableContext SC) {
        System.enqueueJob(new TraceFlagManager(userId,debugLevelName,24*60-1));
     }

}