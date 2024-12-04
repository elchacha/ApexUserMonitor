@isTest
private with sharing class ToolingApiUtilTest {

    @isTest
    private static void testcreateObject(){
        Test.setMock(HttpCalloutMock.class, new ToolingApiMockResponse());
        ToolingApiUtil.createObject('TraceFlag',null);
    }


    @isTest
    private static void updateObject(){
        Test.setMock(HttpCalloutMock.class, new ToolingApiMockResponse());
        ToolingApiUtil.updateObject('TraceFlag',null,'12345');
    }

    @isTest
    private static void deleteObject(){
        Test.setMock(HttpCalloutMock.class, new ToolingApiMockResponse());
        ToolingApiUtil.deleteObject('TraceFlag','12345');
    }


    @isTest
    private static void testExecSoql(){
        Test.setMock(HttpCalloutMock.class, new ToolingApiMockResponse());
        ToolingApiUtil.execSoql('Select Id FROM Traceflad');
    }

}