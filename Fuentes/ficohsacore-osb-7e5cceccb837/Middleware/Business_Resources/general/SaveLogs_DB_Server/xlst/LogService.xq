(:: pragma bea:local-element-parameter parameter="$details1" type="ns0:logService/ns0:details" location="../xsd/LogService.xsd" ::)
(:: pragma bea:global-element-return element="ns0:logService" location="../xsd/LogService.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/LogService";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/general/SaveLogs_DB_Server/xlst/LogService/";

declare function xf:LogService($idServicio1 as xs:string,
    $uuid1 as xs:string,
    $endpoint1 as xs:string,
    $request1 as xs:string,
    $response1 as xs:string,
    $status1 as xs:string,
    $date1 as xs:string,
    $details1 as xs:string)
    as element(ns0:logService) {
        <ns0:logService>
            <ns0:main>
                <ns0:idServicio>{ $idServicio1 }</ns0:idServicio>
                <ns0:uuid>{ $uuid1 }</ns0:uuid>
                <ns0:endpoint>{ $endpoint1 }</ns0:endpoint>
                <ns0:request>{ $request1 }</ns0:request>
                <ns0:response>{ $response1 }</ns0:response>
                <ns0:status>{ $status1 }</ns0:status>
                <ns0:date>{ $date1 }</ns0:date>
            </ns0:main>
            <ns0:details>{ $details1 }</ns0:details>
        </ns0:logService>
};

declare variable $idServicio1 as xs:string external;
declare variable $uuid1 as xs:string external;
declare variable $endpoint1 as xs:string external;
declare variable $request1 as xs:string external;
declare variable $response1 as xs:string external;
declare variable $status1 as xs:string external;
declare variable $date1 as xs:string external;
declare variable $details1 as xs:string external;

xf:LogService($idServicio1,
    $uuid1,
    $endpoint1,
    $request1,
    $response1,
    $status1,
    $date1,
    $details1)