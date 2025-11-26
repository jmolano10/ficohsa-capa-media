(:: pragma bea:global-element-parameter parameter="$opCreacionClienteRespuesta" element="ns0:OutputParameters" location="../../../BusinessServices/CTS/clientesCredito/xsd/clientesCredito_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:creacionClienteTarjetaCreditoResponse" location="../xsd/creacionClienteTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/clientesCredito";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/creacionClienteTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreacionClienteTarjetaCredito/xq/creacionClienteTarjetaCreditoOut/";


declare function xf:creacionClienteTarjetaCreditoOut($opCreacionClienteRespuesta as element(ns0:OutputParameters))
    as element(ns1:creacionClienteTarjetaCreditoResponse) {
        <ns1:creacionClienteTarjetaCreditoResponse>
                   <CUSTOMER_ID>{ xs:int($opCreacionClienteRespuesta/ns0:o_cliente) }</CUSTOMER_ID>          
        </ns1:creacionClienteTarjetaCreditoResponse>
};

declare variable $opCreacionClienteRespuesta as element(ns0:OutputParameters) external;

xf:creacionClienteTarjetaCreditoOut($opCreacionClienteRespuesta)