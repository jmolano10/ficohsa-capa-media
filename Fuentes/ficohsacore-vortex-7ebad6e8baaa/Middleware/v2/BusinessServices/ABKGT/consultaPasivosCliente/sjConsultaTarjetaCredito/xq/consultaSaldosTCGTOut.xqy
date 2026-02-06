xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultarTarjetasCreditoResponse1" element="ns1:ConsultarTarjetasCreditoResponse" location="../../../transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCreditoResponse1" element="ns0:consultaSaldosTarjetaCreditoResponse" location="../../../../../../Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultaPasivosClienteResponse" location="../../../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaPasivosCliente/sjConsultaTarjetaCredito/consultaSaldosTArjetaCreditoOut/";

declare function xf:consultaSaldosTArjetaCreditoOut($consultaSaldosTarjetaCreditoResponse1 as element(ns0:consultaSaldosTarjetaCreditoResponse))
    as element(ns2:consultaPasivosClienteResponse) {
        <ns2:consultaPasivosClienteResponse>
            <ns2:consultaPasivosClienteTCreditoResponseType>
                <ns2:consultaPasivosClienteResponseRecordType>
                    <LIABILITY_TYPE>TRC</LIABILITY_TYPE>
                    {
                        for $CARD_NUMBER in $consultaSaldosTarjetaCreditoResponse1/CARD_NUMBER
                        return
                            <LIABILITY_NUMBER>{ data($CARD_NUMBER) }</LIABILITY_NUMBER>
                    }
                    {
                        for $CARD_HOLDER_NAME in $consultaSaldosTarjetaCreditoResponse1/CARD_HOLDER_NAME
                        return
                            <LIABILITY_CUST_NAME>{ data($CARD_HOLDER_NAME) }</LIABILITY_CUST_NAME>
                    }
                    {
                        for $CURRENCY in $consultaSaldosTarjetaCreditoResponse1/ns0:consultaSaldosTarjetaCreditoResponseType/ns0:consultaSaldosTarjetaCreditoResponseRecordType[1]/CURRENCY
                        return
                            <LIABILITY_CURRENCY_1>{ data($CURRENCY) }</LIABILITY_CURRENCY_1>
                    }
                    {
                        for $CURRENT_BALANCE in $consultaSaldosTarjetaCreditoResponse1/ns0:consultaSaldosTarjetaCreditoResponseType/ns0:consultaSaldosTarjetaCreditoResponseRecordType[1]/CURRENT_BALANCE
                        return
                            <LIABILITY_PRINCIPAL_AMT_1>{ data($CURRENT_BALANCE) }</LIABILITY_PRINCIPAL_AMT_1>
                    }
                    {
                        for $CURRENT_BALANCE in $consultaSaldosTarjetaCreditoResponse1/ns0:consultaSaldosTarjetaCreditoResponseType/ns0:consultaSaldosTarjetaCreditoResponseRecordType[1]/CURRENT_BALANCE
                        return
                            <LIABILITY_TOTAL_AMT_1>{ data($CURRENT_BALANCE) }</LIABILITY_TOTAL_AMT_1>
                    }
                    {
                        for $CURRENCY in $consultaSaldosTarjetaCreditoResponse1/ns0:consultaSaldosTarjetaCreditoResponseType/ns0:consultaSaldosTarjetaCreditoResponseRecordType[2]/CURRENCY
                        return
                            <LIABILITY_CURRENCY_2>{ data($CURRENCY) }</LIABILITY_CURRENCY_2>
                    }
                    {
                        for $CURRENT_BALANCE in $consultaSaldosTarjetaCreditoResponse1/ns0:consultaSaldosTarjetaCreditoResponseType/ns0:consultaSaldosTarjetaCreditoResponseRecordType[2]/CURRENT_BALANCE
                        return
                            <LIABILITY_PRINCIPAL_AMT_2>{ data($CURRENT_BALANCE) }</LIABILITY_PRINCIPAL_AMT_2>
                    }
                    {
                        for $CURRENT_BALANCE in $consultaSaldosTarjetaCreditoResponse1/ns0:consultaSaldosTarjetaCreditoResponseType/ns0:consultaSaldosTarjetaCreditoResponseRecordType[2]/CURRENT_BALANCE
                        return
                            <LIABILITY_TOTAL_AMT_2>{ data($CURRENT_BALANCE) }</LIABILITY_TOTAL_AMT_2>
                    }
                </ns2:consultaPasivosClienteResponseRecordType>
            </ns2:consultaPasivosClienteTCreditoResponseType>
        </ns2:consultaPasivosClienteResponse>
};

declare variable $consultaSaldosTarjetaCreditoResponse1 as element(ns0:consultaSaldosTarjetaCreditoResponse) external;

xf:consultaSaldosTArjetaCreditoOut($consultaSaldosTarjetaCreditoResponse1)