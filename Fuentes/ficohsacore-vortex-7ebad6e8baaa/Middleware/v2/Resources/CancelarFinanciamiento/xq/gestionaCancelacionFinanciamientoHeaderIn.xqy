xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:SessionHeader" location="../../../../External/Outgoing/BusinessServices/Salesforce/gestionaCancelacionFinanciamiento/wsdl/gestionaCancelacionFinanciamiento.wsdl" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_CreateCaseHelper";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarFinanciamiento/xq/gestionaCancelacionFinanciamientoHeaderIn/";

declare function xf:gestionaCancelacionFinanciamientoHeaderIn($sessionId as xs:string)
    as element(ns0:SessionHeader) {
        <ns0:SessionHeader>
            <ns0:sessionId>{ $sessionId }</ns0:sessionId>
        </ns0:SessionHeader>
};

declare variable $sessionId as xs:string external;

xf:gestionaCancelacionFinanciamientoHeaderIn($sessionId)