xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABKPA/consultaPasivosCliente/xsd/consultaPasivosCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaPasivosClienteResponse" location="../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaPasivosCliente/xq/consultaPasivosClientePrestamoOut/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaPrestamos";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";

declare function xf:consultaPasivosClientePrestamoOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaPasivosClienteResponse) {
        <ns1:consultaPasivosClienteResponse>
            <ns1:consultaPasivosClientePrestamosResponseType>
            {
	            let $liabilityType := $outputParameters1/ns0:LIABILITY_TYPE
	        	let $liabilityNumber := $outputParameters1/ns0:LIABILITY_NUMBER/ns0:LIABILITY_NUMBER_ITEM
	        	let $liabilityCustName := $outputParameters1/ns0:LIABILITY_CUST_NAME/ns0:LIABILITY_CUST_NAME_ITEM
	        	let $liabilityCurrency1 := $outputParameters1/ns0:LIABILITY_CURRENCY_1/ns0:LIABILITY_NUMBER_ITEM
	        	let $liabilityPrincipalAmt1 := $outputParameters1/ns0:LIABILITY_PRINCIPAL_AMT_1/ns0:LIABILITY_NUMBER_ITEM
	        	let $liabilityIntComAmt1 := $outputParameters1/ns0:LIABILITY_INT_COM_AMT_1/ns0:LIABILITY_NUMBER_ITEM
	        	let $liabilityTotalAmt1 := $outputParameters1/ns0:LIABILITY_TOTAL_AMT_1/ns0:LIABILITY_NUMBER_ITEM
	        	let $liabilityCurrency2 := $outputParameters1/ns0:LIABILITY_CURRENCY_2/ns0:LIABILITY_NUMBER_ITEM
	        	let $liabilityPrincipalAmt2 := $outputParameters1/ns0:LIABILITY_PRINCIPAL_AMT_2/ns0:LIABILITY_NUMBER_ITEM
	 			let $liabilityIntComAmt2 := $outputParameters1/ns0:LIABILITY_INT_COM_AMT_2/ns0:LIABILITY_NUMBER_ITEM
	 			let $liabilityTotalAmt2 := $outputParameters1/ns0:LIABILITY_TOTAL_AMT_2/ns0:LIABILITY_NUMBER_ITEM
	 			let $liabilityTotalAmt := $outputParameters1/ns0:LIABILITY_TOTAL_AMT/ns0:LIABILITY_NUMBER_ITEM
                    for $i in (1 to count($liabilityNumber))
                    return
                        <ns1:consultaPasivosClienteResponseRecordType>
                            <LIABILITY_TYPE>{ data($liabilityType) }</LIABILITY_TYPE>
                            <LIABILITY_NUMBER>{ data($liabilityNumber[$i]) }</LIABILITY_NUMBER>
                             <LIABILITY_CUST_NAME>{ data($liabilityCustName[$i]) }</LIABILITY_CUST_NAME>
                             <LIABILITY_CURRENCY_1>{ data($liabilityCurrency1[$i]) }</LIABILITY_CURRENCY_1>
                             <LIABILITY_PRINCIPAL_AMT_1>{ data($liabilityPrincipalAmt1[$i]) }</LIABILITY_PRINCIPAL_AMT_1>
                             <LIABILITY_INT_COM_AMT_1>{ data($liabilityIntComAmt1[$i]) }</LIABILITY_INT_COM_AMT_1>
                             <LIABILITY_TOTAL_AMT_1>{ data($liabilityTotalAmt1[$i]) }</LIABILITY_TOTAL_AMT_1>
                             <LIABILITY_CURRENCY_2>{ data($liabilityCurrency2[$i]) }</LIABILITY_CURRENCY_2>
                             <LIABILITY_PRINCIPAL_AMT_2>{ data($liabilityPrincipalAmt2[$i]) }</LIABILITY_PRINCIPAL_AMT_2>
                             <LIABILITY_INT_COM_AMT_2>{ data($liabilityIntComAmt2[$i]) }</LIABILITY_INT_COM_AMT_2>
                             <LIABILITY_TOTAL_AMT_2>{ data($liabilityTotalAmt2[$i]) }</LIABILITY_TOTAL_AMT_2>
                             <LIABILITY_TOTAL_AMT>{ data($liabilityTotalAmt[$i]) }</LIABILITY_TOTAL_AMT>
                        </ns1:consultaPasivosClienteResponseRecordType>
			}
            </ns1:consultaPasivosClientePrestamosResponseType>
            <ns1:consultaPasivosClienteTCreditoResponseType/>
        </ns1:consultaPasivosClienteResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaPasivosClientePrestamoOut($outputParameters1)