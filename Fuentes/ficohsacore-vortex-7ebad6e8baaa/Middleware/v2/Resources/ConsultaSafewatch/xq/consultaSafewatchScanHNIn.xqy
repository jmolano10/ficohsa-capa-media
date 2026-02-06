xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSafewatchRequest1" element="ns1:consultaSafewatchRequest" location="../../ConsultaSafewatch/xsd/consultaSafewatchTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:scan" location="../xsd/SafewatchService_schema1.xsd" ::)

declare namespace ns0 = "http://service/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaSafewatchTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Safewatch/xq/ScanIN/";

declare function xf:ScanIN($consultaSafewatchRequest1 as element(ns1:consultaSafewatchRequest),
    $sourceBank as xs:string)
    as element(ns0:scan) {
        <ns0:scan>
            <request>
                <sourceBank>{ $sourceBank }</sourceBank>
                <format>{ data($consultaSafewatchRequest1/FORMAT) }</format>
                <data>{ data($consultaSafewatchRequest1/DATA) }</data>
                {
                    for $FORMAT_NAME in $consultaSafewatchRequest1/FORMAT_NAME
                    return
                        <formatName>{ data($FORMAT_NAME) }</formatName>
                }
                {
                    for $ADDRESS in $consultaSafewatchRequest1/ADDRESS
                    return
                        <address>{ data($ADDRESS) }</address>
                }
                {
                    for $BIC in $consultaSafewatchRequest1/BIC
                    return
                        <bic>{ data($BIC) }</bic>
                }
                {
                    for $CITY in $consultaSafewatchRequest1/CITY
                    return
                        <city>{ data($CITY) }</city>
                }
                {
                    for $CONTEXT in $consultaSafewatchRequest1/CONTEXT
                    return
                        <context>{ data($CONTEXT) }</context>
                }
                {
                    for $COUNTRY in $consultaSafewatchRequest1/COUNTRY
                    return
                        <country>{ data($COUNTRY) }</country>
                }
                {
                    for $RECORD_ID in $consultaSafewatchRequest1/RECORD_ID
                    return
                        <recordId>{ data($RECORD_ID) }</recordId>
                }
                {
                    for $RECORD_LOCATION in $consultaSafewatchRequest1/RECORD_LOCATION
                    return
                        <recordLocation>{ data($RECORD_LOCATION) }</recordLocation>
                }
                <checkVessels>{ data($consultaSafewatchRequest1/CHECK_VESSELS) }</checkVessels>
                <checkCountry>{ data($consultaSafewatchRequest1/CHECK_COUNTRY) }</checkCountry>
                <autoCreateAlert>{ data($consultaSafewatchRequest1/AUTO_CREATE_ALERT) }</autoCreateAlert>
                <positiveDetection>{ data($consultaSafewatchRequest1/POSITIVE_DETECTION) }</positiveDetection>
                <fullReport>{ data($consultaSafewatchRequest1/FULL_REPORT) }</fullReport>
                {
                    for $RECORD_XPATH in $consultaSafewatchRequest1/RECORD_XPATH
                    return
                        <recordXPath>{ data($RECORD_XPATH) }</recordXPath>
                }
            </request>
        </ns0:scan>
};

declare variable $consultaSafewatchRequest1 as element(ns1:consultaSafewatchRequest) external;
declare variable $sourceBank as xs:string external;

xf:ScanIN($consultaSafewatchRequest1,
    $sourceBank)