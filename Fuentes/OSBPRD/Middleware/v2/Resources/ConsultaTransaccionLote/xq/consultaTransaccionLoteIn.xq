(:: pragma bea:global-element-parameter parameter="$consultaTransaccionLote" element="ns1:consultaTransaccionLote" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/PMSV/consultaTransaccionLote/xsd/consultaTransaccionLote_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTransaccionLote";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTransaccionLote/xq/consultaTransaccionLoteIn/";

declare function xf:consultaTransaccionLoteIn($consultaTransaccionLote as element(ns1:consultaTransaccionLote))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CUSTOMER_ID>{ data($consultaTransaccionLote/CUSTOMER_ID) }</ns0:CUSTOMER_ID>
            <ns0:TXN_REFERENCE>{ data($consultaTransaccionLote/TXN_REFERENCE) }</ns0:TXN_REFERENCE>
        </ns0:InputParameters>
};

declare variable $consultaTransaccionLote as element(ns1:consultaTransaccionLote) external;

xf:consultaTransaccionLoteIn($consultaTransaccionLote)