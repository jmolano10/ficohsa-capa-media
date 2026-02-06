xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaMultipleProductosHN1" element="ns1:sjConsultaMultipleProductosHN" location="../xsd/sjConsultaMultipleProductosHN.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../ABK/consultaLineasCreditoCliente/xsd/consultaLineasCreditoCliente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaLineasCreditoCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosHN";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosHN/xq/sjConsultaLineasCreditoClienteIn/";

declare function xf:sjConsultaLineasCreditoClienteIn($ID as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        {
            <ns0:P_CRED_LINE_ID>{ $ID }</ns0:P_CRED_LINE_ID>
        }
        </ns0:InputParameters>
};

declare variable $ID as xs:string external;

xf:sjConsultaLineasCreditoClienteIn($ID)