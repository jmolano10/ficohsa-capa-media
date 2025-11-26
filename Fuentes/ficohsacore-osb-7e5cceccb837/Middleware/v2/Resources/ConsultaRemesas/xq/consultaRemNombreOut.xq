xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ConsultarRemPorNombre/xsd/consultarRemPorNombre_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaRemesasResponse" location="../xsd/consultaRemesasTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/consultaRemNombreOut/";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRemPorNombre";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";

declare function xf:consultaRemNombreOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaRemesasResponse) {
            	if (fn:string($outputParameters1/ns1:PN_ERROR/text()) = "0") then (
	        <ns0:consultaRemesasResponse>
	            <ns0:consultaRemesasResponseType>
	            {
	            	let $CLAVE := $outputParameters1/ns1:PV_CLAVE/ns1:PV_CLAVE_ITEM
	            	let $REMITENTE := $outputParameters1/ns1:PV_REMITENTE/ns1:PV_CLAVE_ITEM
	            	let $BENEFICIARIO := $outputParameters1/ns1:PV_BENEFICIARIO/ns1:PV_CLAVE_ITEM
	            	let $ESTADO := $outputParameters1/ns1:PV_ESTADO/ns1:PV_CLAVE_ITEM
	            	let $AMOUNT := $outputParameters1/ns1:PV_VALOR/ns1:PV_VALOR_ITEM
	            	let $REMITERID := $outputParameters1/ns1:PV_CODREMESADORA/ns1:PV_CLAVE_ITEM
	            	let $CURRENCY := $outputParameters1/ns1:PV_MONEDA/ns1:PV_CLAVE_ITEM
	            	let $PAYMENTBRANCH := $outputParameters1/ns1:PV_AGENCIAPAGO/ns1:PV_CLAVE_ITEM
	            	let $PAYMENTDATE := $outputParameters1/ns1:PV_FECHAPAGO/ns1:PV_CLAVE_ITEM
	            	
	            	for $i in (1 to count($CLAVE))
	                	return 
	                	<ns0:consultaRemesasResponseRecordType>
	                		<REMITTANCE_ID>{ data($CLAVE[$i]) }</REMITTANCE_ID>
	                		<REMITTER_ID>{ data($REMITERID[$i]) }</REMITTER_ID>
	                		<REMITTER_NAME>{ data($REMITENTE[$i]) }</REMITTER_NAME>
	                		<BENEFICIARY_NAME>{ data($BENEFICIARIO[$i]) }</BENEFICIARY_NAME>
	                		<BRANCH_NAME>{ data($PAYMENTBRANCH[$i]) }</BRANCH_NAME>
	                		<PAYMENT_DATE>{ data($PAYMENTDATE[$i]) }</PAYMENT_DATE>
	                		<CURRENCY>{ data($CURRENCY[$i]) }</CURRENCY>
	                		<REMITTANCE_STATUS>{ data($ESTADO[$i]) }</REMITTANCE_STATUS>
	                		<REMITTANCE_AMOUNT>{ data($AMOUNT[$i]) }</REMITTANCE_AMOUNT>
	                	</ns0:consultaRemesasResponseRecordType>
	            }
	            </ns0:consultaRemesasResponseType>
	        </ns0:consultaRemesasResponse>
    	) else (
    		<ns0:consultaRemesasResponse/>
    	)
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaRemNombreOut($outputParameters1)