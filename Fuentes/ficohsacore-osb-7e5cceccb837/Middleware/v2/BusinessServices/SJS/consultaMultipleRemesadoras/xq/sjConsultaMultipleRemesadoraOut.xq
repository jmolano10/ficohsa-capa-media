(:: pragma bea:global-element-parameter parameter="$sjConsultaMultipleRemesadoras" element="ns1:sjConsultaMultipleRemesadoras" location="../xsd/sjConsultaMultipleRemesadoras.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$serviceResponse" type="ns0:serviceResponse" location="../../../enrutadorConvenios/xsd/XMLSchema_-1423180259.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaMultipleRemesadorasResponse" location="../xsd/sjConsultaMultipleRemesadoras.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleRemesadoras";
declare namespace ns0 = "http://service.webserviceprovider.transporters.service.frametexx.com/";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadoras/xq/sjConsultaMultipleRemesadoraOut/";

declare function xf:sjConsultaMultipleRemesadoraOut($sjConsultaMultipleRemesadoras as element(ns1:sjConsultaMultipleRemesadoras),
    $serviceResponse as element(),
    $remittancePosition as xs:int)
    as element(ns1:sjConsultaMultipleRemesadorasResponse) {
        <ns1:sjConsultaMultipleRemesadorasResponse>
            <ns1:REMITTANCE>
                {
                    let $result :=
                        for $serviceResponse in $serviceResponse,
                            $TYPES_REMITTANCE_ITEM in $sjConsultaMultipleRemesadoras/ns1:TYPES_REMITTANCE/ns1:TYPES_REMITTANCE_ITEM,
                            $TYPES_REMITTANCE in $sjConsultaMultipleRemesadoras/ns1:TYPES_REMITTANCE
                        return
                            <ns1:ROUTER_RESPONSE>
                                {
                                    for $NAME_REMITTANCE in $TYPES_REMITTANCE/ns1:TYPES_REMITTANCE_ITEM[$remittancePosition]/ns1:NAME_REMITTANCE
                                    return
                                        <ns1:NAME_REMITTANCE>{ data($NAME_REMITTANCE) }</ns1:NAME_REMITTANCE>
                                }
                                {
                                    for $TYPE_REMITTANCE in $TYPES_REMITTANCE/ns1:TYPES_REMITTANCE_ITEM[$remittancePosition]/ns1:TYPE_REMITTANCE
                                    return
                                        <ns1:TYPE_REMITTANCE>{ data($TYPE_REMITTANCE) }</ns1:TYPE_REMITTANCE>
                                }
                                {
                                    for $AGREEMENT_ID in $TYPES_REMITTANCE/ns1:TYPES_REMITTANCE_ITEM[$remittancePosition]/ns1:AGREEMENT_ID
                                    return
                                        <ns1:AGREEMENT_ID>{ data($AGREEMENT_ID) }</ns1:AGREEMENT_ID>
                                }
                                {
                                    for $AGREEMENT_ID_T24 in $TYPES_REMITTANCE/ns1:TYPES_REMITTANCE_ITEM[$remittancePosition]/ns1:AGREEMENT_ID_T24
                                    return
                                        <ns1:AGREEMENT_ID_T24>{ data($AGREEMENT_ID_T24) }</ns1:AGREEMENT_ID_T24>
                                }
                                {
                                    for $ABBREVIATION_REMITTANCE in $TYPES_REMITTANCE/ns1:TYPES_REMITTANCE_ITEM[$remittancePosition]/ns1:ABBREVIATION_REMITTANCE
                                    return
                                        <ns1:ABBREVIATION_REMITTANCE>{ data($ABBREVIATION_REMITTANCE) }</ns1:ABBREVIATION_REMITTANCE>
                                }
                                {
                                    for $PRIORITY in $TYPES_REMITTANCE/ns1:TYPES_REMITTANCE_ITEM[$remittancePosition]/ns1:PRIORITY
                                    return
                                        <ns1:PRIORITY>{ data($PRIORITY) }</ns1:PRIORITY>
                                }
                                {
                                    for $responseConnector in $serviceResponse/responseConnector
                                    return
                                        <ns1:RESPONSECONNECTOR>{ data($responseConnector) }</ns1:RESPONSECONNECTOR>
                                }
                                <ns1:RESPONSETIME>{ data($serviceResponse/responseTime) }</ns1:RESPONSETIME>
                                {
                                    for $responseData in $serviceResponse/responseData
                                    return
                                        <ns1:RESPONSEDATA>{ data($responseData) }</ns1:RESPONSEDATA>
                                }
                                {
                                    for $responseError in $serviceResponse/responseError
                                    return
                                        <ns1:RESPONSEERROR>{ data($responseError) }</ns1:RESPONSEERROR>
                                }
                                {
                                    for $requestURI in $serviceResponse/requestURI
                                    return
                                        <ns1:REQUESTURI>{ data($requestURI) }</ns1:REQUESTURI>
                                }
                            </ns1:ROUTER_RESPONSE>
                    return
                        $result[1]
                }
            </ns1:REMITTANCE>
        </ns1:sjConsultaMultipleRemesadorasResponse>
};

declare variable $sjConsultaMultipleRemesadoras as element(ns1:sjConsultaMultipleRemesadoras) external;
declare variable $serviceResponse as element() external;
declare variable $remittancePosition as xs:int external;

xf:sjConsultaMultipleRemesadoraOut($sjConsultaMultipleRemesadoras,
    $serviceResponse,
    $remittancePosition)
