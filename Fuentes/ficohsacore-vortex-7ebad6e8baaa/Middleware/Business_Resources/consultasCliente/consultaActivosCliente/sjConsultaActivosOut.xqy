xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaActivosClienteResponse1" element="ns0:sjConsultaActivosClienteResponse" location="sjConsultaActivosCliente.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadecertifdepporclienteResponse1" element="ns1:ConsultadecertifdepporclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaActivosClienteResponse" location="sjConsultaActivosCliente.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaActivosCliente/sjConsultaActivosOut/";

declare function xf:sjConsultaActivosOut($sjConsultaActivosClienteResponse1 as element(ns0:sjConsultaActivosClienteResponse),
    $consultadecertifdepporclienteResponse1 as element(ns1:ConsultadecertifdepporclienteResponse))
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
	                                	<ns0:ACCOUNTNUMBER>{ concat("000000", $DEPOSITNUMBER) }</ns0:ACCOUNTNUMBER>
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
        </ns0:sjConsultaActivosClienteResponse>
};

declare variable $sjConsultaActivosClienteResponse1 as element(ns0:sjConsultaActivosClienteResponse) external;
declare variable $consultadecertifdepporclienteResponse1 as element(ns1:ConsultadecertifdepporclienteResponse) external;

xf:sjConsultaActivosOut($sjConsultaActivosClienteResponse1,
    $consultadecertifdepporclienteResponse1)