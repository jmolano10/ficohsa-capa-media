xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultactascorrienteporclienteResponse1" element="ns0:ConsultactascorrienteporclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadectasahorroporclienteResponse1" element="ns0:ConsultadectasahorroporclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaActivosClienteResponse" location="sjConsultaActivosCliente.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaActivosCliente/sjConsultaCuentasOut/";

declare function xf:sjConsultaCuentasOut($consultactascorrienteporclienteResponse1 as element(ns0:ConsultactascorrienteporclienteResponse),
    $consultadectasahorroporclienteResponse1 as element(ns0:ConsultadectasahorroporclienteResponse))
    as element(ns1:sjConsultaActivosClienteResponse) {
        <ns1:sjConsultaActivosClienteResponse>
            <ns1:consultaCuentaAhorrosResponse>
                {
                    for $successIndicator in $consultadectasahorroporclienteResponse1/Status/successIndicator
                    return
                        <ns1:successIndicator>{ data($successIndicator) }</ns1:successIndicator>
                }
                {
                    for $messages in $consultadectasahorroporclienteResponse1/Status/messages
                    return
                        <ns1:messages>{ data($messages) }</ns1:messages>
                }
                <ns1:consultaActivoResponseRecords>
                    {
                        for $mWSFICOLINKSAVINGSACCTDetailType in $consultadectasahorroporclienteResponse1/WSFICOLINKSAVINGSACCTType[1]/gWSFICOLINKSAVINGSACCTDetailType/mWSFICOLINKSAVINGSACCTDetailType
                        return
                            <ns1:consultaActivoResponseRecord>
                                {
                                    let $ACCOUNTNUMBER := $mWSFICOLINKSAVINGSACCTDetailType/ACCOUNTNUMBER/text()
                                    let $ALTACCTID := $mWSFICOLINKSAVINGSACCTDetailType/ALTACCTID/text()
                                    return
                                    if (fn:exists($ALTACCTID)) then (
                                        <ns1:ACCOUNTNUMBER>{ $ALTACCTID }</ns1:ACCOUNTNUMBER>
                                    ) else (
                                    	<ns1:ACCOUNTNUMBER>{ concat("000000", $ACCOUNTNUMBER) }</ns1:ACCOUNTNUMBER>
                                    )
                                        
                                }
                                {
                                    for $ACCOUNTTITLE in $mWSFICOLINKSAVINGSACCTDetailType/ACCOUNTTITLE
                                    return
                                        <ns1:ACCOUNTNAME>{ data($ACCOUNTTITLE) }</ns1:ACCOUNTNAME>
                                }                                
                                {
                                    for $CURRENCY in $mWSFICOLINKSAVINGSACCTDetailType/CURRENCY
                                    return
                                        <ns1:CURRENCY>{ data($CURRENCY) }</ns1:CURRENCY>
                                }
                                {
                                    for $TOTALBALANCE in $mWSFICOLINKSAVINGSACCTDetailType/TOTALBALANCE
                                    return
                                        <ns1:TOTALBALANCE>{ data($TOTALBALANCE) }</ns1:TOTALBALANCE>
                                }
                                {
                                    for $RESERVEBALANCE in $mWSFICOLINKSAVINGSACCTDetailType/RESERVEBALANCE
                                    return
                                        <ns1:RESERVEBALANCE>{ data($RESERVEBALANCE) }</ns1:RESERVEBALANCE>
                                }
                                {
                                    for $LIENBALANCE in $mWSFICOLINKSAVINGSACCTDetailType/LIENBALANCE
                                    return
                                        <ns1:LIENBALANCE>{ data($LIENBALANCE) }</ns1:LIENBALANCE>
                                }
                                {
                                    for $BLOCKEDFUNDSPOS in $mWSFICOLINKSAVINGSACCTDetailType/BLOCKEDFUNDSPOS
                                    return
                                        <ns1:BLOCKEDFUNDSPOS>{ data($BLOCKEDFUNDSPOS) }</ns1:BLOCKEDFUNDSPOS>
                                }
                                {
                                    for $BLOCKEDFUNDSATM in $mWSFICOLINKSAVINGSACCTDetailType/BLOCKEDFUNDSATM
                                    return
                                        <ns1:BLOCKEDFUNDSATM>{ data($BLOCKEDFUNDSATM) }</ns1:BLOCKEDFUNDSATM>
                                }
                                {
                                    for $AVAILABLEBAL in $mWSFICOLINKSAVINGSACCTDetailType/AVAILABLEBAL
                                    return
                                        <ns1:AVAILABLEBAL>{ data($AVAILABLEBAL) }</ns1:AVAILABLEBAL>
                                }
                            </ns1:consultaActivoResponseRecord>
                    }
                </ns1:consultaActivoResponseRecords>
            </ns1:consultaCuentaAhorrosResponse>
            <ns1:consultaCuentaCorrienteResponse>
                {
                    for $successIndicator in $consultactascorrienteporclienteResponse1/Status/successIndicator
                    return
                        <ns1:successIndicator>{ data($successIndicator) }</ns1:successIndicator>
                }
                {
                    for $messages in $consultactascorrienteporclienteResponse1/Status/messages
                    return
                        <ns1:messages>{ data($messages) }</ns1:messages>
                }
                <ns1:consultaActivoResponseRecords>
                    {
                        for $mWSFICOLINKCURRENTACCTDetailType in $consultactascorrienteporclienteResponse1/WSFICOLINKCURRENTACCTType[1]/gWSFICOLINKCURRENTACCTDetailType/mWSFICOLINKCURRENTACCTDetailType
                        return
                            <ns1:consultaActivoResponseRecord>
                                {
                                    let $ACCOUNTNUMBER := $mWSFICOLINKCURRENTACCTDetailType/ACCOUNTNUMBER/text()
                                    let $ALTACCTID := $mWSFICOLINKCURRENTACCTDetailType/ALTACCTID/text()
                                    return
                                    if (fn:exists($ALTACCTID)) then (
                                        <ns1:ACCOUNTNUMBER>{ $ALTACCTID }</ns1:ACCOUNTNUMBER>
                                    ) else (
                                    	<ns1:ACCOUNTNUMBER>{ concat("000000", $ACCOUNTNUMBER) }</ns1:ACCOUNTNUMBER>
                                    )
                                }
                                {
                                    for $ACCOUNTNAME in $mWSFICOLINKCURRENTACCTDetailType/ACCOUNTNAME
                                    return
                                        <ns1:ACCOUNTNAME>{ data($ACCOUNTNAME) }</ns1:ACCOUNTNAME>
                                }                                 
                                {
                                    for $CURRENCY in $mWSFICOLINKCURRENTACCTDetailType/CURRENCY
                                    return
                                        <ns1:CURRENCY>{ data($CURRENCY) }</ns1:CURRENCY>
                                }
                                {
                                    for $TOTALBALANCE in $mWSFICOLINKCURRENTACCTDetailType/TOTALBALANCE
                                    return
                                        <ns1:TOTALBALANCE>{ data($TOTALBALANCE) }</ns1:TOTALBALANCE>
                                }
                                {
                                    for $RESERVEBALANCE in $mWSFICOLINKCURRENTACCTDetailType/RESERVEBALANCE
                                    return
                                        <ns1:RESERVEBALANCE>{ data($RESERVEBALANCE) }</ns1:RESERVEBALANCE>
                                }
                                {
                                    for $LIENBALANCE in $mWSFICOLINKCURRENTACCTDetailType/LIENBALANCE
                                    return
                                        <ns1:LIENBALANCE>{ data($LIENBALANCE) }</ns1:LIENBALANCE>
                                }
                                {
                                    for $BLOCKEDFUNDSPOS in $mWSFICOLINKCURRENTACCTDetailType/BLOCKEDFUNDSPOS
                                    return
                                        <ns1:BLOCKEDFUNDSPOS>{ data($BLOCKEDFUNDSPOS) }</ns1:BLOCKEDFUNDSPOS>
                                }
                                {
                                    for $BLOCKEDFUNDSATM in $mWSFICOLINKCURRENTACCTDetailType/BLOCKEDFUNDSATM
                                    return
                                        <ns1:BLOCKEDFUNDSATM>{ data($BLOCKEDFUNDSATM) }</ns1:BLOCKEDFUNDSATM>
                                }
                                {
                                    for $AVAILABLEBALANCE in $mWSFICOLINKCURRENTACCTDetailType/AVAILABLEBALANCE
                                    return
                                        <ns1:AVAILABLEBAL>{ data($AVAILABLEBALANCE) }</ns1:AVAILABLEBAL>
                                }
                            </ns1:consultaActivoResponseRecord>
                    }
                </ns1:consultaActivoResponseRecords>
            </ns1:consultaCuentaCorrienteResponse>
        </ns1:sjConsultaActivosClienteResponse>
};

declare variable $consultactascorrienteporclienteResponse1 as element(ns0:ConsultactascorrienteporclienteResponse) external;
declare variable $consultadectasahorroporclienteResponse1 as element(ns0:ConsultadectasahorroporclienteResponse) external;

xf:sjConsultaCuentasOut($consultactascorrienteporclienteResponse1,
    $consultadectasahorroporclienteResponse1)