(:: pragma bea:global-element-return element="ns0:SessionHeader" location="../../../../External/Outgoing/BusinessServices/Salesforce/consultaCancelacionAnticipadaFinanciamiento/wsdl/consultaCancelacionAnticipadaFinanciamiento.wsdl" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_CreateCaseHelper";
declare namespace xf = "http://tempuri.org/Middleware/External/Outgoing/BusinessServices/Salesforce/consultaCancelacionAnticipadaFinanciamiento/xq/consultaCancelacionAnticipadaFinanciamientoHeaderIn/";

declare function xf:consultaCancelacionAnticipadaFinanciamientoHeaderIn($sessionId as xs:string)
    as element(ns0:SessionHeader) {
        <ns0:SessionHeader>
            <ns0:sessionId>{ $sessionId }</ns0:sessionId>
        </ns0:SessionHeader>
};

declare variable $sessionId as xs:string external;

xf:consultaCancelacionAnticipadaFinanciamientoHeaderIn($sessionId)