xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaLoteFacturas1" element="ns0:consultaLoteFacturas" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns2:OutputParameters" location="../../../BusinessServices/ABK/consultaFacturasLoteCobranza/xsd/consultaFacturasLoteCobranza_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaLoteFacturasResponse" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaFacturasLoteCobranza";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/PagingTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaLoteFacturas/xq/consultaFacturasLoteCobranzaOut/";

declare function xf:consultaFacturasLoteCobranzaOut($consultaLoteFacturas1 as element(ns0:consultaLoteFacturas),
    $outputParameters1 as element(ns2:OutputParameters))
    as element(ns0:consultaLoteFacturasResponse) {
        <ns0:consultaLoteFacturasResponse>
   
               
            <CUSTOMER_ID>{ data($consultaLoteFacturas1/CUSTOMER_ID) }</CUSTOMER_ID>
            {
                for $PV_NUMEROCONTRATO in $outputParameters1/ns2:PV_NUMEROCONTRATO
                return
                    <CONTRACT_ID>{ data($PV_NUMEROCONTRATO) }</CONTRACT_ID>
            }
            <BANK_BATCH_ID>{ data($consultaLoteFacturas1/BANK_BATCH_ID) }</BANK_BATCH_ID>            
            <BILLS_SUMMARY>
            {
             let $montosTotales := $outputParameters1/ns2:PN_MONTOSTOTALES/ns2:ITEM
             let $monedasTotales := $outputParameters1/ns2:PN_MONEDASTOTALES/ns2:ITEM   
             let $cantFacturas := $outputParameters1/ns2:PN_CANTFACTURASXMONEDA/ns2:ITEM
             for $itx in 1 to count($monedasTotales)
             return            
	            <SUMMARY>					
		            <CURRENCY>{ data($monedasTotales[$itx]) }</CURRENCY>
		            <TOTAL_AMOUNT>{ data($montosTotales[$itx]) }</TOTAL_AMOUNT>
		            <NUMBER_OF_BILLS>{ data($cantFacturas[$itx]) }</NUMBER_OF_BILLS>
		         </SUMMARY>
		 	} 
         </BILLS_SUMMARY>               
            <RECORDS_INFO>
                <INITIAL_RECORD>{ data($outputParameters1/ns2:PN_REGISTROINICIAL) }</INITIAL_RECORD>
                <RECORDS_RETURNED>{ data($outputParameters1/ns2:PN_CANTIDADREGISTROS) }</RECORDS_RETURNED>
                <RECORD_TOTAL>{ data($outputParameters1/ns2:PN_TOTALREGISTROS) }</RECORD_TOTAL>
            </RECORDS_INFO>
            <BILLS>
            	{
            		let $pn_cantidad := $outputParameters1/ns2:PN_CANTIDADREGISTROS
					let $pn_noTran := $outputParameters1/ns2:PT_NOTRAN/ns2:ITEM
					let $pt_codigodeudor := $outputParameters1/ns2:PT_CODIGODEUDOR/ns2:ITEM
					let $pt_nombredeudor := $outputParameters1/ns2:PT_NOMBREDEUDOR/ns2:ITEM
					let $pt_numdoc := $outputParameters1/ns2:PT_NUMDOC/ns2:ITEM
					let $pt_fechaemision := $outputParameters1/ns2:PT_FECHAEMISION/ns2:ITEM
					let $pt_fechavenc := $outputParameters1/ns2:PT_FECHAVENC/ns2:ITEM
					let $pt_fechapago := $outputParameters1/ns2:PT_FECHAPAGO/ns2:ITEM
					let $pt_monto := $outputParameters1/ns2:PT_MONTO/ns2:ITEM
					let $pt_moneda := $outputParameters1/ns2:PT_MONEDA/ns2:ITEM
					let $pt_mora := $outputParameters1/ns2:PT_MORA/ns2:ITEM
					let $pt_montocredito := $outputParameters1/ns2:PT_MONTOCREDITO/ns2:ITEM
					let $pt_tasacredito := $outputParameters1/ns2:PT_TASACREDITO/ns2:ITEM
					let $pt_descripcion := $outputParameters1/ns2:PT_DESCRIPCION/ns2:ITEM
					let $pt_situacion := $outputParameters1/ns2:PT_SITUACION/ns2:ITEM
					let $pt_situaciondesc := $outputParameters1/ns2:PT_SITUACIONDESC/ns2:ITEM
					for $idx in 1 to $pn_cantidad
					return
		                <BILL>
		                    <ID>{ data($pn_noTran[$idx]) }</ID>
		                    <DEBTOR_CODE>{ data($pt_codigodeudor[$idx]) }</DEBTOR_CODE>
		                    <DEBTOR_NAME>{ data($pt_nombredeudor[$idx]) }</DEBTOR_NAME>
		                    <TYPE>F</TYPE>
		                    <BILL_NUMBER>{ data($pt_numdoc[$idx]) }</BILL_NUMBER>
		                    {
		                    	if (fn:string(data($pt_fechaemision[$idx])) != "") then
		                    		<DATE_OF_ISSUE>{ fn:adjust-date-to-timezone(fn-bea:date-from-dateTime(data($pt_fechaemision[$idx])),()) }</DATE_OF_ISSUE>
		                    	else () 		                   		
		                    }
		                    {
		                    	if (fn:string(data($pt_fechavenc[$idx])) != "") then
		                    		<DUE_DATE>{ fn:adjust-date-to-timezone(fn-bea:date-from-dateTime(data($pt_fechavenc[$idx])),()) }</DUE_DATE>
		                    	else () 		                   		
		                    }
		                    {
		                    	if (fn:string(data($pt_fechapago[$idx])) != "") then
		                    		<PAYMENT_DATE>{ fn:adjust-date-to-timezone(fn-bea:date-from-dateTime(data($pt_fechapago[$idx])),()) }</PAYMENT_DATE>
		                    	else () 		                   		
		                    }
		                    <AMOUNT>{ data($pt_monto[$idx]) }</AMOUNT>
		                    <CURRENCY>{ data($pt_moneda[$idx]) }</CURRENCY>
		                    <OVERDUE_AMOUNT>{ data($pt_mora[$idx]) }</OVERDUE_AMOUNT>
		                    <CREDIT_AMOUNT>{ data($pt_montocredito[$idx]) }</CREDIT_AMOUNT>
		                    <CREDIT_RATE>{ data($pt_tasacredito[$idx]) }</CREDIT_RATE>
		                    <DESCRIPTION>{ data($pt_descripcion[$idx]) }</DESCRIPTION>
		                    <STATUS>{ data($pt_situacion[$idx]) }</STATUS>
		                    <STATUS_DESC>{ data($pt_situaciondesc[$idx]) }</STATUS_DESC>
		                </BILL>
            	}
            </BILLS>
            
        </ns0:consultaLoteFacturasResponse>
};

declare variable $consultaLoteFacturas1 as element(ns0:consultaLoteFacturas) external;
declare variable $outputParameters1 as element(ns2:OutputParameters) external;

xf:consultaFacturasLoteCobranzaOut($consultaLoteFacturas1,
    $outputParameters1)