xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ConsultarRemPorNombre/xsd/consultarRemPorNombre_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaRemesaPorNombreYMetodoResponse" location="../xsd/consultaRemesaPorNombreYMetodoTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRemPorNombre";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesaPorNombreYMetodoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesaPorNombreYMetodo/xq/consultaRemesaPorNombreBDFlinkOut/";

declare function xf:consultaRemesaPorNombreBDFlinkOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaRemesaPorNombreYMetodoResponse) {
        <ns0:consultaRemesaPorNombreYMetodoResponse>
            <ns0:consultaRemesaPorNombreYMetodoResponseType>
                {
                    let $CLAVE := $outputParameters/ns1:PV_CLAVE/ns1:PV_CLAVE_ITEM
	            	let $REMITENTE := $outputParameters/ns1:PV_REMITENTE/ns1:PV_CLAVE_ITEM
	            	let $BENEFICIARIO := $outputParameters/ns1:PV_BENEFICIARIO/ns1:PV_CLAVE_ITEM
	            	let $ESTADO := $outputParameters/ns1:PV_ESTADO/ns1:PV_CLAVE_ITEM
	            	let $AMOUNT := $outputParameters/ns1:PV_VALOR/ns1:PV_VALOR_ITEM
	            	let $REMITERID := $outputParameters/ns1:PV_CODREMESADORA/ns1:PV_CLAVE_ITEM
	            	let $CURRENCY := $outputParameters/ns1:PV_MONEDA/ns1:PV_CLAVE_ITEM
	            	let $PAYMENTBRANCH := $outputParameters/ns1:PV_AGENCIAPAGO/ns1:PV_CLAVE_ITEM
	            	let $PAYMENTDATE := $outputParameters/ns1:PV_FECHAPAGO/ns1:PV_CLAVE_ITEM
	            	for $i in (1 to count($CLAVE))
	                	return 
	                	<ns0:consultaRemesaPorNombreYMetodoResponseRecordType>
	                		<REMITTANCE_ID>{ data($CLAVE[$i]) }</REMITTANCE_ID>
	                		<REMITTER_ID>{ data($REMITERID[$i]) }</REMITTER_ID>
	                		<REMITTER_NAME>{ data($REMITENTE[$i]) }</REMITTER_NAME>
	                		<BENEFICIARY_NAME>{ data($BENEFICIARIO[$i]) }</BENEFICIARY_NAME>
	                		<BRANCH_NAME>{ data($PAYMENTBRANCH[$i]) }</BRANCH_NAME>
	                		<PAYMENT_DATE>{ data($PAYMENTDATE[$i]) }</PAYMENT_DATE>
	                		<CURRENCY>{ data($CURRENCY[$i]) }</CURRENCY>
	                		<REMITTANCE_STATUS>{ data($ESTADO[$i]) }</REMITTANCE_STATUS>
	                		<REMITTANCE_AMOUNT>{ data($AMOUNT[$i]) }</REMITTANCE_AMOUNT>
	                	</ns0:consultaRemesaPorNombreYMetodoResponseRecordType>
                }
            </ns0:consultaRemesaPorNombreYMetodoResponseType>
        </ns0:consultaRemesaPorNombreYMetodoResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaRemesaPorNombreBDFlinkOut($outputParameters)