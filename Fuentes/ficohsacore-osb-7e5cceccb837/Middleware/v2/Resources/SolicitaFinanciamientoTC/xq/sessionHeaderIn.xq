(:: pragma bea:global-element-return element="ns0:SessionHeader" location="../../../BusinessServices/External/SalesforceHNIngresaGestionExtra/wsdl/SalesforceHNIngresaGestionExtra.wsdl" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_IngresaGestionExtra";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Generales/xq/sessionHeaderIn/";

declare function xf:sessionHeaderIn($sessionId as xs:string)
    as element(ns0:SessionHeader) {
        <ns0:SessionHeader>
            <ns0:sessionId>{ $sessionId }</ns0:sessionId>
        </ns0:SessionHeader>
};

declare variable $sessionId as xs:string external;

xf:sessionHeaderIn($sessionId)