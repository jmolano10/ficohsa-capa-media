(:: pragma bea:global-element-parameter parameter="$consultaReciboTransaccionRTE" element="ns0:consultaReciboTransaccionRTE" location="../../xsds/ConsultaReciboTransaccionRTE/ConsultaReciboTransaccionRTE.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../xsds/ConsultaReciboTransaccionRTE/ConsultarReciboTrxRTE/INTERPRETADOR_OSB_CONSULTAR_FILLER4_RTE.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/INTERPRETADOR/OSB_CONSULTAR_FILLER4_RTE/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaReciboTransaccionRTETypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaReciboTransaccionRTE/ConsultarReciboTrxRTEIn/";

declare function xf:ConsultarReciboTrxRTEIn($consultaReciboTransaccionRTE as element(ns0:consultaReciboTransaccionRTE))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:TRX_ID>{ data($consultaReciboTransaccionRTE/TRANSACTION_ID) }</ns1:TRX_ID>
        </ns1:InputParameters>
};

declare variable $consultaReciboTransaccionRTE as element(ns0:consultaReciboTransaccionRTE) external;

xf:ConsultarReciboTrxRTEIn($consultaReciboTransaccionRTE)