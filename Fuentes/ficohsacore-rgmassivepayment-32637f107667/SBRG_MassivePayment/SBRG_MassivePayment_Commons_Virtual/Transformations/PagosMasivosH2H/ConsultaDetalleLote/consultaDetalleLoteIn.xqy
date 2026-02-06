xquery version "1.0" encoding "utf-8";

(:: pragma bea:global-element-parameter parameter="$consultaDetalleLote" element="ns0:consultaDetalleLote" location="../../../Schemas/PagosMasivosH2H/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetalleLote" location="../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/PagingTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/PagosMasivos/xq/consultaDetalleLoteIn/";

declare function xf:consultaDetalleLoteIn($consultaDetalleLote as element(ns0:consultaDetalleLote))
    as element(ns0:consultaDetalleLote) {
        <ns0:consultaDetalleLote>
            <CUSTOMER_ID>{ data($consultaDetalleLote/CUSTOMER_ID) }</CUSTOMER_ID>
            <QUERY_TYPE>{ data($consultaDetalleLote/QUERY_TYPE) }</QUERY_TYPE>
            <QUERY_VALUE>{ data($consultaDetalleLote/QUERY_VALUE) }</QUERY_VALUE>
            <PAGING_INFO>
                <PAGING>YES</PAGING>
                <INITIAL_RECORD>1</INITIAL_RECORD>
                <RECORD_COUNT>999999</RECORD_COUNT>
            </PAGING_INFO>
        </ns0:consultaDetalleLote>
};

declare variable $consultaDetalleLote as element(ns0:consultaDetalleLote) external;

xf:consultaDetalleLoteIn($consultaDetalleLote)