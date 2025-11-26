(:: pragma bea:global-element-parameter parameter="$consultaPasivosClienteResponse1" element="ns0:consultaPasivosClienteResponse" location="../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaPasivosClienteResponse" location="../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaPasivosCliente/xq/sjConsultaTarjetaCreditoAllOut/";

declare function xf:sjConsultaTarjetaCreditoAllOut($consultaPasivosClienteResponse1 as element(ns0:consultaPasivosClienteResponse),
    $tasaCambio as xs:string)
    as element(ns0:consultaPasivosClienteResponse) {
        <ns0:consultaPasivosClienteResponse>
            {
                for $consultaPasivosClientePrestamosResponseType in $consultaPasivosClienteResponse1/ns0:consultaPasivosClientePrestamosResponseType
                return
                    <ns0:consultaPasivosClientePrestamosResponseType>
                        {
                            for $consultaPasivosClienteResponseRecordType in $consultaPasivosClientePrestamosResponseType/ns0:consultaPasivosClienteResponseRecordType
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
                    </ns0:consultaPasivosClientePrestamosResponseType>
            }
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
                                    	let $saldoLocal  := data($consultaPasivosClienteResponseRecordType/LIABILITY_PRINCIPAL_AMT_1)
				    					let $saldoExtr   := data($consultaPasivosClienteResponseRecordType/LIABILITY_PRINCIPAL_AMT_2)
				    					let $saldoTotal	 := fn-bea:format-number(fn:round-half-to-even($saldoLocal + ( $saldoExtr * number($tasaCambio)), 2),"######0.00")
                                    
                                        return
                                            <LIABILITY_TOTAL_AMT>{ data($saldoTotal) }</LIABILITY_TOTAL_AMT>
                                    }
                                </ns0:consultaPasivosClienteResponseRecordType>
                        }
                    </ns0:consultaPasivosClienteTCreditoResponseType>
            }
        </ns0:consultaPasivosClienteResponse>
};

declare variable $consultaPasivosClienteResponse1 as element(ns0:consultaPasivosClienteResponse) external;
declare variable $tasaCambio as xs:string external;

xf:sjConsultaTarjetaCreditoAllOut($consultaPasivosClienteResponse1,
    $tasaCambio)