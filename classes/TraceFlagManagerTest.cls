@isTest
private  class TraceFlagManagerTest {

    @isTest
    private static void TestCreateTraceFlag(){
        Test.setMock(HttpCalloutMock.class, new ToolingApiMockResponse());

        Test.startTest();
        new TraceFlagManager('','',12).execute(null);
        Test.stopTest();
    }


    @isTest
    private static void TestScheduleCreateTraceFlag(){
        Test.setMock(HttpCalloutMock.class, new ToolingApiMockResponse());
        TraceFlagManagerScheduler cronJob = new TraceFlagManagerScheduler(UserInfo.getUserId(), 'SFDC_DevConsole');

        Test.startTest();
        System.schedule('Tracing user Chacha', '0 0 * ? * *', cronJob);
        Test.stopTest();
    }


}