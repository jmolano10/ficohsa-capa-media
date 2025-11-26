xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://service.webserviceprovider.transporters.service.frametexx.com/";
(:: import schema at "../../../../ProviderServices/XSD/RouterConventions/XMLSchema_654181198.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/sjGgetMultipleRemittancesTypes";
(:: import schema at "../../../../../MWBanking/Remittances/RequestorServices/XSD/sjGetMultipleRemittancesTypes.xsd" ::)

declare variable $sjGetMultipleRemittances as element() (:: schema-element(ns1:sjGetMultipleRemittancesRequest) ::) external;
declare variable $remittancePosition as xs:int external;
declare variable $serviceResponse as element() (:: schema-element(ns2:serviceResponse) ::) external;

declare function local:func($sjGetMultipleRemittances as element() (:: schema-element(ns1:sjGetMultipleRemittancesRequest) ::), 
                            $remittancePosition as xs:int, 
                            $serviceResponse as element() (:: schema-element(ns2:serviceResponse) ::)) 
                            as element() (:: schema-element(ns1:sjGetMultipleRemittancesResponse) ::) {
    <ns1:sjGetMultipleRemittancesResponse>
        <ns1:Remittance>
          {
              let $result :=
                  for $serviceResponse in $serviceResponse,
                      $TypesRemittanceItem in $sjGetMultipleRemittances/ns1:TypesRemittance/ns1:TypesRemittanceItem,
                      $TypesRemittance in $sjGetMultipleRemittances/ns1:TypesRemittance
              return
            <ns1:RouterResponse>
                {
                    for $NAME_REMITTANCE in $TypesRemittance/ns1:TypesRemittanceItem[$remittancePosition]/ns1:NameRemittance
                    return 
                        <ns1:NameRemittance>{fn:data($NAME_REMITTANCE)}</ns1:NameRemittance>
                }
                {
                    for $TYPE_REMITTANCE in $TypesRemittance/ns1:TypesRemittanceItem[$remittancePosition]/ns1:TypeRemittance
                    return 
                        <ns1:TypeRemittance>{fn:data($TYPE_REMITTANCE)}</ns1:TypeRemittance>
                }
                {
                    for $AGREEMENT_ID in $TypesRemittance/ns1:TypesRemittanceItem[$remittancePosition]/ns1:AgreementId
                    return 
                        <ns1:AgreementId>{fn:data($AGREEMENT_ID)}</ns1:AgreementId>
                }
                {
                    for $AGREEMENT_ID_T24 in $TypesRemittance/ns1:TypesRemittanceItem[$remittancePosition]/ns1:AgreementIdT24
                    return 
                        <ns1:AgreementIdT24>{fn:data($AGREEMENT_ID_T24)}</ns1:AgreementIdT24>
                }
                {
                    for $ABBREVIATION_REMITTANCE in $TypesRemittance/ns1:TypesRemittanceItem[$remittancePosition]/ns1:AbbreviationRemittance
                    return 
                        <ns1:AbbreviationRemittance>{fn:data($ABBREVIATION_REMITTANCE)}</ns1:AbbreviationRemittance>
                }
                {
                    for $PRIORITY in $TypesRemittance/ns1:TypesRemittanceItem[$remittancePosition]/ns1:Priority
                    return 
                        <ns1:Priority>{fn:data($PRIORITY)}</ns1:Priority>
                }
                {
                    for $responseConnector in $serviceResponse/responseConnector
                    return 
                        <ns1:ResponseConnector>{fn:data($responseConnector)}</ns1:ResponseConnector>
                }
                <ns1:ResponseTime>{fn:data($serviceResponse/responseTime)}</ns1:ResponseTime>
                {
                    for $responseData in $serviceResponse/responseData
                    return 
                        <ns1:ResponseData>{fn:data($responseData)}</ns1:ResponseData>
                }
                {
                    for $responseError in $serviceResponse/responseError
                    return 
                        <ns1:ResponseError>{fn:data($responseError)}</ns1:ResponseError>
                }
                {
                    for $requestURI in $serviceResponse/requestURI
                    return 
                        <ns1:RequestUri>{fn:data($requestURI)}</ns1:RequestUri>
                }
            </ns1:RouterResponse>
            return
              $result[1]
        }
        </ns1:Remittance>
    </ns1:sjGetMultipleRemittancesResponse>
};

local:func($sjGetMultipleRemittances, $remittancePosition, $serviceResponse)
