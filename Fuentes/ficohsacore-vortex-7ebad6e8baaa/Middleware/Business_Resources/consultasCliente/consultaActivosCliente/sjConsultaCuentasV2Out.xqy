xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaCuentaAhorroxClienteResponse1" element="ns1:ConsultaCuentaAhorroxClienteResponse" location="ConsultaCuentasCliente/xsd/services_1.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaCuentaCorrientexClienteResponse1" element="ns1:ConsultaCuentaCorrientexClienteResponse" location="ConsultaCuentasCliente/xsd/services_1.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaActivosClienteResponse" location="sjConsultaActivosCliente.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaActivosCliente/sjConsultaCuentasV2Out/";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";

declare function xf:sjConsultaCuentasV2Out($consultaCuentaAhorroxClienteResponse1 as element(ns1:ConsultaCuentaAhorroxClienteResponse),
    $consultaCuentaCorrientexClienteResponse1 as element(ns1:ConsultaCuentaCorrientexClienteResponse))
    as element(ns0:sjConsultaActivosClienteResponse) {
      <ns0:sjConsultaActivosClienteResponse>
            <ns0:consultaCuentaAhorrosResponse>
                {
                    for $successIndicator in $consultaCuentaAhorroxClienteResponse1/Status/successIndicator
                    return
                        <ns0:successIndicator>{ data($successIndicator) }</ns0:successIndicator>
                }
                {
                    for $messages in $consultaCuentaAhorroxClienteResponse1/Status/messages
                    return
                        <ns0:messages>{ data($messages) }</ns0:messages>
                }
                <ns0:consultaActivoResponseRecords>
                    {
                        for $mWSFICOLINKSAVINGSACCOUNTDetailType in $consultaCuentaAhorroxClienteResponse1/WSFICOLINKSAVINGSACCOUNTType[1]/gWSFICOLINKSAVINGSACCOUNTDetailType/mWSFICOLINKSAVINGSACCOUNTDetailType
                        return
                            <ns0:consultaActivoResponseRecord>
                                {
                                    let $ACCOUNTNUMBER := $mWSFICOLINKSAVINGSACCOUNTDetailType/ACCOUNTNUMBER/text()
                                    let $ALTACCTID := $mWSFICOLINKSAVINGSACCOUNTDetailType/ALTACCTID/text()
                                    return
                                    if (fn:exists($ALTACCTID)) then (
                                        <ns0:ACCOUNTNUMBER>{ $ALTACCTID }</ns0:ACCOUNTNUMBER>
                                    ) else (
                                    	<ns0:ACCOUNTNUMBER>{$ACCOUNTNUMBER}</ns0:ACCOUNTNUMBER>
                                    )
                                        
                                }
                                {
                                    for $ACCOUNTTITLE in $mWSFICOLINKSAVINGSACCOUNTDetailType/ACCOUNTTITLE
                                    return
                                        <ns0:ACCOUNTNAME>{ data($ACCOUNTTITLE) }</ns0:ACCOUNTNAME>
                                }                                
                                {
                                    for $CURRENCY in $mWSFICOLINKSAVINGSACCOUNTDetailType/CURRENCY
                                    return
                                        <ns0:CURRENCY>{ data($CURRENCY) }</ns0:CURRENCY>
                                }
                                {
                                    for $TOTALBALANCE in $mWSFICOLINKSAVINGSACCOUNTDetailType/TOTALBALANCE
                                    return
                                        <ns0:TOTALBALANCE>{ data($TOTALBALANCE) }</ns0:TOTALBALANCE>
                                }
                                {
                                    for $RESERVEBALANCE in $mWSFICOLINKSAVINGSACCOUNTDetailType/RESERVEBALANCE
                                    return
                                        <ns0:RESERVEBALANCE>{ data($RESERVEBALANCE) }</ns0:RESERVEBALANCE>
                                }
                                {
                                    for $LIENBALANCE in $mWSFICOLINKSAVINGSACCOUNTDetailType/LIENBALANCE
                                    return
                                        <ns0:LIENBALANCE>{ data($LIENBALANCE) }</ns0:LIENBALANCE>
                                }
                                {
                                    for $BLOCKEDFUNDSPOS in $mWSFICOLINKSAVINGSACCOUNTDetailType/BLOCKEDFUNDSPOS
                                    return
                                        <ns0:BLOCKEDFUNDSPOS>{ data($BLOCKEDFUNDSPOS) }</ns0:BLOCKEDFUNDSPOS>
                                }
                                {
                                    for $BLOCKEDFUNDSATM in $mWSFICOLINKSAVINGSACCOUNTDetailType/BLOCKEDFUNDSATM
                                    return
                                        <ns0:BLOCKEDFUNDSATM>{ data($BLOCKEDFUNDSATM) }</ns0:BLOCKEDFUNDSATM>
                                }
                                {
                                    for $AVAILABLEBAL in $mWSFICOLINKSAVINGSACCOUNTDetailType/AVAILABLEBAL
                                    return
                                        <ns0:AVAILABLEBAL>{ data($AVAILABLEBAL) }</ns0:AVAILABLEBAL>
                                }
                                {
                                    for $OPENINGDATE in $mWSFICOLINKSAVINGSACCOUNTDetailType/OPENINGDATE
                                    return
                                        <ns0:OPENINGDATE>{ data($OPENINGDATE) }</ns0:OPENINGDATE>
                                }
                                {
                                    for $RECORDSTATUS in $mWSFICOLINKSAVINGSACCOUNTDetailType/INACTIVMARKER
                                    return
                                        <ns0:INACTIVMARKER>{ data($RECORDSTATUS) }</ns0:INACTIVMARKER>
                                }
                            </ns0:consultaActivoResponseRecord>
                    }
                </ns0:consultaActivoResponseRecords>
            </ns0:consultaCuentaAhorrosResponse>
            <ns0:consultaCuentaCorrienteResponse>
                {
                    for $successIndicator in $consultaCuentaCorrientexClienteResponse1/Status/successIndicator
                    return
                        <ns0:successIndicator>{ data($successIndicator) }</ns0:successIndicator>
                }
                {
                    for $messages in $consultaCuentaCorrientexClienteResponse1/Status/messages
                    return
                        <ns0:messages>{ data($messages) }</ns0:messages>
                }
                <ns0:consultaActivoResponseRecords>
                    {
                        for $mWSFICOLINKCURRENTACCOUNTDetailType in $consultaCuentaCorrientexClienteResponse1/WSFICOLINKCURRENTACCOUNTType[1]/gWSFICOLINKCURRENTACCOUNTDetailType/mWSFICOLINKCURRENTACCOUNTDetailType
                        return
                            <ns0:consultaActivoResponseRecord>
                                {
                                    let $ACCOUNTNUMBER := $mWSFICOLINKCURRENTACCOUNTDetailType/ACCOUNTNUMBER/text()
                                    let $ALTACCTID := $mWSFICOLINKCURRENTACCOUNTDetailType/ALTACCTID/text()
                                    return
                                    if (fn:exists($ALTACCTID)) then (
                                        <ns0:ACCOUNTNUMBER>{ $ALTACCTID }</ns0:ACCOUNTNUMBER>
                                    ) else (
                                    	<ns0:ACCOUNTNUMBER>{ $ACCOUNTNUMBER }</ns0:ACCOUNTNUMBER>
                                    )
                                }
                                {
                                    for $ACCOUNTNAME in $mWSFICOLINKCURRENTACCOUNTDetailType/ACCOUNTNAME
                                    return
                                        <ns0:ACCOUNTNAME>{ data($ACCOUNTNAME) }</ns0:ACCOUNTNAME>
                                }                                 
                                {
                                    for $CURRENCY in $mWSFICOLINKCURRENTACCOUNTDetailType/CURRENCY
                                    return
                                        <ns0:CURRENCY>{ data($CURRENCY) }</ns0:CURRENCY>
                                }
                                {
                                    for $TOTALBALANCE in $mWSFICOLINKCURRENTACCOUNTDetailType/TOTALBALANCE
                                    return
                                        <ns0:TOTALBALANCE>{ data($TOTALBALANCE) }</ns0:TOTALBALANCE>
                                }
                                {
                                    for $RESERVEBALANCE in $mWSFICOLINKCURRENTACCOUNTDetailType/RESERVEBALANCE
                                    return
                                        <ns0:RESERVEBALANCE>{ data($RESERVEBALANCE) }</ns0:RESERVEBALANCE>
                                }
                                {
                                    for $LIENBALANCE in $mWSFICOLINKCURRENTACCOUNTDetailType/LIENBALANCE
                                    return
                                        <ns0:LIENBALANCE>{ data($LIENBALANCE) }</ns0:LIENBALANCE>
                                }
                                {
                                    for $BLOCKEDFUNDSPOS in $mWSFICOLINKCURRENTACCOUNTDetailType/BLOCKEDFUNDSPOS
                                    return
                                        <ns0:BLOCKEDFUNDSPOS>{ data($BLOCKEDFUNDSPOS) }</ns0:BLOCKEDFUNDSPOS>
                                }
                                {
                                    for $BLOCKEDFUNDSATM in $mWSFICOLINKCURRENTACCOUNTDetailType/BLOCKEDFUNDSATM
                                    return
                                        <ns0:BLOCKEDFUNDSATM>{ data($BLOCKEDFUNDSATM) }</ns0:BLOCKEDFUNDSATM>
                                }
                                {
                                    for $AVAILABLEBALANCE in $mWSFICOLINKCURRENTACCOUNTDetailType/AVAILABLEBALANCE
                                    return
                                        <ns0:AVAILABLEBAL>{ data($AVAILABLEBALANCE) }</ns0:AVAILABLEBAL>
                                }
                                {
                                    for $OPENINGDATE in $mWSFICOLINKCURRENTACCOUNTDetailType/OPENINGDATE
                                    return
                                        <ns0:OPENINGDATE>{ data($OPENINGDATE) }</ns0:OPENINGDATE>
                                }
                                {
                                    for $RECORDSTATUS in $mWSFICOLINKCURRENTACCOUNTDetailType/INACTIVMARKER
                                    return
                                        <ns0:INACTIVMARKER>{ data($RECORDSTATUS) }</ns0:INACTIVMARKER>
                                }
                            </ns0:consultaActivoResponseRecord>
                    }
                </ns0:consultaActivoResponseRecords>
            </ns0:consultaCuentaCorrienteResponse>
        </ns0:sjConsultaActivosClienteResponse>
};

declare variable $consultaCuentaAhorroxClienteResponse1 as element(ns1:ConsultaCuentaAhorroxClienteResponse) external;
declare variable $consultaCuentaCorrientexClienteResponse1 as element(ns1:ConsultaCuentaCorrientexClienteResponse) external;

xf:sjConsultaCuentasV2Out($consultaCuentaAhorroxClienteResponse1,
    $consultaCuentaCorrientexClienteResponse1)