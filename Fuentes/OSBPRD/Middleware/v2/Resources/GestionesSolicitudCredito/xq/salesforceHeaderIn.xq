(:: pragma bea:global-element-return element="ns0:SessionHeader" location="../../../BusinessServices/SALESFORCE/recepEvalCreditos/wsdl/WS_NIC_Recepcion_Eval_Creditos.wsdl" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_NIC_Recepcion_Eval_Creditos";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GestionesSolicitudCredito/xq/salesforceHeaderIn/";

declare function xf:salesforceHeaderIn($sessionId as xs:string)
    as element(ns0:SessionHeader) {
        <ns0:SessionHeader>
            <ns0:sessionId>{ $sessionId }</ns0:sessionId>
        </ns0:SessionHeader>
};

declare variable $sessionId as xs:string external;

xf:salesforceHeaderIn($sessionId)