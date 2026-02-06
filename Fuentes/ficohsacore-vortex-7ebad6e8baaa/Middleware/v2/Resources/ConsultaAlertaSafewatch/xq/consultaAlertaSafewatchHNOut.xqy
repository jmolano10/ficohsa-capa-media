xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$checkAlertAllResponse" element="ns1:checkAlertAllResponse" location="../../../BusinessServices/Safewatch/xsd/safewatchService_schema.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaAlertaSafewatchResponse" location="../xsd/consultaAlertaSafewatchTypes.xsd" ::)

declare namespace ns1 = "http://service/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaAlertaSafewatchTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAlertaSafewatch/xq/consultaAlertaSafewatchHNOut/";

declare function xf:consultaAlertaSafewatchHNOut($checkAlertAllResponse as element(ns1:checkAlertAllResponse))
    as element(ns0:consultaAlertaSafewatchResponse) {
        <ns0:consultaAlertaSafewatchResponse>
            <DETECTION_ID>{ data($checkAlertAllResponse/return/detectionId) }</DETECTION_ID>
            {
                for $globalStatus in $checkAlertAllResponse/return/globalStatus
                return
                    <GLOBAL_STATUS>{ data($globalStatus) }</GLOBAL_STATUS>
            }
            <ALERT_COUNT>{ data($checkAlertAllResponse/return/alertCount) }</ALERT_COUNT>
            {
                for $verifiedAlerts in $checkAlertAllResponse/return/verifiedAlerts
                return
                    <VERIFIED_ALERTS>
                        {
                            for $alert in $verifiedAlerts/alert
                            return
                                <ALERT>
                                    <ID>{ data($alert/id) }</ID>
                                    {
                                        for $status in $alert/status
                                        return
                                            <STATUS>{ data($status) }</STATUS>
                                    }
                                </ALERT>
                        }
                    </VERIFIED_ALERTS>
            }
        </ns0:consultaAlertaSafewatchResponse>
};

declare variable $checkAlertAllResponse as element(ns1:checkAlertAllResponse) external;

xf:consultaAlertaSafewatchHNOut($checkAlertAllResponse)