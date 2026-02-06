xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:SessionHeader" location="../../../BusinessServices/SALESFORCE/actualizaSistemaRG/wsdl/actualizaSalesforceRG.wsdl" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_Actualizacion_Datos";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaSistemas/xq/actualizarDatosHead/";

declare function xf:actualizarDatosHead($sessionId as xs:string)
    as element(ns0:SessionHeader) {
        <ns0:SessionHeader>
            <ns0:sessionId>{ data($sessionId) }</ns0:sessionId>
        </ns0:SessionHeader>
};

declare variable $sessionId as xs:string external;

xf:actualizarDatosHead($sessionId)