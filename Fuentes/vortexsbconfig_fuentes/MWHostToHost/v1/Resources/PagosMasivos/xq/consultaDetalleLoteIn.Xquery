<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleLote" element="ns0:consultaDetalleLote" location="../xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetalleLote" location="../../../../../Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

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
                <PAGING>NO</PAGING>
            </PAGING_INFO>            
        </ns0:consultaDetalleLote>
};

declare variable $consultaDetalleLote as element(ns0:consultaDetalleLote) external;

xf:consultaDetalleLoteIn($consultaDetalleLote)]]></con:xquery>
    <con:dependency location="../xsd/pagosMasivosTypes.xsd">
        <con:schema ref="MWHostToHost/v1/Resources/PagosMasivos/xsd/pagosMasivosTypes"/>
    </con:dependency>
    <con:dependency location="../../../../../Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes"/>
    </con:dependency>
</con:xqueryEntry>