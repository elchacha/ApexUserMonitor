@isTest
global with sharing class ToolingApiMockResponse implements HttpCalloutMock {

    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        if(req.getEndpoint().contains('/tooling/sobjects')){
            return res;
        }else if(req.getEndpoint().contains('/tooling/query')){
            res.setBody('{"size":1,"totalSize":1,"done":true,"queryLocator":null,"entityTypeName":"TraceFlag","records":[{"attributes":{"type":"TraceFlag","url":"/services/data/v61.0/tooling/sobjects/TraceFlag/7tfQJ000000rBN7YAM"},"Id":"7tfQJ000000rBN7YAM"}]}');
            return res;
        }else if(req.getEndpoint().contains('/tooling/executeAnonymous')){
            return res;
        }else{
            throw new ToolingApiException('unexpected endPoint');
        }

    }


    global class ToolingApiException extends Exception{
    }
}