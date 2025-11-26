(:: pragma bea:local-element-return type="ns0:logService/ns0:details/ns0:detail" location="../xsd/LogService.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/LogService";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/general/SaveLogs_DB_Server/xlst/LogService_AddDetail/";

declare function xf:SaveLogsDB_AddDetail($nameEndpoint1 as xs:string,
    $endpoint1 as xs:string,
    $request1 as xs:string,
    $response1 as xs:string,
    $status1 as xs:string,
    $statusDetail1 as xs:string,
    $date1 as xs:string)
    as element() {
        <ns0:detail>
            <ns0:nameEndpoint>{ $nameEndpoint1 }</ns0:nameEndpoint>
            <ns0:endpoint>{ $endpoint1 }</ns0:endpoint>
            <ns0:request>{ $request1 }</ns0:request>
            <ns0:response>{ $response1 }</ns0:response>
            <ns0:status>{ $status1 }</ns0:status>
            <ns0:statusDetail>{ $statusDetail1 }</ns0:statusDetail>
            <ns0:date>{ $date1 }</ns0:date>
        </ns0:detail>
};

declare variable $nameEndpoint1 as xs:string external;
declare variable $endpoint1 as xs:string external;
declare variable $request1 as xs:string external;
declare variable $response1 as xs:string external;
declare variable $status1 as xs:string external;
declare variable $statusDetail1 as xs:string external;
declare variable $date1 as xs:string external;

xf:SaveLogsDB_AddDetail($nameEndpoint1,
    $endpoint1,
    $request1,
    $response1,
    $status1,
    $statusDetail1,
    $date1)