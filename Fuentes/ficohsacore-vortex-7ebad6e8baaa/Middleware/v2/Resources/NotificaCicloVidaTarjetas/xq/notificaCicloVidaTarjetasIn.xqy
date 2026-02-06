xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$notificaCicloVidaTarjetas" element="ns1:notificaCicloVidaTarjetas" location="../../DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/NotificaCicloVidaTarjetas/xsd/notificaCicloVidaTarjetas_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/notificaCicloVidaTarjetas";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionTarjetasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaCicloVidaTarjetas/xq/notificaCicloVidaTarjetasIn/";

declare function xf:notificaCicloVidaTarjetasIn($notificaCicloVidaTarjetas as element(ns1:notificaCicloVidaTarjetas))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_REQUESTID>{ data($notificaCicloVidaTarjetas/REQUEST_ID) }</ns0:PV_REQUESTID>
            <ns0:PV_INSTITUTIONCODE>{ data($notificaCicloVidaTarjetas/INSTITUTION_CODE) }</ns0:PV_INSTITUTIONCODE>
            <ns0:PV_VAULTIDENTIFICATION>{ data($notificaCicloVidaTarjetas/VAULT_IDENTIFICATION) }</ns0:PV_VAULTIDENTIFICATION>
            {
                for $WALLET_ID in $notificaCicloVidaTarjetas/WALLET_ID
                return
                    <ns0:PV_WALLETID>{ data($WALLET_ID) }</ns0:PV_WALLETID>
            }
            <ns0:PV_TOKENREQUESTORID>{ data($notificaCicloVidaTarjetas/TOKEN_REQUESTOR_ID) }</ns0:PV_TOKENREQUESTORID>
            <ns0:PV_TOKENREFID>{ data($notificaCicloVidaTarjetas/TOKEN_REF_ID) }</ns0:PV_TOKENREFID>
            <ns0:PV_TOKENTYPE>{ data($notificaCicloVidaTarjetas/TOKEN_TYPE) }</ns0:PV_TOKENTYPE>
            <ns0:PV_DATETIME>{ data($notificaCicloVidaTarjetas/DATETIME) }</ns0:PV_DATETIME>
            <ns0:PV_EVENT>{ data($notificaCicloVidaTarjetas/EVENT) }</ns0:PV_EVENT>
            <ns0:PT_TOKENUSERINFO>
                <ns0:ID>{ data($notificaCicloVidaTarjetas/TOKEN_USER_INFO/ID) }</ns0:ID>
                {
                    for $APP_TYPE in $notificaCicloVidaTarjetas/TOKEN_USER_INFO/APP_TYPE
                    return
                        <ns0:APPTYPE>{ data($APP_TYPE) }</ns0:APPTYPE>
                }
            </ns0:PT_TOKENUSERINFO>
            <ns0:PM_MERCHANTINFO>
                {
                    for $ID in $notificaCicloVidaTarjetas/MERCHANT_INFO/ID
                    return
                        <ns0:ID>{ data($ID) }</ns0:ID>
                }
                {
                    for $MERCHANT_NAME in $notificaCicloVidaTarjetas/MERCHANT_INFO/MERCHANT_NAME
                    return
                        <ns0:MERCHANTNAME>{ data($MERCHANT_NAME) }</ns0:MERCHANTNAME>
                }
            </ns0:PM_MERCHANTINFO>
            {
                for $DEVICE_BINDING_RESULT in $notificaCicloVidaTarjetas/DEVICE_BINDING_RESULT
                return
                    <ns0:PV_DEVICEBINDINGRESULT>{ data($DEVICE_BINDING_RESULT) }</ns0:PV_DEVICEBINDINGRESULT>
            }
            <ns0:PT_DEVICEINFO>
                {
                    for $DEVICE_TYPE in $notificaCicloVidaTarjetas/DEVICE_INFO/DEVICE_TYPE
                    return
                        <ns0:DEVICETYPE>{ data($DEVICE_TYPE) }</ns0:DEVICETYPE>
                }
                {
                    for $DEVICE_NUMBER in $notificaCicloVidaTarjetas/DEVICE_INFO/DEVICE_NUMBER
                    return
                        <ns0:DEVICENUMBER>{ data($DEVICE_NUMBER) }</ns0:DEVICENUMBER>
                }
                {
                    for $DEVICE_NAME in $notificaCicloVidaTarjetas/DEVICE_INFO/DEVICE_NAME
                    return
                        <ns0:DEVICENAME>{ data($DEVICE_NAME) }</ns0:DEVICENAME>
                }
                {
                    for $SERIAL_NUMBER in $notificaCicloVidaTarjetas/DEVICE_INFO/SERIAL_NUMBER
                    return
                        <ns0:SERIALNUMBER>{ data($SERIAL_NUMBER) }</ns0:SERIALNUMBER>
                }
                {
                    for $DEVICE_ID in $notificaCicloVidaTarjetas/DEVICE_INFO/DEVICE_ID
                    return
                        <ns0:DEVICEID>{ data($DEVICE_ID) }</ns0:DEVICEID>
                }
                {
                    for $DEVICE_INDEX in $notificaCicloVidaTarjetas/DEVICE_INFO/DEVICE_INDEX
                    return
                        <ns0:DEVICEINDEX>{ data($DEVICE_INDEX) }</ns0:DEVICEINDEX>
                }
            </ns0:PT_DEVICEINFO>
            <ns0:PT_ENCRYPTEDCARDINFO>
                <ns0:ALGORITHM>{ data($notificaCicloVidaTarjetas/ENCRYPTED_CARD_INFO/ALGORITHM) }</ns0:ALGORITHM>
                {
                    for $NONCE in $notificaCicloVidaTarjetas/ENCRYPTED_CARD_INFO/NONCE
                    return
                        <ns0:NONCE>{ data($NONCE) }</ns0:NONCE>
                }
                {
                    for $IV in $notificaCicloVidaTarjetas/ENCRYPTED_CARD_INFO/IV
                    return
                        <ns0:IV>{ data($IV) }</ns0:IV>
                }
                <ns0:ENCRYPTEDDATA>{ data($notificaCicloVidaTarjetas/ENCRYPTED_CARD_INFO/ENCRYPTED_DATA) }</ns0:ENCRYPTEDDATA>
                {
                    for $ASSOCIATED_DATA in $notificaCicloVidaTarjetas/ENCRYPTED_CARD_INFO/ASSOCIATED_DATA
                    return
                        <ns0:ASSOCIATEDDATA>{ data($ASSOCIATED_DATA) }</ns0:ASSOCIATEDDATA>
                }
                <ns0:MACLENGTH>{ data($notificaCicloVidaTarjetas/ENCRYPTED_CARD_INFO/MAC_LENGTH) }</ns0:MACLENGTH>
            </ns0:PT_ENCRYPTEDCARDINFO>
            <ns0:PT_ENCRYPTEDTOKENINFO>
                <ns0:ALGORITHM>{ data($notificaCicloVidaTarjetas/ENCRYPTED_TOKEN_INFO/ALGORITHM) }</ns0:ALGORITHM>
                {
                    for $NONCE in $notificaCicloVidaTarjetas/ENCRYPTED_TOKEN_INFO/NONCE
                    return
                        <ns0:NONCE>{ data($NONCE) }</ns0:NONCE>
                }
                {
                    for $IV in $notificaCicloVidaTarjetas/ENCRYPTED_TOKEN_INFO/IV
                    return
                        <ns0:IV>{ data($IV) }</ns0:IV>
                }
                <ns0:ENCRYPTEDDATA>{ data($notificaCicloVidaTarjetas/ENCRYPTED_TOKEN_INFO/ENCRYPTED_DATA) }</ns0:ENCRYPTEDDATA>
                {
                    for $ASSOCIATED_DATA in $notificaCicloVidaTarjetas/ENCRYPTED_TOKEN_INFO/ASSOCIATED_DATA
                    return
                        <ns0:ASSOCIATEDDATA>{ data($ASSOCIATED_DATA) }</ns0:ASSOCIATEDDATA>
                }
                <ns0:MACLENGTH>{ data($notificaCicloVidaTarjetas/ENCRYPTED_TOKEN_INFO/MAC_LENGTH) }</ns0:MACLENGTH>
            </ns0:PT_ENCRYPTEDTOKENINFO>
            <ns0:PV_PROCESSID>{ data($notificaCicloVidaTarjetas/PROCESS_ID) }</ns0:PV_PROCESSID>
        </ns0:InputParameters>
};

declare variable $notificaCicloVidaTarjetas as element(ns1:notificaCicloVidaTarjetas) external;

xf:notificaCicloVidaTarjetasIn($notificaCicloVidaTarjetas)