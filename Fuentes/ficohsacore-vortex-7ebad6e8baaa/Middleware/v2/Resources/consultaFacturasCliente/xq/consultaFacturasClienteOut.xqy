xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns2:OutputParameters" location="../../../BusinessServices/ABK/consultaFacturasCliente/xsd/consultaFacturasCliente_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaFacturas1" element="ns0:consultaFacturas" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaFacturasResponse" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaFacturasCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/PagingTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/consultaFacturasCliente/xq/consultaFacturasClienteOut/";

declare function xf:consultaFacturasClienteOut($outputParameters1 as element(ns2:OutputParameters),
    $consultaFacturas1 as element(ns0:consultaFacturas),
    $ticketOSB as xs:string)
    as element(ns0:consultaFacturasResponse) {
        <ns0:consultaFacturasResponse>
            <CUSTOMER_ID>{ data($consultaFacturas1/CUSTOMER_ID) }</CUSTOMER_ID>
            {
                for $PV_NUMEROCONTRATO in $outputParameters1/ns2:PV_NUMEROCONTRATO
                return
                    <CONTRACT_ID>{ data($PV_NUMEROCONTRATO) }</CONTRACT_ID>
            }
            <RECORDS_INFO>
                <INITIAL_RECORD>{ data($outputParameters1/ns2:PN_REGISTROINICIAL) }</INITIAL_RECORD>
                <RECORDS_RETURNED>{ data($outputParameters1/ns2:PN_CANTIDADREGISTROS) }</RECORDS_RETURNED>
                <RECORDS_TOTAL>{ data($outputParameters1/ns2:PN_TOTALREGISTROS) }</RECORDS_TOTAL>
                <TICKET>{$ticketOSB}</TICKET>
            </RECORDS_INFO>
            <BILLS>
            	{
            		let $transaccion := $outputParameters1/ns2:PT_NOTRAN/ns2:ITEM
            		let $codigoDocumento := $outputParameters1/ns2:PT_CODIGODOC/ns2:ITEM
            		let $pn_cantidad := $outputParameters1/ns2:PN_CANTIDADREGISTROS
					let $pt_codigodeudor := $outputParameters1/ns2:PT_CODIGODEUDOR/ns2:ITEM
					let $pt_nombredeudor := $outputParameters1/ns2:PT_NOMBREDEUDOR/ns2:ITEM
					let $pt_numdoc := $outputParameters1/ns2:PT_NUMDOC/ns2:ITEM
					let $pt_fechaemision := $outputParameters1/ns2:PT_FECHAEMISION/ns2:ITEM
					let $pt_fechavenc := $outputParameters1/ns2:PT_FECHAVENC/ns2:ITEM
					let $pt_fechapago := $outputParameters1/ns2:PT_FECHAPAGO/ns2:ITEM
					let $pt_monto := $outputParameters1/ns2:PT_MONTO/ns2:ITEM
					let $pt_moneda := $outputParameters1/ns2:PT_CODIGOMONEDA/ns2:ITEM
					let $pt_mora := $outputParameters1/ns2:PT_MORA/ns2:ITEM
					let $noReferencia := $outputParameters1/ns2:PT_NOREFERENCIA/ns2:ITEM					
					let $fechaHora := $outputParameters1/ns2:PT_FECHAHORA/ns2:ITEM
					let $monedaDebito := $outputParameters1/ns2:PT_MONEDADEBITO/ns2:ITEM
					let $monedaCredito := $outputParameters1/ns2:PT_MONEDACREDITO/ns2:ITEM
					let $montoDebito := $outputParameters1/ns2:PT_MONTODEBITO/ns2:ITEM
					let $montoCredito := $outputParameters1/ns2:PT_MONTOCREDITO/ns2:ITEM
					let $tasaDebito := $outputParameters1/ns2:PT_TASADEBITO/ns2:ITEM
					let $tasaCredito := $outputParameters1/ns2:PT_TASACREDITO/ns2:ITEM
					let $pt_descripcion := $outputParameters1/ns2:PT_DESCRIPCION/ns2:ITEM
					let $agenciaOrigen := $outputParameters1/ns2:PT_AGENCIAORIGEN/ns2:ITEM
					let $nombreAgenciaOrigen := $outputParameters1/ns2:PT_NOMBREAGENCIAORIGEN/ns2:ITEM					
					let $pt_situacion := $outputParameters1/ns2:PT_SITUACION/ns2:ITEM
					let $pt_situaciondesc := $outputParameters1/ns2:PT_SITUACIONDESC/ns2:ITEM
					for $idx in 1 to $pn_cantidad
					return
		                <BILL>
		                    <ID>{ data($transaccion[$idx]) }</ID>                    
		                    <BANK_DOCUMENT_CODE>{ data($codigoDocumento[$idx]) }</BANK_DOCUMENT_CODE>
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
		                    <TXN_REFERENCE>{ data($noReferencia[$idx]) }</TXN_REFERENCE>
		                    { if (fn:string(data($fechaHora[$idx])) != "") then
		                          <TXN_DATETIME>{ fn:adjust-dateTime-to-timezone(data($fechaHora[$idx]),()) }</TXN_DATETIME>
		                      else ()		                    
		                    }
		                    { if (fn:string(data($monedaDebito[$idx])) != "") then
		                          <DEBIT_CURRENCY>{ data($monedaDebito[$idx]) }</DEBIT_CURRENCY>
		                      else ()		                    
		                    }
		                    { if (fn:string(data($monedaCredito[$idx])) != "") then
		                          <CREDIT_CURRENCY>{ data($monedaCredito[$idx])}</CREDIT_CURRENCY>
		                      else ()	
		                    }	                    
		                    { if (fn:string(data($montoDebito[$idx])) != "") then
		                         <DEBIT_AMOUNT>{ data($montoDebito[$idx]) }</DEBIT_AMOUNT>
		                      else ()
		                    }
		                    { if (fn:string(data($montoCredito[$idx])) != "") then
		                         <CREDIT_AMOUNT>{ data($montoCredito[$idx]) }</CREDIT_AMOUNT>
		                      else ()
		                    }		                    		                    
		                    <DEBIT_RATE>{ data($tasaDebito[$idx]) }</DEBIT_RATE>		                    
		                    <CREDIT_RATE>{ data($tasaCredito[$idx]) }</CREDIT_RATE>
		                    <DESCRIPTION>{ data($pt_descripcion[$idx]) }</DESCRIPTION>
		                    <BRANCH_CODE>{ data($agenciaOrigen[$idx]) }</BRANCH_CODE>
		                    <BRANCH_NAME>{ data($nombreAgenciaOrigen[$idx]) }</BRANCH_NAME>
		                    <STATUS>{ data($pt_situacion[$idx]) }</STATUS>
		                    <STATUS_DESC>{ data($pt_situaciondesc[$idx]) }</STATUS_DESC>
		                </BILL>
            	}
            </BILLS>            
        </ns0:consultaFacturasResponse>
};

declare variable $outputParameters1 as element(ns2:OutputParameters) external;
declare variable $consultaFacturas1 as element(ns0:consultaFacturas) external;
declare variable $ticketOSB as xs:string external;

xf:consultaFacturasClienteOut($outputParameters1,
    $consultaFacturas1,
    $ticketOSB)