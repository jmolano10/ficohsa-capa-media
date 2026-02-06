xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaAlertaSafewatchRequest" element="ns0:consultaAlertaSafewatchRequest" location="../xsd/consultaAlertaSafewatchTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:checkAlertAll" location="../../../BusinessServices/Safewatch/xsd/safewatchService_schema.xsd" ::)

declare namespace ns1 = "http://service/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaAlertaSafewatchTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAlertaSafewatch/xq/consultaAlertaSafewatchHNIn/";

declare function xf:consultaAlertaSafewatchHNIn($sourceBank as xs:string,
    $consultaAlertaSafewatchRequest as element(ns0:consultaAlertaSafewatchRequest))
    as element(ns1:checkAlertAll) {
        <ns1:checkAlertAll>
            <request>
                <sourceBank>{ $sourceBank }</sourceBank>
                <detectionId>{ data($consultaAlertaSafewatchRequest/DETECTION_ID) }</detectionId>
            </request>
        </ns1:checkAlertAll>
};

declare variable $sourceBank as xs:string external;
declare variable $consultaAlertaSafewatchRequest as element(ns0:consultaAlertaSafewatchRequest) external;

xf:consultaAlertaSafewatchHNIn($sourceBank,
    $consultaAlertaSafewatchRequest)