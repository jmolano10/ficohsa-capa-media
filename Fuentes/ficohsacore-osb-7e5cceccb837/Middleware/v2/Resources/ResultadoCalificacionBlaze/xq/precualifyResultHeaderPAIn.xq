(:: pragma bea:global-element-return element="ns0:SessionHeader" location="../../../BusinessServices/SALESFORCE/recepEvalCreditosPA/wsdl/WS_PAN_Blaze_Recepcion_Eval_Creditos.wsdl" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_Blaze_Recepcion_Eval_Creditos";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ResultadoCalificacionBlaze/xq/precualifyResultHeaderPAIn/";

declare function xf:precualifyResultHeaderPAIn($session as xs:string)
    as element(ns0:SessionHeader) {
        <ns0:SessionHeader>
            <ns0:sessionId>{ $session }</ns0:sessionId>
        </ns0:SessionHeader>
};

declare variable $session as xs:string external;

xf:precualifyResultHeaderPAIn($session)