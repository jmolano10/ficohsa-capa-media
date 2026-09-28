(:: pragma bea:global-element-parameter parameter="$consultaPrestamoTypeResponse" element="ns1:ConsultaPrestamoTypeResponse" location="../../../../../Business_Resources/consultasCliente/consultaPasivosCliente/consultaPrestamos/ConsultaPrestamosCliente.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../MasterDataHN/conDatosTarjetaCliente/xsd/conDatoTarjetaClienteHN_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:sjConsultaPasivosClienteResponse" location="../xsd/sjConsultaPasivosCliente.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaLineasCreditoCliente" element="ns3:OutputParameters" location="../../../ABK/consultaLineasCreditoCliente/xsd/consultaLineasCreditoCliente_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaPasivosCliente";
declare namespace ns1 = "ConsultaPrestamosCliente";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetaClienteHN";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaPasivosCliente/xq/sjConsultaPasivosClienteOut/";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaLineasCreditoCliente";

declare function xf:sjConsultaPasivosClienteOut($consultaPrestamoTypeResponse as element(ns1:ConsultaPrestamoTypeResponse),
    $outputParameters as element(ns0:OutputParameters),
    $consultaLineasCreditoCliente as element(ns3:OutputParameters))
    as element(ns2:sjConsultaPasivosClienteResponse) {
        <ns2:sjConsultaPasivosClienteResponse>
            <ns2:consultaPrestamosResponse>
                <ns2:successIndicator>{ data($consultaPrestamoTypeResponse/ns1:OVERALL_SUCCESS_INDICATOR) }</ns2:successIndicator>
                {
                    let $LOAN_DETAILS := $consultaPrestamoTypeResponse/ns1:LOAN_DETAILS
                    return
                        <ns2:consultaPasivoResponseRecords>
                            {
                                for $LOAN_DETAIL in $LOAN_DETAILS/ns1:LOAN_DETAIL
                                return
                                    <ns2:consultaPasivoResponseRecord>
                                        <ns2:LIABILITY_TYPE>PTM</ns2:LIABILITY_TYPE>
                                        {
                                            for $LOAN_ID in $LOAN_DETAIL/ns1:RESPONSE_BODY/ns1:LOAN_ID
                                            return
                                                <ns2:LIABILITY_NUMBER>{ data($LOAN_ID) }</ns2:LIABILITY_NUMBER>
                                        }
                                        {
                                            for $LOAN_CUSTOMER_NAME in $LOAN_DETAIL/ns1:RESPONSE_BODY/ns1:LOAN_CUSTOMER_NAME
                                            return
                                                <ns2:LIABILITY_CUST_NAME>{ data($LOAN_CUSTOMER_NAME) }</ns2:LIABILITY_CUST_NAME>
                                        }
                                        {
                                            for $CURRENCY in $LOAN_DETAIL/ns1:RESPONSE_BODY/ns1:CURRENCY
                                            return
                                                <ns2:LIABILITY_CURRENCY_1>{ data($CURRENCY) }</ns2:LIABILITY_CURRENCY_1>
                                        }
                                        {
                                            for $NEXT_PAYMNT_PRINCIPAL_AMT in $LOAN_DETAIL/ns1:RESPONSE_BODY/ns1:NEXT_PAYMNT_PRINCIPAL_AMT
                                            return
                                                <ns2:LIABILITY_PRINCIPAL_AMT_1>{ data($NEXT_PAYMNT_PRINCIPAL_AMT) }</ns2:LIABILITY_PRINCIPAL_AMT_1>
                                        }
                                        {
                                            for $NEXT_PAYMNT_INTEREST_AMT in $LOAN_DETAIL/ns1:RESPONSE_BODY/ns1:NEXT_PAYMNT_INTEREST_AMT,
                                                $NEXT_PAYMNT_INSURANCE_AMT in $LOAN_DETAIL/ns1:RESPONSE_BODY/ns1:NEXT_PAYMNT_INSURANCE_AMT
                                            return
                                                <ns2:LIABILITY_INT_COM_AMT_1>{ fn-bea:format-number(fn-bea:fail-over(xs:decimal($NEXT_PAYMNT_INTEREST_AMT),0) + fn-bea:fail-over(xs:decimal($NEXT_PAYMNT_INSURANCE_AMT),0),"###0.00") }</ns2:LIABILITY_INT_COM_AMT_1>
                                        }
                                        {
                                            for $NEXT_PAYMNT_TOTAL_AMT in $LOAN_DETAIL/ns1:RESPONSE_BODY/ns1:NEXT_PAYMNT_TOTAL_AMT
                                            return
                                                <ns2:LIABILITY_TOTAL_AMT_1>{ data($NEXT_PAYMNT_TOTAL_AMT) }</ns2:LIABILITY_TOTAL_AMT_1>
                                        }
                                        {
                                            for $NEXT_PAYMNT_TOTAL_AMT in $LOAN_DETAIL/ns1:RESPONSE_BODY/ns1:NEXT_PAYMNT_TOTAL_AMT
                                            return
                                                <ns2:LIABILITY_TOTAL_AMT>{ data($NEXT_PAYMNT_TOTAL_AMT) }</ns2:LIABILITY_TOTAL_AMT>
                                        }
                                        {
                                            for $NEXT_PAYMNT_MATURITY_DATE in $LOAN_DETAIL/ns1:RESPONSE_BODY/ns1:NEXT_PAYMNT_MATURITY_DATE
                                            return
                                                <ns2:LIABILITY_PAYMENT_DATE>{ data($NEXT_PAYMNT_MATURITY_DATE) }</ns2:LIABILITY_PAYMENT_DATE>
                                        }
                                        <ns2:LIABILITY_SOURCE_BANK>HN01</ns2:LIABILITY_SOURCE_BANK>
                                        {
                                            for $TOTAL_DEBT in $LOAN_DETAIL/ns1:RESPONSE_BODY/ns1:TOTAL_DEBT
                                            return
                                                <ns2:LIABILITY_CANCELLATION_AMOUNT>{ data($TOTAL_DEBT) }</ns2:LIABILITY_CANCELLATION_AMOUNT>
                                        }
                                    </ns2:consultaPasivoResponseRecord>
                            }
                        </ns2:consultaPasivoResponseRecords>
                }
            </ns2:consultaPrestamosResponse>
            { 
	            if (fn:string($outputParameters/ns0:CodigoError/text()) = "-1") then (
	            	<ns2:consultaTarjetaCreditoResponse>
	            		<ns2:successIndicator>-1</ns2:successIndicator>
	            		<ns2:consultaPasivoResponseRecords>
	            			{
				            	for $cardNumber in distinct-values($outputParameters/ns0:RowSet/ns0:Row/ns0:Column[@name = 'numtarjeta']/text())
				            	return(
				            		for $rowBase in $outputParameters/ns0:RowSet/ns0:Row where $rowBase/ns0:Column[@name = 'numtarjeta']/text() = $cardNumber and $rowBase/ns0:Column[@name = 'TipoOrg']/text() = 'BASE'
				            		return
				            		<ns2:consultaPasivoResponseRecord>
					                    <ns2:LIABILITY_TYPE>TRC</ns2:LIABILITY_TYPE>
					                    <ns2:LIABILITY_NUMBER>{ xs:long($cardNumber) }</ns2:LIABILITY_NUMBER>
					                    <ns2:LIABILITY_CUST_NAME>{  data($rowBase/ns0:Column[@name = 'cardholder_name']) }</ns2:LIABILITY_CUST_NAME>
					                    <ns2:LIABILITY_CURRENCY_1>{  data($rowBase/ns0:Column[@name = 'codMoneda']) }</ns2:LIABILITY_CURRENCY_1>
					                    <ns2:LIABILITY_PRINCIPAL_AMT_1>{  data($rowBase/ns0:Column[@name = 'MontoPrincipal']) }</ns2:LIABILITY_PRINCIPAL_AMT_1>
					                    <ns2:LIABILITY_TOTAL_AMT_1>{  data($rowBase/ns0:Column[@name = 'MontoTotal']) }</ns2:LIABILITY_TOTAL_AMT_1>
					                    {
					                    	for $rowAlt in $outputParameters/ns0:RowSet/ns0:Row where $rowAlt/ns0:Column[@name = 'numtarjeta']/text() = $cardNumber and $rowAlt/ns0:Column[@name = 'TipoOrg']/text() = 'ALT'
					                    	return(
					                    	<ns2:LIABILITY_CURRENCY_2>{  data($rowAlt/ns0:Column[@name = 'codMoneda']) }</ns2:LIABILITY_CURRENCY_2>,
					                    	<ns2:LIABILITY_PRINCIPAL_AMT_2>{  data($rowAlt/ns0:Column[@name = 'MontoPrincipal']) }</ns2:LIABILITY_PRINCIPAL_AMT_2>,
					                    	<ns2:LIABILITY_TOTAL_AMT_2>{  data($rowAlt/ns0:Column[@name = 'MontoTotal']) }</ns2:LIABILITY_TOTAL_AMT_2>
					                    	)
					                    }
					                    <ns2:LIABILITY_TOTAL_AMT>{  data($rowBase/ns0:Column[@name = 'BalanceTotal']) }</ns2:LIABILITY_TOTAL_AMT>
					                    {
					                    	if(string($rowBase/ns0:Column[@name = 'FechaMaximaPago']/text()) != "") then (
					                    		<ns2:LIABILITY_PAYMENT_DATE>{  fn-bea:dateTime-to-string-with-format("yyyy-MM-dd", data($rowBase/ns0:Column[@name = 'FechaMaximaPago'])) }</ns2:LIABILITY_PAYMENT_DATE>
					                    	) else()
					                    }
					                    <ns2:LIABILITY_SOURCE_BANK>HN01</ns2:LIABILITY_SOURCE_BANK>
					                    {
					                    	if(string($rowBase/ns0:Column[@name = 'MontoCancelacion']/text()) != "") then (
					                    		<ns2:LIABILITY_TOTAL_CANCELATION_AMT>{  data($rowBase/ns0:Column[@name = 'MontoCancelacion']) }</ns2:LIABILITY_TOTAL_CANCELATION_AMT>
					                    	) else()
					                    }
					                </ns2:consultaPasivoResponseRecord>
				            	)
					           }
	            		</ns2:consultaPasivoResponseRecords>
	            	</ns2:consultaTarjetaCreditoResponse>
	            )else(
		            <ns2:consultaTarjetaCreditoResponse>
		            	{
			               for $CodigoError in $outputParameters/ns0:CodigoError/text()
			               return
			               <ns2:successIndicator>{ data($CodigoError) }</ns2:successIndicator>
			             }
		            </ns2:consultaTarjetaCreditoResponse>
	            ) 
            }
        <ns2:consultaLCRResponse>
            	<ns2:successIndicator>{ data($consultaLineasCreditoCliente/ns3:P_SUCCESSINDICATOR) }</ns2:successIndicator>
                <ns2:consultaPasivoResponseRecords>
                {
                    let $CUSTOMER_NAME := $consultaLineasCreditoCliente/ns3:P_CUSTOMER_NAME
                    let $CREDIT_LINE_ID :=  $consultaLineasCreditoCliente/ns3:P_CREDIT_LINE_ID/ns3:P_CREDIT_LINE_ID_ITEM
                    let $CREDIT_LINE_CURRENCY :=  $consultaLineasCreditoCliente/ns3:P_CREDIT_LINE_CURRENCY/ns3:P_CREDIT_LINE_CURRENCY_ITEM
                    let $EXPIRY_DATE :=  $consultaLineasCreditoCliente/ns3:P_EXPIRY_DATE/ns3:P_CREDIT_LINE_ID_ITEM
                    let $AMOUNT :=  $consultaLineasCreditoCliente/ns3:P_AMOUNT/ns3:P_CREDIT_LINE_ID_ITEM
                    let $USED_AMOUNT :=  $consultaLineasCreditoCliente/ns3:P_USED_AMOUNT/ns3:P_CREDIT_LINE_ID_ITEM
                    let $AVAILABLE_AMOUNT :=  $consultaLineasCreditoCliente/ns3:P_AVAILABLE_AMOUNT/ns3:P_CREDIT_LINE_ID_ITEM
                    for $i in 1 to count($CREDIT_LINE_ID)
                    return
                    (
                        <ns2:consultaPasivoResponseRecord>
                            <ns2:LIABILITY_TYPE>LCR</ns2:LIABILITY_TYPE>
                            <ns2:LIABILITY_NUMBER>{ data($CREDIT_LINE_ID[$i]) }</ns2:LIABILITY_NUMBER>
                            <ns2:LIABILITY_CUST_NAME>{ data($CUSTOMER_NAME) }</ns2:LIABILITY_CUST_NAME>
                            <ns2:LIABILITY_CURRENCY_1>{ data($CREDIT_LINE_CURRENCY[$i]) }</ns2:LIABILITY_CURRENCY_1>
                            <ns2:LIABILITY_PRINCIPAL_AMT_1>{ data($AMOUNT[$i]) }</ns2:LIABILITY_PRINCIPAL_AMT_1>  
                            <ns2:LIABILITY_TOTAL_AMT_1>{ data($AVAILABLE_AMOUNT[$i]) }</ns2:LIABILITY_TOTAL_AMT_1>
                            <ns2:LIABILITY_TOTAL_AMT>{ data($USED_AMOUNT[$i]) }</ns2:LIABILITY_TOTAL_AMT>
                            {
                                if(data($EXPIRY_DATE[$i]) != '') then(
                                    <ns2:LIABILITY_PAYMENT_DATE>{ data($EXPIRY_DATE[$i]) }</ns2:LIABILITY_PAYMENT_DATE>
                                )else()
                            }
                        </ns2:consultaPasivoResponseRecord>
                    )
                }
                </ns2:consultaPasivoResponseRecords>
         </ns2:consultaLCRResponse>                
        </ns2:sjConsultaPasivosClienteResponse>
};

declare variable $consultaPrestamoTypeResponse as element(ns1:ConsultaPrestamoTypeResponse) external;
declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $consultaLineasCreditoCliente as element(ns3:OutputParameters) external;

xf:sjConsultaPasivosClienteOut($consultaPrestamoTypeResponse,
    $outputParameters,
    $consultaLineasCreditoCliente)