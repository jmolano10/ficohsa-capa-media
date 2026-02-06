xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pushProvisioningNotification" element="ns1:pushProvisioningNotification" location="../../DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/PushProvisioningNotification/xsd/pushProvisioningNotification_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/pushProvisioningNotification";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionTarjetasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PushProvisioningNotification/xq/pushProvisioningNotificationIN/";

declare function xf:pushProvisioningNotificationIN($pushProvisioningNotification as element(ns1:pushProvisioningNotification))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_TOKENREQUESTORID>{ data($pushProvisioningNotification/TOKEN_REQUESTOR_ID) }</ns0:PV_TOKENREQUESTORID>
            <ns0:PV_EVENT>{ data($pushProvisioningNotification/EVENT) }</ns0:PV_EVENT>
            <ns0:PV_ENCRYPTEDPUSHNOTIFICATION>
                <ns0:ALGORITHM>{ data($pushProvisioningNotification/ENCRYPTED_PUSH_NOTIFICATION/ALGORITHM) }</ns0:ALGORITHM>
                {
                    for $NONCE in $pushProvisioningNotification/ENCRYPTED_PUSH_NOTIFICATION/NONCE
                    return
                        <ns0:NONCE>{ data($NONCE) }</ns0:NONCE>
                }
                {
                    for $IV in $pushProvisioningNotification/ENCRYPTED_PUSH_NOTIFICATION/IV
                    return
                        <ns0:IV>{ data($IV) }</ns0:IV>
                }
                <ns0:ENCRYPTEDDATA>{ data($pushProvisioningNotification/ENCRYPTED_PUSH_NOTIFICATION/ENCRYPTED_DATA) }</ns0:ENCRYPTEDDATA>
                {
                    for $ASSOCIATED_DATA in $pushProvisioningNotification/ENCRYPTED_PUSH_NOTIFICATION/ASSOCIATED_DATA
                    return
                        <ns0:ASSOCIATEDDATA>{ data($ASSOCIATED_DATA) }</ns0:ASSOCIATEDDATA>
                }
                <ns0:MACLENGTH>{ data($pushProvisioningNotification/ENCRYPTED_PUSH_NOTIFICATION/MAC_LENGTH) }</ns0:MACLENGTH>
            </ns0:PV_ENCRYPTEDPUSHNOTIFICATION>
        </ns0:InputParameters>
};

declare variable $pushProvisioningNotification as element(ns1:pushProvisioningNotification) external;

xf:pushProvisioningNotificationIN($pushProvisioningNotification)