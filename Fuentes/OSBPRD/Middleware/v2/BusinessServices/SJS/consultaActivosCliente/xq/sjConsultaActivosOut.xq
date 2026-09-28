(:: pragma bea:global-element-parameter parameter="$sjConsultaActivosClienteResponse1" element="ns0:sjConsultaActivosClienteResponse" location="../xsd/sjConsultaActivosCliente.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadecertifdepporclienteResponse1" element="ns1:ConsultadecertifdepporclienteResponse" location="../../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaActivosClienteResponse" location="../xsd/sjConsultaActivosCliente.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../ConsultaFondoPensiones12c/xsd/GetAssetsCustomerTypes.xsd" ::)

declare namespace ns2 = "https://www.ficohsa.com/regional/pension";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaActivosCliente/sjConsultaActivosOut/";

declare function xf:sjConsultaActivosOut($sjConsultaActivosClienteResponse1 as element(ns0:sjConsultaActivosClienteResponse),
    $consultadecertifdepporclienteResponse1 as element(ns1:ConsultadecertifdepporclienteResponse),
    $outputParameters as element(ns2:OutputParameters))
    as element(ns0:sjConsultaActivosClienteResponse) {
        <ns0:sjConsultaActivosClienteResponse>
            {
                for $consultaCuentaAhorrosResponse in $sjConsultaActivosClienteResponse1/ns0:consultaCuentaAhorrosResponse
                return
                    <ns0:consultaCuentaAhorrosResponse>{ $consultaCuentaAhorrosResponse/@* , $consultaCuentaAhorrosResponse/node() }</ns0:consultaCuentaAhorrosResponse>
            }
            {
                for $consultaCuentaCorrienteResponse in $sjConsultaActivosClienteResponse1/ns0:consultaCuentaCorrienteResponse
                return
                    <ns0:consultaCuentaCorrienteResponse>{ $consultaCuentaCorrienteResponse/@* , $consultaCuentaCorrienteResponse/node() }</ns0:consultaCuentaCorrienteResponse>
            }
            <ns0:consultaCertifDepositoResponse>
                {
                    for $successIndicator in $consultadecertifdepporclienteResponse1/Status/successIndicator
                    return
                        <ns0:successIndicator>{ data($successIndicator) }</ns0:successIndicator>
                }
                {
                    for $messages in $consultadecertifdepporclienteResponse1/Status/messages
                    return
                        <ns0:messages>{ data($messages) }</ns0:messages>
                }
                <ns0:consultaActivoResponseRecords>
                    {
                        for $mWSFICOTERMDEPOSITDetailType in $consultadecertifdepporclienteResponse1/WSFICOTERMDEPOSITType[1]/gWSFICOTERMDEPOSITDetailType/mWSFICOTERMDEPOSITDetailType
                        return
                            <ns0:consultaActivoResponseRecord>
                                {
                                    let $DEPOSITNUMBER := $mWSFICOTERMDEPOSITDetailType/DEPOSITNUMBER/text()
                                	let $ALTACCTID := $mWSFICOTERMDEPOSITDetailType/ALTACCTID/text()
	                                return
	                                if ( exists($ALTACCTID) ) then (
	                                	<ns0:ACCOUNTNUMBER>{ $ALTACCTID }</ns0:ACCOUNTNUMBER>
	                                ) else (
	                                	<ns0:ACCOUNTNUMBER>{ $DEPOSITNUMBER }</ns0:ACCOUNTNUMBER>
	                                )   
                                }
                                {
                                    for $CUSTOMERNAME in $mWSFICOTERMDEPOSITDetailType/CUSTOMERNAME
                                    return
                                        <ns0:ACCOUNTNAME>{ data($CUSTOMERNAME) }</ns0:ACCOUNTNAME>
                                }
                                {
                                    for $CURRENCY in $mWSFICOTERMDEPOSITDetailType/CURRENCY
                                    return
                                        <ns0:CURRENCY>{ data($CURRENCY) }</ns0:CURRENCY>
                                }
                                {
                                    for $AMOUNT in $mWSFICOTERMDEPOSITDetailType/AMOUNT
                                    return
                                        <ns0:TOTALBALANCE>{ data($AMOUNT) }</ns0:TOTALBALANCE>
                                }
                                {
                                    for $AMOUNT in $mWSFICOTERMDEPOSITDetailType/AMOUNT
                                    return
                                        <ns0:AVAILABLEBAL>{ data($AMOUNT) }</ns0:AVAILABLEBAL>
                                }
                            </ns0:consultaActivoResponseRecord>
                    }
                </ns0:consultaActivoResponseRecords>
            </ns0:consultaCertifDepositoResponse>
             <ns0:consultaActivosClientePensionesResponseType>
                {
                    for $Status in $outputParameters/StatusInfo/Status
                    return
                        <ns0:successIndicator>{ data($Status) }</ns0:successIndicator>
                }
                {
                    for $Messages in $outputParameters/ErrorInfo/Details/Messages
                    return
                        <ns0:messages>{ data($Messages) }</ns0:messages>
                }
                <ns0:consultaActivoResponseRecords>
                    {
                        for $CUENTA in $outputParameters/PT_CUENTAS/CUENTA
                        return(
                        	<ns0:consultaActivoResponseRecord>
                                {
                                    for $NUMERO_CUENTA in $CUENTA/NUMERO_CUENTA
                                    return
                                        <ns0:ACCOUNTNUMBER>{ data($NUMERO_CUENTA) }</ns0:ACCOUNTNUMBER>
                                }
                                {
                                    for $DESCRIPCION_CUENTA in $CUENTA/DESCRIPCION_CUENTA
                                    return
                                        <ns0:ACCOUNTNAME>{ data($DESCRIPCION_CUENTA) }</ns0:ACCOUNTNAME>
                                }
                                {
                                    for $MONEDA in $CUENTA/MONEDA
                                    return
                                        <ns0:CURRENCY>{ data($MONEDA) }</ns0:CURRENCY>
                                }
                                {
                                    for $SALDO_TOTAL in $CUENTA/SALDO_TOTAL
                                    return
                                        <ns0:TOTALBALANCE>{ data($SALDO_TOTAL) }</ns0:TOTALBALANCE>
                                }
                            </ns0:consultaActivoResponseRecord>	
                        )
                    }
                </ns0:consultaActivoResponseRecords>
            </ns0:consultaActivosClientePensionesResponseType>
        </ns0:sjConsultaActivosClienteResponse>
};

declare variable $sjConsultaActivosClienteResponse1 as element(ns0:sjConsultaActivosClienteResponse) external;
declare variable $consultadecertifdepporclienteResponse1 as element(ns1:ConsultadecertifdepporclienteResponse) external;
declare variable $outputParameters as element(ns2:OutputParameters) external;

xf:sjConsultaActivosOut($sjConsultaActivosClienteResponse1,
    $consultadecertifdepporclienteResponse1,
    $outputParameters)