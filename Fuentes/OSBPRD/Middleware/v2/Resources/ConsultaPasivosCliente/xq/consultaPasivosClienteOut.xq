(:: pragma bea:global-element-parameter parameter="$sjConsultaPasivosClienteResponse1" element="ns0:sjConsultaPasivosClienteResponse" location="../../../BusinessServices/SJS/consultaPasivosCliente/xsd/sjConsultaPasivosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaPasivosClienteResponse" location="../xsd/consultaPasivosClienteTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaPasivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaPasivosClienteOut/";

declare function convertirStringFechaString($stringDate as xs:string?)
	as xs:string {
		if (fn-bea:trim($stringDate) != '') then 
			let $date := fn-bea:date-from-string-with-format("yyyy-MM-dd", $stringDate)
			return fn-bea:date-to-string-with-format("yyyyMMdd", $date)  
		else ("")
};

declare function xf:consultaPasivosClienteOut($sjConsultaPasivosClienteResponse1 as element(ns0:sjConsultaPasivosClienteResponse),
    $overallSuccessInd as xs:string,
    $sourceBank as xs:string)
    as element(ns1:consultaPasivosClienteResponse) {
    	if ($overallSuccessInd = "Success")  then (
	        <ns1:consultaPasivosClienteResponse>
	            {
	                for $consultaPasivoResponseRecords in $sjConsultaPasivosClienteResponse1/ns0:consultaPrestamosResponse/ns0:consultaPasivoResponseRecords
	                return
	                    <ns1:consultaPasivosClientePrestamosResponseType>
	                        {
	                            for $consultaPasivoResponseRecord in $consultaPasivoResponseRecords/ns0:consultaPasivoResponseRecord
	                            return
	                                <ns1:consultaPasivosClienteResponseRecordType>
	                                    {
	                                        for $LIABILITY_TYPE in $consultaPasivoResponseRecord/ns0:LIABILITY_TYPE
	                                        return
	                                            <LIABILITY_TYPE>{ data($LIABILITY_TYPE) }</LIABILITY_TYPE>
	                                    }
	                                    {
	                                        for $LIABILITY_NUMBER in $consultaPasivoResponseRecord/ns0:LIABILITY_NUMBER
	                                        return
	                                            <LIABILITY_NUMBER>{ data($LIABILITY_NUMBER) }</LIABILITY_NUMBER>
	                                    }
	                                    {
	                                        for $LIABILITY_CUST_NAME in $consultaPasivoResponseRecord/ns0:LIABILITY_CUST_NAME
	                                        return
	                                            <LIABILITY_CUST_NAME>{ data($LIABILITY_CUST_NAME) }</LIABILITY_CUST_NAME>
	                                    }
	                                    {
	                                        for $LIABILITY_CURRENCY_1 in $consultaPasivoResponseRecord/ns0:LIABILITY_CURRENCY_1
	                                        return
	                                            <LIABILITY_CURRENCY_1>{ data($LIABILITY_CURRENCY_1) }</LIABILITY_CURRENCY_1>
	                                    }
	                                    {
	                                        for $LIABILITY_PRINCIPAL_AMT_1 in $consultaPasivoResponseRecord/ns0:LIABILITY_PRINCIPAL_AMT_1
	                                        return
	                                            <LIABILITY_PRINCIPAL_AMT_1>{ data($LIABILITY_PRINCIPAL_AMT_1) }</LIABILITY_PRINCIPAL_AMT_1>
	                                    }
	                                    {
	                                        for $LIABILITY_INT_COM_AMT_1 in $consultaPasivoResponseRecord/ns0:LIABILITY_INT_COM_AMT_1
	                                        return
	                                            <LIABILITY_INT_COM_AMT_1>{ data($LIABILITY_INT_COM_AMT_1) }</LIABILITY_INT_COM_AMT_1>
	                                    }
	                                    {
	                                        for $LIABILITY_TOTAL_AMT_1 in $consultaPasivoResponseRecord/ns0:LIABILITY_TOTAL_AMT_1
	                                        return
	                                            <LIABILITY_TOTAL_AMT_1>{ data($LIABILITY_TOTAL_AMT_1) }</LIABILITY_TOTAL_AMT_1>
	                                    }
	                                    {
	                                        for $LIABILITY_CURRENCY_2 in $consultaPasivoResponseRecord/ns0:LIABILITY_CURRENCY_2
	                                        return
	                                            <LIABILITY_CURRENCY_2>{ data($LIABILITY_CURRENCY_2) }</LIABILITY_CURRENCY_2>
	                                    }
	                                    {
	                                        for $LIABILITY_PRINCIPAL_AMT_2 in $consultaPasivoResponseRecord/ns0:LIABILITY_PRINCIPAL_AMT_2
	                                        return
	                                            <LIABILITY_PRINCIPAL_AMT_2>{ data($LIABILITY_PRINCIPAL_AMT_2) }</LIABILITY_PRINCIPAL_AMT_2>
	                                    }
	                                    {
	                                        for $LIABILITY_INT_COM_AMT_2 in $consultaPasivoResponseRecord/ns0:LIABILITY_INT_COM_AMT_2
	                                        return
	                                            <LIABILITY_INT_COM_AMT_2>{ data($LIABILITY_INT_COM_AMT_2) }</LIABILITY_INT_COM_AMT_2>
	                                    }
	                                    {
	                                        for $LIABILITY_TOTAL_AMT_2 in $consultaPasivoResponseRecord/ns0:LIABILITY_TOTAL_AMT_2
	                                        return
	                                            <LIABILITY_TOTAL_AMT_2>{ data($LIABILITY_TOTAL_AMT_2) }</LIABILITY_TOTAL_AMT_2>
	                                    }
	                                    {
	                                        for $LIABILITY_TOTAL_AMT in $consultaPasivoResponseRecord/ns0:LIABILITY_TOTAL_AMT
	                                        return
	                                            <LIABILITY_TOTAL_AMT>{ data($LIABILITY_TOTAL_AMT) }</LIABILITY_TOTAL_AMT>
	                                    }
	                                    {
	                                        for $LIABILITY_PAYMENT_DATE in $consultaPasivoResponseRecord/ns0:LIABILITY_PAYMENT_DATE
	                                        return
	                                            <LIABILITY_PAYMENT_DATE>{ data($LIABILITY_PAYMENT_DATE) }</LIABILITY_PAYMENT_DATE>
	                                    }
	                                    {
	                                        for $LIABILITY_SOURCE_BANK in $consultaPasivoResponseRecord/ns0:LIABILITY_SOURCE_BANK
	                                        return
	                                            <LIABILITY_SOURCE_BANK>{ data($LIABILITY_SOURCE_BANK) }</LIABILITY_SOURCE_BANK>
	                                    }
	                                    {
	                                        for $LIABILITY_CANCELLATION_AMOUNT in $consultaPasivoResponseRecord/ns0:LIABILITY_CANCELLATION_AMOUNT
	                                        return
	                                            <LIABILITY_TOTAL_CANCELATION_AMT>{ data($LIABILITY_CANCELLATION_AMOUNT) }</LIABILITY_TOTAL_CANCELATION_AMT>
	                                    }
	                                </ns1:consultaPasivosClienteResponseRecordType>
	                        }
	                    </ns1:consultaPasivosClientePrestamosResponseType>
	            }
	            {
	                for $consultaPasivoResponseRecords in $sjConsultaPasivosClienteResponse1/ns0:consultaTarjetaCreditoResponse/ns0:consultaPasivoResponseRecords
	                return
	                    <ns1:consultaPasivosClienteTCreditoResponseType>
	                        {
	                            for $consultaPasivoResponseRecord in $consultaPasivoResponseRecords/ns0:consultaPasivoResponseRecord
	                            return
	                                <ns1:consultaPasivosClienteResponseRecordType>
	                                    {
	                                        for $LIABILITY_TYPE in $consultaPasivoResponseRecord/ns0:LIABILITY_TYPE
	                                        return
	                                            <LIABILITY_TYPE>{ data($LIABILITY_TYPE) }</LIABILITY_TYPE>
	                                    }
	                                    {
	                                        for $LIABILITY_NUMBER in $consultaPasivoResponseRecord/ns0:LIABILITY_NUMBER
	                                        return
	                                            <LIABILITY_NUMBER>{ data($LIABILITY_NUMBER) }</LIABILITY_NUMBER>
	                                    }
	                                    {
	                                        for $LIABILITY_CUST_NAME in $consultaPasivoResponseRecord/ns0:LIABILITY_CUST_NAME
	                                        return
	                                            <LIABILITY_CUST_NAME>{ data($LIABILITY_CUST_NAME) }</LIABILITY_CUST_NAME>
	                                    }
	                                    {
	                                        for $LIABILITY_CURRENCY_1 in $consultaPasivoResponseRecord/ns0:LIABILITY_CURRENCY_1
	                                        return
	                                            <LIABILITY_CURRENCY_1>{ data($LIABILITY_CURRENCY_1) }</LIABILITY_CURRENCY_1>
	                                    }
	                                    {
	                                        for $LIABILITY_PRINCIPAL_AMT_1 in $consultaPasivoResponseRecord/ns0:LIABILITY_PRINCIPAL_AMT_1
	                                        return
	                                            <LIABILITY_PRINCIPAL_AMT_1>{ data($LIABILITY_PRINCIPAL_AMT_1) }</LIABILITY_PRINCIPAL_AMT_1>
	                                    }
	                                    {
	                                        for $LIABILITY_INT_COM_AMT_1 in $consultaPasivoResponseRecord/ns0:LIABILITY_INT_COM_AMT_1
	                                        return
	                                            <LIABILITY_INT_COM_AMT_1>{ data($LIABILITY_INT_COM_AMT_1) }</LIABILITY_INT_COM_AMT_1>
	                                    }
	                                    {
	                                        for $LIABILITY_TOTAL_AMT_1 in $consultaPasivoResponseRecord/ns0:LIABILITY_TOTAL_AMT_1
	                                        return
	                                            <LIABILITY_TOTAL_AMT_1>{ data($LIABILITY_TOTAL_AMT_1) }</LIABILITY_TOTAL_AMT_1>
	                                    }
	                                    {
	                                        for $LIABILITY_CURRENCY_2 in $consultaPasivoResponseRecord/ns0:LIABILITY_CURRENCY_2
	                                        return
	                                            <LIABILITY_CURRENCY_2>{ data($LIABILITY_CURRENCY_2) }</LIABILITY_CURRENCY_2>
	                                    }
	                                    {
	                                        for $LIABILITY_PRINCIPAL_AMT_2 in $consultaPasivoResponseRecord/ns0:LIABILITY_PRINCIPAL_AMT_2
	                                        return
	                                            <LIABILITY_PRINCIPAL_AMT_2>{ data($LIABILITY_PRINCIPAL_AMT_2) }</LIABILITY_PRINCIPAL_AMT_2>
	                                    }
	                                    {
	                                        for $LIABILITY_INT_COM_AMT_2 in $consultaPasivoResponseRecord/ns0:LIABILITY_INT_COM_AMT_2
	                                        return
	                                            <LIABILITY_INT_COM_AMT_2>{ data($LIABILITY_INT_COM_AMT_2) }</LIABILITY_INT_COM_AMT_2>
	                                    }
	                                    {
	                                        for $LIABILITY_TOTAL_AMT_2 in $consultaPasivoResponseRecord/ns0:LIABILITY_TOTAL_AMT_2
	                                        return
	                                            <LIABILITY_TOTAL_AMT_2>{ data($LIABILITY_TOTAL_AMT_2) }</LIABILITY_TOTAL_AMT_2>
	                                    }
	                                    {
	                                        for $LIABILITY_TOTAL_AMT in $consultaPasivoResponseRecord/ns0:LIABILITY_TOTAL_AMT
	                                        return
	                                            <LIABILITY_TOTAL_AMT>{ data($LIABILITY_TOTAL_AMT) }</LIABILITY_TOTAL_AMT>
	                                    }
	                                    {
	                                        for $LIABILITY_PAYMENT_DATE in $consultaPasivoResponseRecord/ns0:LIABILITY_PAYMENT_DATE
	                                        return
	                                            <LIABILITY_PAYMENT_DATE>{ convertirStringFechaString(data($LIABILITY_PAYMENT_DATE)) }</LIABILITY_PAYMENT_DATE>
	                                    }
	                                    {
	                                        for $LIABILITY_SOURCE_BANK in $consultaPasivoResponseRecord/ns0:LIABILITY_SOURCE_BANK
	                                        return
	                                            <LIABILITY_SOURCE_BANK>{ data($LIABILITY_SOURCE_BANK) }</LIABILITY_SOURCE_BANK>
	                                    }
	                                    {
	                                        for $LIABILITY_CANCELLATION_AMOUNT in $consultaPasivoResponseRecord/ns0:LIABILITY_TOTAL_CANCELATION_AMT
	                                        return
	                                            <LIABILITY_TOTAL_CANCELATION_AMT>{ data($LIABILITY_CANCELLATION_AMOUNT) }</LIABILITY_TOTAL_CANCELATION_AMT>
	                                    }
	                                </ns1:consultaPasivosClienteResponseRecordType>
	                        }
	                    </ns1:consultaPasivosClienteTCreditoResponseType>
	            }
	           {
		        	for $consultaPasivoResponseRecords in $sjConsultaPasivosClienteResponse1/ns0:consultaLCRResponse/ns0:consultaPasivoResponseRecords
			        return(
			            <ns1:consultaPasivosClienteLCRResponseType>
			            {
			            	for $consultaPasivoResponseRecord in $consultaPasivoResponseRecords/ns0:consultaPasivoResponseRecord
			                    return(
					                <ns1:consultaPasivosClienteResponseRecordType>
					                    {
					                        for $LIABILITY_TYPE in $consultaPasivoResponseRecord/ns0:LIABILITY_TYPE
					                        return
					                            <LIABILITY_TYPE>{ data($LIABILITY_TYPE) }</LIABILITY_TYPE>
					                    }
					                    {
					                        for $LIABILITY_NUMBER in $consultaPasivoResponseRecord/ns0:LIABILITY_NUMBER
					                        return
					                            <LIABILITY_NUMBER>{ data($LIABILITY_NUMBER) }</LIABILITY_NUMBER>
					                    }
					                    {
					                        for $LIABILITY_CUST_NAME in $consultaPasivoResponseRecord/ns0:LIABILITY_CUST_NAME
					                        return
					                            <LIABILITY_CUST_NAME>{ data($LIABILITY_CUST_NAME) }</LIABILITY_CUST_NAME>
					                    }
					                    {
					                        for $LIABILITY_CURRENCY_1 in $consultaPasivoResponseRecord/ns0:LIABILITY_CURRENCY_1
					                        return
					                            <LIABILITY_CURRENCY_1>{ data($LIABILITY_CURRENCY_1) }</LIABILITY_CURRENCY_1>
					                    }
					                    {
					                        for $LIABILITY_PRINCIPAL_AMT_1 in $consultaPasivoResponseRecord/ns0:LIABILITY_PRINCIPAL_AMT_1
					                        return
					                            <LIABILITY_PRINCIPAL_AMT_1>{ data($LIABILITY_PRINCIPAL_AMT_1) }</LIABILITY_PRINCIPAL_AMT_1>
					                    }
					                    {
					                        for $LIABILITY_INT_COM_AMT_1 in $consultaPasivoResponseRecord/ns0:LIABILITY_INT_COM_AMT_1
					                        return
					                            <LIABILITY_INT_COM_AMT_1>{ data($LIABILITY_INT_COM_AMT_1) }</LIABILITY_INT_COM_AMT_1>
					                    }
					                    {
					                        for $LIABILITY_TOTAL_AMT_1 in $consultaPasivoResponseRecord/ns0:LIABILITY_TOTAL_AMT_1
					                        return
					                            <LIABILITY_TOTAL_AMT_1>{ data($LIABILITY_TOTAL_AMT_1) }</LIABILITY_TOTAL_AMT_1>
					                    }
					                    {
					                        for $LIABILITY_CURRENCY_2 in $consultaPasivoResponseRecord/ns0:LIABILITY_CURRENCY_2
					                        return
					                            <LIABILITY_CURRENCY_2>{ data($LIABILITY_CURRENCY_2) }</LIABILITY_CURRENCY_2>
					                    }
					                    {
					                        for $LIABILITY_PRINCIPAL_AMT_2 in $consultaPasivoResponseRecord/ns0:LIABILITY_PRINCIPAL_AMT_2
					                        return
					                            <LIABILITY_PRINCIPAL_AMT_2>{ data($LIABILITY_PRINCIPAL_AMT_2) }</LIABILITY_PRINCIPAL_AMT_2>
					                    }
					                    {
					                        for $LIABILITY_INT_COM_AMT_2 in $consultaPasivoResponseRecord/ns0:LIABILITY_INT_COM_AMT_2
					                        return
					                            <LIABILITY_INT_COM_AMT_2>{ data($LIABILITY_INT_COM_AMT_2) }</LIABILITY_INT_COM_AMT_2>
					                    }
					                    {
					                        for $LIABILITY_TOTAL_AMT_2 in $consultaPasivoResponseRecord/ns0:LIABILITY_TOTAL_AMT_2
					                        return
					                            <LIABILITY_TOTAL_AMT_2>{ data($LIABILITY_TOTAL_AMT_2) }</LIABILITY_TOTAL_AMT_2>
					                    }
					                    {
					                        for $LIABILITY_TOTAL_AMT in $consultaPasivoResponseRecord/ns0:LIABILITY_TOTAL_AMT
					                        return
					                            <LIABILITY_TOTAL_AMT>{ data($LIABILITY_TOTAL_AMT) }</LIABILITY_TOTAL_AMT>
					                    }
					                    {
					                        for $LIABILITY_PAYMENT_DATE in $consultaPasivoResponseRecord/ns0:LIABILITY_PAYMENT_DATE
					                        return
					                            <LIABILITY_PAYMENT_DATE>{ data($LIABILITY_PAYMENT_DATE) }</LIABILITY_PAYMENT_DATE>
					                    }
					                     
					                            <LIABILITY_SOURCE_BANK>{ $sourceBank }</LIABILITY_SOURCE_BANK>
					                    {
					                        for $LIABILITY_CANCELLATION_AMOUNT in $consultaPasivoResponseRecord/ns0:LIABILITY_CANCELLATION_AMOUNT
					                        return
					                            <LIABILITY_TOTAL_CANCELATION_AMT>{ data($LIABILITY_CANCELLATION_AMOUNT) }</LIABILITY_TOTAL_CANCELATION_AMT>
					                    }
					                </ns1:consultaPasivosClienteResponseRecordType>
			            	 )
			            }	 
			            </ns1:consultaPasivosClienteLCRResponseType>
		            )
		        }
       		</ns1:consultaPasivosClienteResponse> 
	    ) else (
	    	<ns1:consultaPasivosClienteResponse>
	    		<ns1:consultaPasivosClientePrestamosResponseType/>
	    		<ns1:consultaPasivosClienteTCreditoResponseType/>
	    	</ns1:consultaPasivosClienteResponse>
	    )
};

declare variable $sjConsultaPasivosClienteResponse1 as element(ns0:sjConsultaPasivosClienteResponse) external;
declare variable $overallSuccessInd as xs:string external;
declare variable $sourceBank as xs:string external;

xf:consultaPasivosClienteOut($sjConsultaPasivosClienteResponse1,
    $overallSuccessInd,
    $sourceBank)