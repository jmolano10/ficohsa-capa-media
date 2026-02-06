xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$cargaArchivoFacturas1" element="ns1:cargaArchivoFacturas" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABK/registrarFacturaCobranzas/xsd/registrarFacturaCobranzas_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters2" element="ns2:OutputParameters" location="../../../BusinessServices/ABK/consultaFacturasLoteCobranza/xsd/consultaFacturasLoteCobranza_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:cargaArchivoFacturasResponse" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarFacturaCobranzas";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaFacturasLoteCobranza";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargaArchivoFacturas/xq/consultaFacturasLoteCobranzaOut/";

declare function xf:consultaFacturasLoteCobranzaOut($cargaArchivoFacturas1 as element(ns1:cargaArchivoFacturas),
    $outputParameters1 as element(ns0:OutputParameters),
    $outputParameters2 as element(ns2:OutputParameters)?)
    as element(ns1:cargaArchivoFacturasResponse) {
    
    <ns1:cargaArchivoFacturasResponse>
            <CUSTOMER_ID>{ data($cargaArchivoFacturas1/CUSTOMER_ID) }</CUSTOMER_ID>
            <CONTRACT_ID>{ data($cargaArchivoFacturas1/CONTRACT_ID) }</CONTRACT_ID>
            <BANK_BATCH_ID>{ data($outputParameters1/ns0:PN_NUMEROLOTE) }</BANK_BATCH_ID>
            <AUTH_ALLOWED>YES</AUTH_ALLOWED>
            {
    if (data($cargaArchivoFacturas1/BILL_DETAILS/text())  = 'YES') then (
            <BILLS>{	        		
	        		let $pn_cantidad := $outputParameters2/ns2:PN_CANTIDADREGISTROS
					let $pn_noTran := $outputParameters2/ns2:PT_NOTRAN/ns2:ITEM
					let $pt_codigodeudor := $outputParameters2/ns2:PT_CODIGODEUDOR/ns2:ITEM
					let $pt_nombredeudor := $outputParameters2/ns2:PT_NOMBREDEUDOR/ns2:ITEM
					let $pt_numdoc := $outputParameters2/ns2:PT_NUMDOC/ns2:ITEM
					let $pt_fechaemision := $outputParameters2/ns2:PT_FECHAEMISION/ns2:ITEM
					let $pt_fechavenc := $outputParameters2/ns2:PT_FECHAVENC/ns2:ITEM
					let $pt_fechapago := $outputParameters2/ns2:PT_FECHAPAGO/ns2:ITEM
					let $pt_monto := $outputParameters2/ns2:PT_MONTO/ns2:ITEM
					let $pt_moneda := $outputParameters2/ns2:PT_MONEDA/ns2:ITEM
					let $pt_mora := $outputParameters2/ns2:PT_MORA/ns2:ITEM
					let $pt_montocredito := $outputParameters2/ns2:PT_MONTOCREDITO/ns2:ITEM
					let $pt_tasacredito := $outputParameters2/ns2:PT_TASACREDITO/ns2:ITEM
					let $pt_descripcion := $outputParameters2/ns2:PT_DESCRIPCION/ns2:ITEM
					let $pt_situacion := $outputParameters2/ns2:PT_SITUACION/ns2:ITEM
					let $pt_situaciondesc := $outputParameters2/ns2:PT_SITUACIONDESC/ns2:ITEM
					for $idx in 1 to $pn_cantidad
					return
                		(<BILL>                	
                    		<ID>{ data($pt_codigodeudor[$idx]) }</ID>
                    		<DEBTOR_CODE>{ data($pt_codigodeudor[$idx]) }</DEBTOR_CODE>
							<DEBTOR_NAME>{ data($pt_nombredeudor[$idx]) }</DEBTOR_NAME>
							<TYPE></TYPE>
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
                		</BILL>)
                }
              </BILLS>
    )
    else 
    ()
    }
    </ns1:cargaArchivoFacturasResponse>
};

declare variable $cargaArchivoFacturas1 as element(ns1:cargaArchivoFacturas) external;
declare variable $outputParameters1 as element(ns0:OutputParameters) external;
declare variable $outputParameters2 as element(ns2:OutputParameters) external;

xf:consultaFacturasLoteCobranzaOut($cargaArchivoFacturas1,
    $outputParameters1,
    $outputParameters2)