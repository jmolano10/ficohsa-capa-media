(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../xsds/ConsultaRecaudoAbanks/consultaRecaudoAbanks/v2/consultaRecaudoAbanks_v2_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaRecaudoAbanksResponse" location="../../../xsds/ConsultaRecaudoAbanks/ConsultaRecaudoAbanks.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoAbanksTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRecaudoAbanks_v2";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoAbanks/v2/ConsultaRecaudoAbanksOut_v2/";

declare function xf:ConsultaRecaudoAbanksOut_v2($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaRecaudoAbanksResponse) {
    	if (data($outputParameters1/ns0:PV_CODIGO_ERROR) = "0") then (
	        <ns1:consultaRecaudoAbanksResponse>
	           	{
	           		let $nombreDeudor := data($outputParameters1/ns0:PV_NOMBRE_DEUDOR)
	           		let $facturas := data($outputParameters1/ns0:PN_FACTURAS_PENDIENTES)
	           		return
	           		<MESSAGE_LINE_1>{ concat ($nombreDeudor," CP:",$facturas) }</MESSAGE_LINE_1>
	           	}
	           	{
	           		let $subtotal := fn-bea:format-number(data($outputParameters1/ns0:PN_MONTO_TOTAL_FACTURAS),"#,###.00")
	           		let $mora := fn-bea:format-number(data($outputParameters1/ns0:PN_MONTO_TOTAL_MORA),"#,###.00")
	           		let $total := fn-bea:format-number(data($outputParameters1/ns0:PN_MONTO_TOTAL),"#,###.00")
	           		return
	           		<MESSAGE_LINE_2>{ concat ("F:",$subtotal," M:",$mora," T:",$total) }</MESSAGE_LINE_2>
	           	}           	
	            {
	            	if (data($outputParameters1/ns0:PV_DETALLE_FACTURAS) = ("N","")) then (
	            		<RESPONSE_TYPE>0</RESPONSE_TYPE>
	            	)
	            	else (
	            		<RESPONSE_TYPE>X</RESPONSE_TYPE>
	            	)
	            }
	            <BILL_MATRIX>{ data($outputParameters1/ns0:PV_DETALLE_FACTURAS) }</BILL_MATRIX>
	        </ns1:consultaRecaudoAbanksResponse>    	
    	) else (
    		<ns1:consultaRecaudoAbanksResponse>
    			<MESSAGE_LINE_1>{ fn:substring($outputParameters1/ns0:PV_MENSAJE_ERROR/text(),1,40) }</MESSAGE_LINE_1>
    			<MESSAGE_LINE_2>{ fn:substring($outputParameters1/ns0:PV_MENSAJE_ERROR/text(),41,40) }</MESSAGE_LINE_2>
    			<RESPONSE_TYPE/>
    			<BILL_MATRIX/>
    		</ns1:consultaRecaudoAbanksResponse>
    	)
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:ConsultaRecaudoAbanksOut_v2($outputParameters1)