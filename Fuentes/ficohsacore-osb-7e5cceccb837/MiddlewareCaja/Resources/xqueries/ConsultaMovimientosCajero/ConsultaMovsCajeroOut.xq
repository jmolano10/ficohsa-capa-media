(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../xsds/ConsultaMovimientosCajero/ConsultaMovimientosCajero_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaMovsCajeroResponse" location="../../xsds/ConsultaMovimientosCajero/ConsultaMovsCajero.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaMovimientosCajero";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ConsultaMovsCajeroTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaMovimientosCajero/ConsultaMovsCajeroOut/";

declare function xf:ConsultaMovsCajeroOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ConsultaMovsCajeroResponse) {
        <ns0:ConsultaMovsCajeroResponse>
            <ns0:ConsultaMovsCajeroResponseType>
            	{
            		for $i in 1 to fn:count($outputParameters1/ns1:PV_TRXID/ns1:PV_TRXID_ITEM)
            		return
            			<ns0:ConsultaMovsCajeroResponseRecordType>
            				<TRANSACTION_ID>{ data($outputParameters1/ns1:PV_TRXID/ns1:PV_TRXID_ITEM[$i]) }</TRANSACTION_ID>
            				<DESCRIPTION>{ data($outputParameters1/ns1:PV_DESCRIPCION/ns1:PV_TRXID_ITEM[$i]) }</DESCRIPTION>
            				<AMOUNT>{ data($outputParameters1/ns1:PV_MONTO/ns1:PV_MONTO_ITEM[$i]) }</AMOUNT>
            				<CURRENCY>{ data($outputParameters1/ns1:PV_MONEDA/ns1:PV_TRXID_ITEM[$i]) }</CURRENCY>
            				<CORE_DATE>{ data($outputParameters1/ns1:PV_FECHACORE/ns1:PV_TRXID_ITEM[$i]) }</CORE_DATE>
            				<CALENDAR_DATE>{ data($outputParameters1/ns1:PN_FECHACALENDARIO/ns1:PV_TRXID_ITEM[$i]) }</CALENDAR_DATE>
            				<CALENDAR_TIME>{ data($outputParameters1/ns1:PV_HORA/ns1:PV_TRXID_ITEM[$i]) }</CALENDAR_TIME>
            			</ns0:ConsultaMovsCajeroResponseRecordType>
            	}
            </ns0:ConsultaMovsCajeroResponseType>
        </ns0:ConsultaMovsCajeroResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:ConsultaMovsCajeroOut($outputParameters1)