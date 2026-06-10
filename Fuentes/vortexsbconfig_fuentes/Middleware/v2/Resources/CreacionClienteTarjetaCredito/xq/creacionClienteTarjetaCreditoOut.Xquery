<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opCreacionClienteRespuesta" element="ns0:OutputParameters" location="../../../BusinessServices/CTS/clientesCredito/xsd/clientesCredito_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:creacionClienteTarjetaCreditoResponse" location="../xsd/creacionClienteTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/clientesCredito";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/creacionClienteTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreacionClienteTarjetaCredito/xq/creacionClienteTarjetaCreditoOut/";


declare function xf:creacionClienteTarjetaCreditoOut($opCreacionClienteRespuesta as element(ns0:OutputParameters))
    as element(ns1:creacionClienteTarjetaCreditoResponse) {
        &lt;ns1:creacionClienteTarjetaCreditoResponse>
                   &lt;CUSTOMER_ID>{ xs:int($opCreacionClienteRespuesta/ns0:o_cliente) }&lt;/CUSTOMER_ID>          
        &lt;/ns1:creacionClienteTarjetaCreditoResponse>
};

declare variable $opCreacionClienteRespuesta as element(ns0:OutputParameters) external;

xf:creacionClienteTarjetaCreditoOut($opCreacionClienteRespuesta)</con:xquery>
    <con:dependency location="../../../BusinessServices/CTS/clientesCredito/xsd/clientesCredito_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CTS/clientesCredito/xsd/clientesCredito_sp"/>
    </con:dependency>
    <con:dependency location="../xsd/creacionClienteTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/CreacionClienteTarjetaCredito/xsd/creacionClienteTarjetaCreditoTypes"/>
    </con:dependency>
</con:xqueryEntry>