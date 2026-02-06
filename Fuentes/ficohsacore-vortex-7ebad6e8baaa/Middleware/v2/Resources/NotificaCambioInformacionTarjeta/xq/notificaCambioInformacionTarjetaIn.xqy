xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$notificaCambioInformacionTarjeta" element="ns1:notificaCambioInformacionTarjeta" location="../../DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/notificaCambioInformacionTarjeta/xsd/notificaCambioInformacionTarjeta_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/notificaCambioInformacionTarjeta";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionTarjetasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaCambioInformacionTarjeta/xq/notificaCambioInformacionTarjetaIn/";

declare function xf:notificaCambioInformacionTarjetaIn($notificaCambioInformacionTarjeta as element(ns1:notificaCambioInformacionTarjeta))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_REQUESTID>{ data($notificaCambioInformacionTarjeta/REQUEST_ID) }</ns0:PV_REQUESTID>
            <ns0:PV_INSTITUTIONCODE>{ data($notificaCambioInformacionTarjeta/INSTITUTION_CODE) }</ns0:PV_INSTITUTIONCODE>
            <ns0:PV_VAULTIDENTIFICATION>{ data($notificaCambioInformacionTarjeta/VAULT_IDENTIFICATION) }</ns0:PV_VAULTIDENTIFICATION>
            {
                for $PAN_REF_ID in $notificaCambioInformacionTarjeta/PAN_REF_ID
                return
                    <ns0:PV_PANREFID>{ data($PAN_REF_ID) }</ns0:PV_PANREFID>
            }
            <ns0:PV_DATETIME>{ data($notificaCambioInformacionTarjeta/DATETIME) }</ns0:PV_DATETIME>
            <ns0:PV_EVENT>{ data($notificaCambioInformacionTarjeta/EVENT) }</ns0:PV_EVENT>
            <ns0:PV_MESSAGEREASONTYPE>{ data($notificaCambioInformacionTarjeta/MESSAGE_REASON_TYPE) }</ns0:PV_MESSAGEREASONTYPE>
            <ns0:PR_ENCRYPTEDOLDCARDINFO>
                <ns0:ALGORITHM>{ data($notificaCambioInformacionTarjeta/ENCRYPTED_OLD_CARD_INFO/ALGORITHM) }</ns0:ALGORITHM>
                {
                    for $NONCE in $notificaCambioInformacionTarjeta/ENCRYPTED_OLD_CARD_INFO/NONCE
                    return
                        <ns0:NONCE>{ data($NONCE) }</ns0:NONCE>
                }
                {
                    for $IV in $notificaCambioInformacionTarjeta/ENCRYPTED_OLD_CARD_INFO/IV
                    return
                        <ns0:IV>{ data($IV) }</ns0:IV>
                }
                <ns0:ENCRYPTEDDATA>{ data($notificaCambioInformacionTarjeta/ENCRYPTED_OLD_CARD_INFO/ENCRYPTED_DATA) }</ns0:ENCRYPTEDDATA>
                {
                    for $ASSOCIATED_DATA in $notificaCambioInformacionTarjeta/ENCRYPTED_OLD_CARD_INFO/ASSOCIATED_DATA
                    return
                        <ns0:ASSOCIATEDDATA>{ data($ASSOCIATED_DATA) }</ns0:ASSOCIATEDDATA>
                }
                <ns0:MACLENGTH>{ data($notificaCambioInformacionTarjeta/ENCRYPTED_OLD_CARD_INFO/MAC_LENGTH) }</ns0:MACLENGTH>
            </ns0:PR_ENCRYPTEDOLDCARDINFO>
            <ns0:PR_ENCRYPTEDNEWCARDINFO>
                <ns0:ALGORITHM>{ data($notificaCambioInformacionTarjeta/ENCRYPTED_NEW_CARD_INFO/ALGORITHM) }</ns0:ALGORITHM>
                {
                    for $NONCE in $notificaCambioInformacionTarjeta/ENCRYPTED_NEW_CARD_INFO/NONCE
                    return
                        <ns0:NONCE>{ data($NONCE) }</ns0:NONCE>
                }
                {
                    for $IV in $notificaCambioInformacionTarjeta/ENCRYPTED_NEW_CARD_INFO/IV
                    return
                        <ns0:IV>{ data($IV) }</ns0:IV>
                }
                <ns0:ENCRYPTEDDATA>{ data($notificaCambioInformacionTarjeta/ENCRYPTED_NEW_CARD_INFO/ENCRYPTED_DATA) }</ns0:ENCRYPTEDDATA>
                {
                    for $ASSOCIATED_DATA in $notificaCambioInformacionTarjeta/ENCRYPTED_NEW_CARD_INFO/ASSOCIATED_DATA
                    return
                        <ns0:ASSOCIATEDDATA>{ data($ASSOCIATED_DATA) }</ns0:ASSOCIATEDDATA>
                }
                <ns0:MACLENGTH>{ data($notificaCambioInformacionTarjeta/ENCRYPTED_NEW_CARD_INFO/MAC_LENGTH) }</ns0:MACLENGTH>
            </ns0:PR_ENCRYPTEDNEWCARDINFO>
        </ns0:InputParameters>
};

declare variable $notificaCambioInformacionTarjeta as element(ns1:notificaCambioInformacionTarjeta) external;

xf:notificaCambioInformacionTarjetaIn($notificaCambioInformacionTarjeta)