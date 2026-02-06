xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:SessionHeader" location="../../../BusinessServices/SALESFORCE/ActualizarSistema/wsdl/ActualizaDatosClienteSalesforce.wsdl" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/AD_Actualizar_Sistemas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaSistemas/xq/actualizaSistemasSFHead/";

declare function xf:actualizaSistemasSFHead($sessionId as xs:string)
    as element(ns0:SessionHeader) {
        <ns0:SessionHeader>
            <ns0:sessionId>{ $sessionId }</ns0:sessionId>
        </ns0:SessionHeader>
};

declare variable $sessionId as xs:string external;

xf:actualizaSistemasSFHead($sessionId)