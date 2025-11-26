(:: pragma bea:global-element-return element="ns0:loginTeleredResponse" location="../xsd/loginTeleredTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/loginTeleredTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/LoginTelered/xq/obtenerTokenTeleredOut/";

declare function xf:obtenerTokenTeleredOut($sesionId as xs:string,
    $canal as xs:string)
    as element(ns0:loginTeleredResponse) {
        <ns0:loginTeleredResponse>
            <ns0:SESSION_ID>{ $sesionId }</ns0:SESSION_ID>
            <ns0:CHANNEL>{ $canal }</ns0:CHANNEL>
        </ns0:loginTeleredResponse>
};

declare variable $sesionId as xs:string external;
declare variable $canal as xs:string external;

xf:obtenerTokenTeleredOut($sesionId,
    $canal)