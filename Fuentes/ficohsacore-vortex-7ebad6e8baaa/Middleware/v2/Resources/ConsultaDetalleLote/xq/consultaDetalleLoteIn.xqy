xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleLote" element="ns1:consultaDetalleLote" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/PMSV/consultaDetalleLote/xsd/consultaDetalleLote_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalleLote";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/PagingTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleLote/xq/consultaDetalleLoteIn/";

declare function xf:consultaDetalleLoteIn($consultaDetalleLote as element(ns1:consultaDetalleLote))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CUSTOMER_ID>{ data($consultaDetalleLote/CUSTOMER_ID) }</ns0:CUSTOMER_ID>
            <ns0:QUERY_TYPE>{ data($consultaDetalleLote/QUERY_TYPE) }</ns0:QUERY_TYPE>
            <ns0:QUERY_VALUE>{ data($consultaDetalleLote/QUERY_VALUE) }</ns0:QUERY_VALUE>
            <ns0:TRANSACTION_FILTER>
                {
                    for $FIELD in $consultaDetalleLote/TRANSACTION_FILTERS/FILTER
                    return
                        <ns0:ITEM>{ data($FIELD/FIELD/text()) }</ns0:ITEM>
                }
            </ns0:TRANSACTION_FILTER>
            
            <ns0:TRANSACTION_FILTER_VALUE>
                {
                    for $VALUE in $consultaDetalleLote/TRANSACTION_FILTERS/FILTER
                    return
                        <ns0:ITEM>{ data($VALUE/VALUE/text()) }</ns0:ITEM>
                }
            </ns0:TRANSACTION_FILTER_VALUE>
            {
            	if(data($consultaDetalleLote/PAGING_INFO/PAGING) = "YES")then
            	(
            		<ns0:INITIAL_RECORD>{ data($consultaDetalleLote/PAGING_INFO/INITIAL_RECORD) }</ns0:INITIAL_RECORD>,
            		<ns0:RECORDS_RETURNED>{ data($consultaDetalleLote/PAGING_INFO/RECORD_COUNT) }</ns0:RECORDS_RETURNED>
            	)
            	else
            	(
            		<ns0:INITIAL_RECORD></ns0:INITIAL_RECORD>,
            		<ns0:RECORDS_RETURNED></ns0:RECORDS_RETURNED>
            	)
            }
        </ns0:InputParameters>
};

declare variable $consultaDetalleLote as element(ns1:consultaDetalleLote) external;

xf:consultaDetalleLoteIn($consultaDetalleLote)