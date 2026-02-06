xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/ActualizaDatosGFF/ConfirmacionActualizarSistema/xsd/confirmacionActualizarSistema_sp.xsd" ::)


declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/confirmacionActualizarSistema";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaSistemas/xq/confirmacionActualizarSistemaIn/";

declare function xf:confirmacionActualizarSistemaIn($uuid as xs:string,
    $customerId as xs:string,  $targetSystem as xs:string,  $targetCountry as xs:string, $targetMessageCode as xs:string, $targetMessage as xs:string)
    as element(ns2:InputParameters) {
        <ns2:InputParameters>  
                            <ns2:P_UUID>{ data($uuid) }</ns2:P_UUID>
                               <ns2:P_CUSTOMER_ID>{ fn:replace(data($customerId),"#KEPT","") }</ns2:P_CUSTOMER_ID>
                               <ns2:P_TARGET_SYSTEM>{ data($targetSystem) }</ns2:P_TARGET_SYSTEM>
                               <ns2:P_TARGET_COUNTRY>{ $targetCountry }</ns2:P_TARGET_COUNTRY>
                               <ns2:P_TARGET_MESSAGE_CODE>{ data($targetMessageCode) }</ns2:P_TARGET_MESSAGE_CODE>
                               <ns2:P_TARGET_MESSAGE>{ data($targetMessage) }</ns2:P_TARGET_MESSAGE>
        </ns2:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $customerId as xs:string external;
declare variable $targetSystem as xs:string external;
declare variable $targetCountry as xs:string external;
declare variable $targetMessageCode as xs:string external;
declare variable $targetMessage as xs:string external;

xf:confirmacionActualizarSistemaIn($uuid,
    $customerId, $targetSystem, $targetCountry, $targetMessageCode, $targetMessage)