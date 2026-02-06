xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/validaCliente/xsd/validaCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validaURLClienteResponse" location="../../ValidaURLCliente/xsd/validaURLClienteTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validaURLClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaURLClienteRG/xq/validaURLClienteRGOut/";

declare function xf:validaURLClienteRGOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:validaURLClienteResponse) {
        <ns1:validaURLClienteResponse>
            {
              if(string($outputParameters/ns0:PN_CODIGO_CLIENTE/text())!="")then (
                   <CUSTOMER_ID>{ data($outputParameters/ns0:PN_CODIGO_CLIENTE) }</CUSTOMER_ID>
                )else()
            }
            {
              if(string($outputParameters/ns0:PV_NUM_TELEFONO)!="")then (
                   <PHONE_NUMBER>{ data($outputParameters/ns0:PV_NUM_TELEFONO) }</PHONE_NUMBER>
                )else()
            }
            {
              if(string($outputParameters/ns0:PV_TOKEN)!="")then (
                    <TOKEN_NUMBER>{ data($outputParameters/ns0:PV_TOKEN) }</TOKEN_NUMBER>
                )else()
            }
        </ns1:validaURLClienteResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:validaURLClienteRGOut($outputParameters)