(:: pragma bea:global-element-parameter parameter="$consultaPasivosClienteResponse1" element="ns0:consultaPasivosClienteResponse" location="../../../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../xsd/consultaPasivosCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaPasivosClienteResponse" location="../../../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaPasivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaPasivosCliente/sjConsultaTarjetaCreditoAll/sjConsultaPasivosAllOut/";

declare function xf:sjConsultaPasivosAllOut($consultaPasivosClienteResponse1 as element(ns0:consultaPasivosClienteResponse),
    $outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaPasivosClienteResponse) {
        <ns0:consultaPasivosClienteResponse>
            <ns0:consultaPasivosClientePrestamosResponseType>
                {
                    for $LIABILITY_NUMBER_ITEM in $outputParameters1/ns1:LIABILITY_NUMBER/ns1:LIABILITY_NUMBER_ITEM
                   let $liabilityType := $outputParameters1/ns1:LIABILITY_TYPE
		        	let $liabilityNumber := $outputParameters1/ns1:LIABILITY_NUMBER/ns1:LIABILITY_NUMBER_ITEM
		        	let $liabilityCustName := $outputParameters1/ns1:LIABILITY_CUST_NAME/ns1:LIABILITY_CUST_NAME_ITEM
		        	let $liabilityCurrency1 := $outputParameters1/ns1:LIABILITY_CURRENCY_1/ns1:LIABILITY_NUMBER_ITEM
		        	let $liabilityPrincipalAmt1 := $outputParameters1/ns1:LIABILITY_PRINCIPAL_AMT_1/ns1:LIABILITY_NUMBER_ITEM
		        	let $liabilityIntComAmt1 := $outputParameters1/ns1:LIABILITY_INT_COM_AMT_1/ns1:LIABILITY_NUMBER_ITEM
		        	let $liabilityTotalAmt1 := $outputParameters1/ns1:LIABILITY_TOTAL_AMT_1/ns1:LIABILITY_NUMBER_ITEM
		        	let $liabilityCurrency2 := $outputParameters1/ns1:LIABILITY_CURRENCY_2/ns1:LIABILITY_NUMBER_ITEM
		        	let $liabilityPrincipalAmt2 := $outputParameters1/ns1:LIABILITY_PRINCIPAL_AMT_2/ns1:LIABILITY_NUMBER_ITEM
		 			let $liabilityIntComAmt2 := $outputParameters1/ns1:LIABILITY_INT_COM_AMT_2/ns1:LIABILITY_NUMBER_ITEM
		 			let $liabilityTotalAmt2 := $outputParameters1/ns1:LIABILITY_TOTAL_AMT_2/ns1:LIABILITY_NUMBER_ITEM
		 			let $liabilityTotalAmt := $outputParameters1/ns1:LIABILITY_TOTAL_AMT/ns1:LIABILITY_NUMBER_ITEM
                    for $i in (1 to count($liabilityNumber))
                    return
                        <ns0:consultaPasivosClienteResponseRecordType>
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
                        </ns0:consultaPasivosClienteResponseRecordType>
                }
            </ns0:consultaPasivosClientePrestamosResponseType>
            {
                for $consultaPasivosClienteTCreditoResponseType in $consultaPasivosClienteResponse1/ns0:consultaPasivosClienteTCreditoResponseType
                return
                    <ns0:consultaPasivosClienteTCreditoResponseType>
                        {
                            for $consultaPasivosClienteResponseRecordType in $consultaPasivosClienteTCreditoResponseType/ns0:consultaPasivosClienteResponseRecordType
                            return
                                <ns0:consultaPasivosClienteResponseRecordType>
                                    {
                                        for $LIABILITY_TYPE in $consultaPasivosClienteResponseRecordType/LIABILITY_TYPE
                                        return
                                            <LIABILITY_TYPE>{ data($LIABILITY_TYPE) }</LIABILITY_TYPE>
                                    }
                                    {
                                        for $LIABILITY_NUMBER in $consultaPasivosClienteResponseRecordType/LIABILITY_NUMBER
                                        return
                                            <LIABILITY_NUMBER>{ data($LIABILITY_NUMBER) }</LIABILITY_NUMBER>
                                    }
                                    {
                                        for $LIABILITY_CUST_NAME in $consultaPasivosClienteResponseRecordType/LIABILITY_CUST_NAME
                                        return
                                            <LIABILITY_CUST_NAME>{ data($LIABILITY_CUST_NAME) }</LIABILITY_CUST_NAME>
                                    }
                                    {
                                        for $LIABILITY_CURRENCY_1 in $consultaPasivosClienteResponseRecordType/LIABILITY_CURRENCY_1
                                        return
                                            <LIABILITY_CURRENCY_1>{ data($LIABILITY_CURRENCY_1) }</LIABILITY_CURRENCY_1>
                                    }
                                    {
                                        for $LIABILITY_PRINCIPAL_AMT_1 in $consultaPasivosClienteResponseRecordType/LIABILITY_PRINCIPAL_AMT_1
                                        return
                                            <LIABILITY_PRINCIPAL_AMT_1>{ data($LIABILITY_PRINCIPAL_AMT_1) }</LIABILITY_PRINCIPAL_AMT_1>
                                    }
                                    {
                                        for $LIABILITY_INT_COM_AMT_1 in $consultaPasivosClienteResponseRecordType/LIABILITY_INT_COM_AMT_1
                                        return
                                            <LIABILITY_INT_COM_AMT_1>{ data($LIABILITY_INT_COM_AMT_1) }</LIABILITY_INT_COM_AMT_1>
                                    }
                                    {
                                        for $LIABILITY_TOTAL_AMT_1 in $consultaPasivosClienteResponseRecordType/LIABILITY_TOTAL_AMT_1
                                        return
                                            <LIABILITY_TOTAL_AMT_1>{ data($LIABILITY_TOTAL_AMT_1) }</LIABILITY_TOTAL_AMT_1>
                                    }
                                    {
                                        for $LIABILITY_CURRENCY_2 in $consultaPasivosClienteResponseRecordType/LIABILITY_CURRENCY_2
                                        return
                                            <LIABILITY_CURRENCY_2>{ data($LIABILITY_CURRENCY_2) }</LIABILITY_CURRENCY_2>
                                    }
                                    {
                                        for $LIABILITY_PRINCIPAL_AMT_2 in $consultaPasivosClienteResponseRecordType/LIABILITY_PRINCIPAL_AMT_2
                                        return
                                            <LIABILITY_PRINCIPAL_AMT_2>{ data($LIABILITY_PRINCIPAL_AMT_2) }</LIABILITY_PRINCIPAL_AMT_2>
                                    }
                                    {
                                        for $LIABILITY_INT_COM_AMT_2 in $consultaPasivosClienteResponseRecordType/LIABILITY_INT_COM_AMT_2
                                        return
                                            <LIABILITY_INT_COM_AMT_2>{ data($LIABILITY_INT_COM_AMT_2) }</LIABILITY_INT_COM_AMT_2>
                                    }
                                    {
                                        for $LIABILITY_TOTAL_AMT_2 in $consultaPasivosClienteResponseRecordType/LIABILITY_TOTAL_AMT_2
                                        return
                                            <LIABILITY_TOTAL_AMT_2>{ data($LIABILITY_TOTAL_AMT_2) }</LIABILITY_TOTAL_AMT_2>
                                    }
                                    {
                                        for $LIABILITY_TOTAL_AMT in $consultaPasivosClienteResponseRecordType/LIABILITY_TOTAL_AMT
                                        return
                                            <LIABILITY_TOTAL_AMT>{ data($LIABILITY_TOTAL_AMT) }</LIABILITY_TOTAL_AMT>
                                    }
                                </ns0:consultaPasivosClienteResponseRecordType>
                        }
                    </ns0:consultaPasivosClienteTCreditoResponseType>
            }
        </ns0:consultaPasivosClienteResponse>
};

declare variable $consultaPasivosClienteResponse1 as element(ns0:consultaPasivosClienteResponse) external;
declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:sjConsultaPasivosAllOut($consultaPasivosClienteResponse1,
    $outputParameters1)