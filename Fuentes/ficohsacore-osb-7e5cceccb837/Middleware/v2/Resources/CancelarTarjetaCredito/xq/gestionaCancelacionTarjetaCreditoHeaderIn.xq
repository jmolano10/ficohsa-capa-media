(:: pragma bea:global-element-return element="ns0:SessionHeader" location="../../../../External/Outgoing/BusinessServices/Salesforce/gestionaCancelacionTarjetaCredito/wsdl/gestionaCancelacionTarjetaCredito.wsdl" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_CreateCaseHelper";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarTarjetaCredito/xq/gestionaCancelacionTarjetaCreditoHeaderIn/";

declare function xf:gestionaCancelacionTarjetaCreditoHeaderIn($sessionId as xs:string)
    as element(ns0:SessionHeader) {
        <ns0:SessionHeader>
            <ns0:sessionId>{ $sessionId }</ns0:sessionId>
        </ns0:SessionHeader>
};

declare variable $sessionId as xs:string external;

xf:gestionaCancelacionTarjetaCreditoHeaderIn($sessionId)
