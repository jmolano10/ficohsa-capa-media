xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../BusinessServices/ABK/consultarLoteDeudores/xsd/consultarLoteDeudores_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaLoteDeudoresResponse" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarLoteDeudores";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/PagingTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaLoteDeudores/xq/consultaLoteDeudoresOut/";

declare function xf:consultaLoteDeudoresOut($outputParameters as element(ns2:OutputParameters))
    as element(ns1:consultaLoteDeudoresResponse) {
        <ns1:consultaLoteDeudoresResponse>
            {
                for $PV_CODIGOCLIENTE in $outputParameters/ns2:PV_CODIGOCLIENTE
                return
                    <CUSTOMER_ID>{ data($PV_CODIGOCLIENTE) }</CUSTOMER_ID>
            }
            {
                for $PV_NUMEROCONTRATO in $outputParameters/ns2:PV_NUMEROCONTRATO
                return
                    <CONTRACT_ID>{ data($PV_NUMEROCONTRATO) }</CONTRACT_ID>
            }
            {
                for $PN_IDLOTE in $outputParameters/ns2:PN_IDLOTE
                return
                    <BANK_BATCH_ID>{ data($PN_IDLOTE) }</BANK_BATCH_ID>
            }
            <RECORDS_INFO>
                <INITIAL_RECORD>{ data($outputParameters/ns2:PN_REGISTROINICIAL) }</INITIAL_RECORD>
                <RECORDS_RETURNED>{ data($outputParameters/ns2:PN_CANTIDADREGISTROS) }</RECORDS_RETURNED>
                <RECORD_TOTAL>{ data($outputParameters/ns2:PN_TOTALREGISTROS) }</RECORD_TOTAL>
            </RECORDS_INFO>
            <DEBTORS>
            	{
                	let $DEBTOR := $outputParameters/ns2:PT_CODIGODEUDORES/ns2:ITEM
                    for $i in 1 to count($DEBTOR)
                    return
	                <DEBTOR>
	                    <DEBTOR_CODE>{ data($outputParameters/ns2:PT_CODIGODEUDORES/ns2:ITEM[$i]) }</DEBTOR_CODE>
	                    <DEBTOR_NAME>{ data($outputParameters/ns2:PT_NOMBREDEUDORES/ns2:ITEM[$i]) }</DEBTOR_NAME>
	                    {
		                    let $fecha := data($outputParameters/ns2:PT_CREACIONDEUDORES/ns2:ITEM[$i])
		                    return
		                    if (fn-bea:trim(xs:string($fecha)) != '') then (
		                    	<CREATION_DATE>{ fn:adjust-date-to-timezone(fn-bea:date-from-dateTime($fecha),()) }</CREATION_DATE>
		                    ) else ()
	                    }
	                    <STATUS>{ data($outputParameters/ns2:PT_ESTADODEUDORES/ns2:ITEM[$i]) }</STATUS>
                    	<STATUS_DESCRIPTION>{ data($outputParameters/ns2:PT_ESTADODESCDEUDORES/ns2:ITEM[$i]) }</STATUS_DESCRIPTION>                    
                	</DEBTOR>
                }
            </DEBTORS>
        </ns1:consultaLoteDeudoresResponse>
};

declare variable $outputParameters as element(ns2:OutputParameters) external;

xf:consultaLoteDeudoresOut($outputParameters)