xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaPasivosClienteResponseOUT" element="ns1:consultaPasivosClienteResponse" location="../../../../Resources/ConsultaPasivosCliente/xsd/consultaPasivosClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaActivosPasivosClienteResponse" location="../xsd/sjConsultaActivosPasivosCliente.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosPasivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaActivosPasivosCliente/xq/ConsultPasivosClienteIN/";

declare function xf:ConsultPasivosClienteIN($consultaPasivosClienteResponseOUT as element(ns1:consultaPasivosClienteResponse),
$TypeSerch as xs:string)
    as element(ns0:sjConsultaActivosPasivosClienteResponse) {
        <ns0:sjConsultaActivosPasivosClienteResponse>
            <ns0:LIABILITIES_INFORMATION>
              <ns0:LIABILITIY>
                {
	                for $consultaPasivoResponseRecords in $consultaPasivosClienteResponseOUT/ns1:consultaPasivosClientePrestamosResponseType
	                return
	                   if ($TypeSerch='ALL' or $TypeSerch='PTM' ) then(
	                    <ns0:consultaPasivosClientePrestamosResponseType>
	                        
	                        {
	                            for $consultaPasivoResponseRecord in $consultaPasivoResponseRecords/ns1:consultaPasivosClienteResponseRecordType
	                            return
	                          
	                                <ns0:consultaPasivosClienteResponseRecordType>
	                                    {
	                                        for $LIABILITY_TYPE in $consultaPasivoResponseRecord/LIABILITY_TYPE
	                                        return
	                                            <LIABILITY_TYPE>{ data($LIABILITY_TYPE) }</LIABILITY_TYPE>
	                                    }
	                                    {
	                                        for $LIABILITY_NUMBER in $consultaPasivoResponseRecord/LIABILITY_NUMBER
	                                        return
	                                            <LIABILITY_NUMBER>{ data($LIABILITY_NUMBER) }</LIABILITY_NUMBER>
	                                    }
	                                    {
	                                        for $LIABILITY_CUST_NAME in $consultaPasivoResponseRecord/LIABILITY_CUST_NAME
	                                        return
	                                            <LIABILITY_CUST_NAME>{ data($LIABILITY_CUST_NAME) }</LIABILITY_CUST_NAME>
	                                    }
	                                    {
	                                        for $LIABILITY_CURRENCY_1 in $consultaPasivoResponseRecord/LIABILITY_CURRENCY_1
	                                        return
	                                            <LIABILITY_CURRENCY_1>{ data($LIABILITY_CURRENCY_1) }</LIABILITY_CURRENCY_1>
	                                    }
	                                    {
	                                        for $LIABILITY_PRINCIPAL_AMT_1 in $consultaPasivoResponseRecord/LIABILITY_PRINCIPAL_AMT_1
	                                        return
	                                            <LIABILITY_PRINCIPAL_AMT_1>{ data($LIABILITY_PRINCIPAL_AMT_1) }</LIABILITY_PRINCIPAL_AMT_1>
	                                    }
	                                    {
	                                        for $LIABILITY_INT_COM_AMT_1 in $consultaPasivoResponseRecord/LIABILITY_INT_COM_AMT_1
	                                        return
	                                            <LIABILITY_INT_COM_AMT_1>{ data($LIABILITY_INT_COM_AMT_1) }</LIABILITY_INT_COM_AMT_1>
	                                    }
	                                    {
	                                        for $LIABILITY_TOTAL_AMT_1 in $consultaPasivoResponseRecord/LIABILITY_TOTAL_AMT_1
	                                        return
	                                            <LIABILITY_TOTAL_AMT_1>{ data($LIABILITY_TOTAL_AMT_1) }</LIABILITY_TOTAL_AMT_1>
	                                    }
	                                    {
	                                        for $LIABILITY_CURRENCY_2 in $consultaPasivoResponseRecord/LIABILITY_CURRENCY_2
	                                        return
	                                            <LIABILITY_CURRENCY_2>{ data($LIABILITY_CURRENCY_2) }</LIABILITY_CURRENCY_2>
	                                    }
	                                    {
	                                        for $LIABILITY_PRINCIPAL_AMT_2 in $consultaPasivoResponseRecord/LIABILITY_PRINCIPAL_AMT_2
	                                        return
	                                            <LIABILITY_PRINCIPAL_AMT_2>{ data($LIABILITY_PRINCIPAL_AMT_2) }</LIABILITY_PRINCIPAL_AMT_2>
	                                    }
	                                    {
	                                        for $LIABILITY_INT_COM_AMT_2 in $consultaPasivoResponseRecord/LIABILITY_INT_COM_AMT_2
	                                        return
	                                            <LIABILITY_INT_COM_AMT_2>{ data($LIABILITY_INT_COM_AMT_2) }</LIABILITY_INT_COM_AMT_2>
	                                    }
	                                    {
	                                        for $LIABILITY_TOTAL_AMT_2 in $consultaPasivoResponseRecord/LIABILITY_TOTAL_AMT_2
	                                        return
	                                            <LIABILITY_TOTAL_AMT_2>{ data($LIABILITY_TOTAL_AMT_2) }</LIABILITY_TOTAL_AMT_2>
	                                    }
	                                    {
	                                        for $LIABILITY_TOTAL_AMT in $consultaPasivoResponseRecord/LIABILITY_TOTAL_AMT
	                                        return
	                                            <LIABILITY_TOTAL_AMT>{ data($LIABILITY_TOTAL_AMT) }</LIABILITY_TOTAL_AMT>
	                                    }
	                                    {
	                                        for $LIABILITY_PAYMENT_DATE in $consultaPasivoResponseRecord/LIABILITY_PAYMENT_DATE
	                                        return
	                                            <LIABILITY_PAYMENT_DATE>{ data($LIABILITY_PAYMENT_DATE) }</LIABILITY_PAYMENT_DATE>
	                                    }
	                                    {
	                                        for $LIABILITY_SOURCE_BANK in $consultaPasivoResponseRecord/LIABILITY_SOURCE_BANK
	                                        return
	                                            <LIABILITY_SOURCE_BANK>{ data($LIABILITY_SOURCE_BANK) }</LIABILITY_SOURCE_BANK>
	                                    }
	                                    {
	                                        for $LIABILITY_CANCELLATION_AMOUNT in $consultaPasivoResponseRecord/LIABILITY_CANCELLATION_AMOUNT
	                                        return
	                                            <LIABILITY_TOTAL_CANCELATION_AMT>{ data($LIABILITY_CANCELLATION_AMOUNT) }</LIABILITY_TOTAL_CANCELATION_AMT>
	                                    }
	                                </ns0:consultaPasivosClienteResponseRecordType>
	                                
	                        }
	                    </ns0:consultaPasivosClientePrestamosResponseType>
	                    )else()
	            }
	            {
	                for $consultaPasivoResponseRecords in $consultaPasivosClienteResponseOUT/ns1:consultaPasivosClienteTCreditoResponseType
	                return
	                   if ($TypeSerch='ALL' or $TypeSerch='TRC' ) then(
	                    <ns0:consultaPasivosClienteTCreditoResponseType>
	                        {
	                            for $consultaPasivoResponseRecord in $consultaPasivoResponseRecords/ns1:consultaPasivosClienteResponseRecordType
	                            return
	                             
	                                <ns0:consultaPasivosClienteResponseRecordType>
	                                    {
	                                        for $LIABILITY_TYPE in $consultaPasivoResponseRecord/LIABILITY_TYPE
	                                        return
	                                            <LIABILITY_TYPE>{ data($LIABILITY_TYPE) }</LIABILITY_TYPE>
	                                    }
	                                    {
	                                        for $LIABILITY_NUMBER in $consultaPasivoResponseRecord/LIABILITY_NUMBER
	                                        return
	                                            <LIABILITY_NUMBER>{ data($LIABILITY_NUMBER) }</LIABILITY_NUMBER>
	                                    }
	                                    {
	                                        for $LIABILITY_CUST_NAME in $consultaPasivoResponseRecord/LIABILITY_CUST_NAME
	                                        return
	                                            <LIABILITY_CUST_NAME>{ data($LIABILITY_CUST_NAME) }</LIABILITY_CUST_NAME>
	                                    }
	                                    {
	                                        for $LIABILITY_CURRENCY_1 in $consultaPasivoResponseRecord/LIABILITY_CURRENCY_1
	                                        return
	                                            <LIABILITY_CURRENCY_1>{ data($LIABILITY_CURRENCY_1) }</LIABILITY_CURRENCY_1>
	                                    }
	                                    {
	                                        for $LIABILITY_PRINCIPAL_AMT_1 in $consultaPasivoResponseRecord/LIABILITY_PRINCIPAL_AMT_1
	                                        return
	                                            <LIABILITY_PRINCIPAL_AMT_1>{ data($LIABILITY_PRINCIPAL_AMT_1) }</LIABILITY_PRINCIPAL_AMT_1>
	                                    }
	                                    {
	                                        for $LIABILITY_INT_COM_AMT_1 in $consultaPasivoResponseRecord/LIABILITY_INT_COM_AMT_1
	                                        return
	                                            <LIABILITY_INT_COM_AMT_1>{ data($LIABILITY_INT_COM_AMT_1) }</LIABILITY_INT_COM_AMT_1>
	                                    }
	                                    {
	                                        for $LIABILITY_TOTAL_AMT_1 in $consultaPasivoResponseRecord/LIABILITY_TOTAL_AMT_1
	                                        return
	                                            <LIABILITY_TOTAL_AMT_1>{ data($LIABILITY_TOTAL_AMT_1) }</LIABILITY_TOTAL_AMT_1>
	                                    }
	                                    {
	                                        for $LIABILITY_CURRENCY_2 in $consultaPasivoResponseRecord/LIABILITY_CURRENCY_2
	                                        return
	                                            <LIABILITY_CURRENCY_2>{ data($LIABILITY_CURRENCY_2) }</LIABILITY_CURRENCY_2>
	                                    }
	                                    {
	                                        for $LIABILITY_PRINCIPAL_AMT_2 in $consultaPasivoResponseRecord/LIABILITY_PRINCIPAL_AMT_2
	                                        return
	                                            <LIABILITY_PRINCIPAL_AMT_2>{ data($LIABILITY_PRINCIPAL_AMT_2) }</LIABILITY_PRINCIPAL_AMT_2>
	                                    }
	                                    {
	                                        for $LIABILITY_INT_COM_AMT_2 in $consultaPasivoResponseRecord/LIABILITY_INT_COM_AMT_2
	                                        return
	                                            <LIABILITY_INT_COM_AMT_2>{ data($LIABILITY_INT_COM_AMT_2) }</LIABILITY_INT_COM_AMT_2>
	                                    }
	                                    {
	                                        for $LIABILITY_TOTAL_AMT_2 in $consultaPasivoResponseRecord/LIABILITY_TOTAL_AMT_2
	                                        return
	                                            <LIABILITY_TOTAL_AMT_2>{ data($LIABILITY_TOTAL_AMT_2) }</LIABILITY_TOTAL_AMT_2>
	                                    }
	                                    {
	                                        for $LIABILITY_TOTAL_AMT in $consultaPasivoResponseRecord/LIABILITY_TOTAL_AMT
	                                        return
	                                            <LIABILITY_TOTAL_AMT>{ data($LIABILITY_TOTAL_AMT) }</LIABILITY_TOTAL_AMT>
	                                    }
	                                    {
	                                        for $LIABILITY_PAYMENT_DATE in $consultaPasivoResponseRecord/LIABILITY_PAYMENT_DATE
	                                        return
	                                            <LIABILITY_PAYMENT_DATE>{ data($LIABILITY_PAYMENT_DATE) }</LIABILITY_PAYMENT_DATE>
	                                    }
	                                    {
	                                        for $LIABILITY_SOURCE_BANK in $consultaPasivoResponseRecord/LIABILITY_SOURCE_BANK
	                                        return
	                                            <LIABILITY_SOURCE_BANK>{ data($LIABILITY_SOURCE_BANK) }</LIABILITY_SOURCE_BANK>
	                                    }
	                                    {
	                                        for $LIABILITY_CANCELLATION_AMOUNT in $consultaPasivoResponseRecord/LIABILITY_CANCELLATION_AMOUNT
	                                        return
	                                            <LIABILITY_TOTAL_CANCELATION_AMT>{ data($LIABILITY_CANCELLATION_AMOUNT) }</LIABILITY_TOTAL_CANCELATION_AMT>
	                                    }
	                                </ns0:consultaPasivosClienteResponseRecordType>
	                        }
	                    </ns0:consultaPasivosClienteTCreditoResponseType>
	                      )else()
	            }
            </ns0:LIABILITIY>
            </ns0:LIABILITIES_INFORMATION>
        </ns0:sjConsultaActivosPasivosClienteResponse>
};

declare variable $consultaPasivosClienteResponseOUT as element(ns1:consultaPasivosClienteResponse) external;
declare variable $TypeSerch as xs:string external;
xf:ConsultPasivosClienteIN($consultaPasivosClienteResponseOUT,
$TypeSerch
)