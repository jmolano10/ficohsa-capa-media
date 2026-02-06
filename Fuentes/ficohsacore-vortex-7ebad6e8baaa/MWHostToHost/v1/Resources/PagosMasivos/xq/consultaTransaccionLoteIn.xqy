xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTransaccionLote" element="ns0:consultaTransaccionLote" location="../xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTransaccionLote" location="../../../../../Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/PagosMasivos/xq/consultaTransaccionLoteIn/";

declare function xf:consultaTransaccionLoteIn($consultaTransaccionLote as element(ns0:consultaTransaccionLote))
    as element(ns0:consultaTransaccionLote) {
        <ns0:consultaTransaccionLote>
            <CUSTOMER_ID>{ data($consultaTransaccionLote/CUSTOMER_ID) }</CUSTOMER_ID>
            <TXN_REFERENCE>{ data($consultaTransaccionLote/TXN_REFERENCE) }</TXN_REFERENCE>
        </ns0:consultaTransaccionLote>
};

declare variable $consultaTransaccionLote as element(ns0:consultaTransaccionLote) external;

xf:consultaTransaccionLoteIn($consultaTransaccionLote)