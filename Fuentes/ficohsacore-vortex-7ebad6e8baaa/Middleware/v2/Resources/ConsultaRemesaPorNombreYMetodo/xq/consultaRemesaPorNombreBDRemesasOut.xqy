xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/Remesas/ConsultaRemesaPorNombreBDRemesas/xsd/consultaRemesaPorNombreBDRemesas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaRemesaPorNombreYMetodoResponse" location="../xsd/consultaRemesaPorNombreYMetodoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesaPorNombreYMetodo/xq/consultaRemesaPorNombreBDRemesasOut/";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRemesaPorNombreBDRemesas";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesaPorNombreYMetodoTypes";

declare function xf:consultaRemesaPorNombreBDRemesasOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaRemesaPorNombreYMetodoResponse) {
    	<ns0:consultaRemesaPorNombreYMetodoResponse>
            <ns0:consultaRemesaPorNombreYMetodoResponseType>
                {
                    let $CLAVE_INTERNACIONAL := $outputParameters/ns1:O_CLAVE_INTERNACIONAL/ns1:ITEM
	            	let $BENEFICIARIO := $outputParameters/ns1:O_BENEFICIARIO/ns1:ITEM
	            	let $REMITENTE := $outputParameters/ns1:O_REMITENTE/ns1:ITEM
	            	let $ESTADO := $outputParameters/ns1:O_ESTADO_REMESA/ns1:ITEM
	            	let $AMOUNT := $outputParameters/ns1:O_VALOR_REMESA/ns1:ITEM
	            	for $i in (1 to count($CLAVE_INTERNACIONAL))
	                	return 
	                	<ns0:consultaRemesaPorNombreYMetodoResponseRecordType>
	                		<REMITTANCE_ID>{ data($CLAVE_INTERNACIONAL[$i]) }</REMITTANCE_ID>
	                		<REMITTER_NAME>{ data($REMITENTE[$i]) }</REMITTER_NAME>
	                		<BENEFICIARY_NAME>{ data($BENEFICIARIO[$i]) }</BENEFICIARY_NAME>
	                		<REMITTANCE_STATUS>{ data($ESTADO[$i]) }</REMITTANCE_STATUS>
	                		<REMITTANCE_AMOUNT>{ data($AMOUNT[$i]) }</REMITTANCE_AMOUNT>
	                	</ns0:consultaRemesaPorNombreYMetodoResponseRecordType>
                }
            </ns0:consultaRemesaPorNombreYMetodoResponseType>
        </ns0:consultaRemesaPorNombreYMetodoResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaRemesaPorNombreBDRemesasOut($outputParameters)