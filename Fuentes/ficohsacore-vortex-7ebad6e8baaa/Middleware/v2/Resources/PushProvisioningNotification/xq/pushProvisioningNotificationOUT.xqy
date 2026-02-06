xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/PushProvisioningNotification/xsd/pushProvisioningNotification_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pushProvisioningNotificationResponse" location="../../DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionTarjetasTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/pushProvisioningNotification";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PushProvisioningNotification/xq/pushProvisioningNotificationOUT/";

declare function xf:pushProvisioningNotificationOUT($outputParameters as element(ns0:OutputParameters))
    as element(ns1:pushProvisioningNotificationResponse) {
        <ns1:pushProvisioningNotificationResponse>
            {
                for $PV_RETURNCODE in $outputParameters/ns0:PV_RETURNCODE
                return
                    <RETURN_CODE>{ data($PV_RETURNCODE) }</RETURN_CODE>
            }
            {
                for $PV_ERRORDESCRIPTION in $outputParameters/ns0:PV_ERRORDESCRIPTION
                return
                    <ERROR_DESCRIPTION>{ data($PV_ERRORDESCRIPTION) }</ERROR_DESCRIPTION>
            }
        </ns1:pushProvisioningNotificationResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:pushProvisioningNotificationOUT($outputParameters)